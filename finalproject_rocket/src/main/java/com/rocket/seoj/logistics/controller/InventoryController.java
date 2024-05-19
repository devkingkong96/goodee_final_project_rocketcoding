package com.rocket.seoj.logistics.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rocket.jsy.employee.model.dto.Employee;
import com.rocket.seoj.logistics.model.dto.Inventory;
import com.rocket.seoj.logistics.model.dto.InventoryAttach;
import com.rocket.seoj.logistics.model.dto.InventoryFileWrapper;
import com.rocket.seoj.logistics.model.dto.PrdInventory;
import com.rocket.seoj.logistics.model.service.InventoryService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.Reader;
import java.lang.reflect.Field;
import java.sql.Clob;
import java.sql.SQLException;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequiredArgsConstructor
@Slf4j
public class InventoryController {

    private final InventoryService service;
    private Map<String, String> tableIdColumnMap = new HashMap<String, String>() {

        {
            put("EMPLOYEE", "EMP_NO");
            put("INVENTORY", "IV_ID");
            put("BRANCH", "BRANCH_ID");
            put("STOCK", "STK_ID");
            put("PUBLISHER", "PUB_ID");
            put("PRODUCT", "PRD_ID");
            put("PRD_ATTACH", "PRD_FILE_ID");
            put("PRDINVENTORY", "PRD_IV_ID");
            put("INVENTORY_ATTACH", "IV_FILE_ID");
            put("TAG", "DOC_TAG");
            put("DOCUMENT", "DOC_NO");
            put("APPROVAL", "APRV_NO");
            put("APPROVAL_FILE", "APRVFILE_NO");
        }
    };

    @PostMapping("/logistics/inventory/list/tableupdate")
    public ResponseEntity<?> updateTable(SQLException ex,
                                         @RequestParam("id") long id,
                                         @RequestParam("columnName") String columnName,
                                         @RequestParam("tableName") String tableName,
                                         @RequestParam("value") String value,
                                         @RequestParam("parentTableName") String parentTableName,
                                         @RequestParam("parentColumnName") String parentColumnName) throws DataAccessException {

        String parentColumnId = tableIdColumnMap.get(parentTableName.toUpperCase());
        String columnId = tableIdColumnMap.get(tableName);

        if (parentColumnName.equals("IV_VAT_TYPE")) {
            value = value.toUpperCase();
        }

        int result = 0;

        try {

            result = service.updateColumn(id, columnName, tableName.toUpperCase(), value, parentTableName.toUpperCase(),
                                          parentColumnId, parentColumnName, columnId);
//            log.debug("result : " + result);

            if (result > 0) {

                return ResponseEntity
                        .ok()
                        .body("업데이트 성공");
            } else {

                return ResponseEntity
                        .badRequest()
                        .body("업데이트 실패");
            }
        } catch (DataAccessException e) {
            return ResponseEntity
                    .badRequest()
                    .body("업데이트 실패");
        }

    }

    @RequestMapping("/logistics/inventory/write/branchempinfo")
    public ResponseEntity<?> branchempinfo(@RequestParam("branchId") long branchId) {
        List<Map<String, Object>> empInfoBybrc = service.branchempinfo(branchId);

        if (empInfoBybrc.isEmpty()) {
            return ResponseEntity
                    .noContent()
                    .build();
        }
        return ResponseEntity.ok(empInfoBybrc);

    }


    @RequestMapping("/logistics/inventory/write/prdinfo")
    public ResponseEntity<?> prdinfo(@RequestParam("prdId") long id) {
        Map<String, Object> prdInfo = service.getProductInfo(id);

        if (prdInfo.isEmpty()) {
            return ResponseEntity
                    .noContent()
                    .build();
        }

        NumberFormat formatter = NumberFormat.getNumberInstance(Locale.US);

        String[] keys = { "PRD_PRICE", "PRICE_IN_STK" };
        for (String key : keys) {
            if (prdInfo.containsKey(key) && prdInfo.get(key) != null) {
                try {

                    Number number = (Number)prdInfo.get(key);
                    String formatted = formatter.format(number);
                    prdInfo.put(key, formatted);
                } catch (ClassCastException e) {
                    log.debug(key + " is not a number.");
                }
            }
        }
        return ResponseEntity.ok(prdInfo);

    }

    public List<PrdInventory> convertJsonToPrdInventoryList(String json) {
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            return objectMapper.readValue(json, new TypeReference<List<PrdInventory>>() {
            });
        } catch (IOException e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }

    @PostMapping("/logistics/inventory/endwrite")
    public String endWriteInventory(@RequestParam(name = "files", required = false) MultipartFile[] upFile,
//                                               List<PrdInventory> prdInventory,
                                    @RequestParam("prdInventory") String prdInventory,
//                                               @ModelAttribute PrdInventoryWrapper prdInventory,
//                                               @RequestBody List<PrdInventory> prdInventory,
//                                               @RequestParam("tableData") String tableData,
                                    Inventory inv,
                                    InventoryFileWrapper invAttach,
                                    Model model,
                                    HttpSession session,
                                    @ModelAttribute Inventory formData,
//                                               @RequestParam("aprvEmp") String aprvEmpList,
                                    @RequestParam(name = "inventoryInfoForCreateDocument", required = false) ArrayList<Map<String, Object>> inventoryInfoForCreateDocument
            /*, RedirectAttributes redirectAttributes*/

//                                               @RequestParam("formData") Object formData,
    ) {

        Employee loginemp = (Employee)SecurityContextHolder
                .getContext()
                .getAuthentication()
                .getPrincipal();
        model.addAttribute("loginemp", loginemp);

        List<PrdInventory> prdInventoryList = convertJsonToPrdInventoryList(prdInventory);

        String path = session
                .getServletContext()
                .getRealPath("/resources/upload/logistics");

        formData.setSendEmpId(loginemp.getEmpNo());
        long generatedId = service.insertInventory(formData);

        List<InventoryAttach> fileList = new ArrayList<>();

        if (upFile != null) {
            for (MultipartFile mf : upFile) {

                if (!mf.isEmpty()) {

                    String oriName = mf.getOriginalFilename();
                    String ext = oriName.substring(oriName.lastIndexOf("."));
                    Date today = new Date(System.currentTimeMillis());
                    int randomNum = (int)(Math.random() * 10000) + 1;
                    String rename = "Rocket_Inventory_File_" + (new SimpleDateFormat("yyyyMMddHHmmssSSS").format(
                            today)) + "_" + randomNum + ext;
                    try {

                        mf.transferTo(new File(path, rename));
                        InventoryAttach file = InventoryAttach
                                .builder()
                                .ivId(generatedId)
                                .ivFileNameOri(oriName)
                                .ivFileNameRe(rename)
                                .ivAttachIsdel("N")
                                .build();

                        fileList.add(file);
                    } catch (IOException | DataAccessException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        formData.setSendEmpId(loginemp.getEmpNo());
        formData.setSendBrcId((long)loginemp.getBranchId());

        List<Integer> result2 = null;
        if (upFile != null) {
            for (InventoryAttach attach : fileList) {
                attach.setIvId(generatedId);
            }

            result2 = service.insertInventoryAttach(fileList);

        }

        for (PrdInventory prdIv : prdInventoryList) {
            prdIv.setIvId(generatedId);
        }

        List<Integer> result3 = service.insertPrdInventory(prdInventoryList);

        if (generatedId > 0) {

            Map<String, Object> paramMap = new HashMap<>();

            paramMap.put("empNo", loginemp.getEmpNo());

            inventoryInfoForCreateDocument = service.getInventoryInfoForCreateDocument(generatedId);

            session.setAttribute("inventoryInfo", inventoryInfoForCreateDocument);

            return "redirect:/docu/insertaprv";
        }
        return "redirect:/docu/insertaprv";
    }

    public void printFieldNames(Object obj) {
        Class<?> objClass = obj.getClass();
        Field[] fields = objClass.getDeclaredFields();

        log.debug("Field names of class " + objClass.getName() + ":");
        for (Field field : fields) {
            log.debug(field.getName());
        }
    }

    @RequestMapping("/logistics/inventory/write")
    public String inventoryWrite(Model model) {

        Employee loginemp = (Employee)SecurityContextHolder
                .getContext()
                .getAuthentication()
                .getPrincipal();
        model.addAttribute("loginemp", loginemp);

        List<Map<String, Object>> empListByemployeeId = service.getEmpListByemployeeId();
        List<Map<String, Object>> branchList = service.selectAllBranch();

        List<Map<String, Object>> writeInventoryItem = service.selectWriteInventory();
        List<Map<String, Object>> selectAllProduct = service.selectAllProduct();

        Map<Object, Object> prdTitleToIdMap = new HashMap<>();
        Set<Object> prdTitles = new HashSet<>();


        for (Map<String, Object> item : writeInventoryItem) {
            Object title = item.get("PRD_TITLE");
            Object id = item.get("PRD_ID");
            if (title != null && prdTitles.add(title)) {
                prdTitleToIdMap.put(title, id);
            }
        }

        ObjectMapper prdTitleToJson = new ObjectMapper();

        try {
            String jsonMap = prdTitleToJson.writeValueAsString(prdTitleToIdMap);

            model.addAttribute("jsonMap", jsonMap);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
        model.addAttribute("selectAllProduct", selectAllProduct);
        model.addAttribute("empListByemployeeId", empListByemployeeId);
        model.addAttribute("branchList", branchList);
        model.addAttribute("prdTitleToIdMap", prdTitleToIdMap);
        model.addAttribute("writeInventoryItem", writeInventoryItem);

        return "logistics/inventoryWrite";
    }

    @RequestMapping("/logistics/inventory/list")
    public String selectAllInventories(Model model) {

        Employee loginemp = (Employee)SecurityContextHolder
                .getContext()
                .getAuthentication()
                .getPrincipal();
        model.addAttribute("loginemp", loginemp);


        List<Map<String, Object>> inventories = service.selectAllInventories(loginemp.getBranchId());

        Set<Object> uniqueIvIds = new HashSet<>();
        List<Map<String, Object>> uniqueInventoryData = new ArrayList<>();

        for (Map<String, Object> data : inventories) {
            Object ivId = data.get("IV_ID");

            if (uniqueIvIds.add(ivId)) {
                uniqueInventoryData.add(data);
            }
        }

        model.addAttribute("inventories", uniqueInventoryData);
        return "logistics/inventoryList";
    }

    @PostMapping("/logistics/inventory/list/delete")
    public ResponseEntity<?> deleteInventoryAndAttachments(@RequestParam("iv_id") Long inventoryId) {
        boolean deletionSuccess = service.deleteInventoryAndAttachmentAndPrdIv(inventoryId);

        if (deletionSuccess) {

            return ResponseEntity
                    .ok()
                    .body(Map.of("message", "삭제 성공", "status", "success"));
        } else {

            return ResponseEntity
                    .status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("message", "삭제 실패", "status", "error"));
        }
    }
    public String clobToString(Clob data) {
        StringBuilder sb = new StringBuilder();

        try {
            Reader reader = data.getCharacterStream();
            BufferedReader br = new BufferedReader(reader);

            String line;

            while (null != (line = br.readLine())) {
                sb.append(line);
            }
            br.close();
        } catch (SQLException | IOException e) {

        }
        return sb.toString();
    }
}
