package com.rocket.seoj.logistics.controller;


import com.rocket.jsy.employee.model.dto.Employee;
import com.rocket.seoj.logistics.model.dto.PrdAttach;
import com.rocket.seoj.logistics.model.dto.PrdAttachWrapper;
import com.rocket.seoj.logistics.model.dto.Product;
import com.rocket.seoj.logistics.model.dto.Publisher;
import com.rocket.seoj.logistics.model.service.ProductService;
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
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/logistics")
@RequiredArgsConstructor
@Slf4j
public class ProductController {

    private final ProductService service;

    @PostMapping("/product/list/tableupdate")
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

    @PostMapping("product/list/delete")
    public ResponseEntity<?> isdelUpdateProduct(@RequestParam("prd_id") Long prdId) {

        boolean deletionSuccess = service.isdelUpdateProduct(prdId);


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


    @PostMapping("product/list/insert")
    public ResponseEntity<?> insertProduct(@RequestParam("files") MultipartFile[] upFile,

                                           @ModelAttribute Product formdata1,
                                           @ModelAttribute Publisher pub,
                                           PrdAttachWrapper fileList,
//                                               List<PrdInventory> prdInventory,
//                                               @RequestParam("prdInventory") String prdInventory,
//                                               @ModelAttribute PrdInventoryWrapper prdInventory,
//                                               @RequestBody List<PrdInventory> prdInventory,
//                                               @RequestParam("tableData") String tableData,
//                                               Inventory inv,
//                                               InventoryFileWrapper invAttach,
                                           Model model,
                                           HttpSession session
//                                               @ModelAttribute Inventory formData
//                                               @RequestParam("formData") Object formData,
    ) {

        long generatedId = service.insertProduct(formdata1);

        Employee loginemp = (Employee)SecurityContextHolder
                .getContext()
                .getAuthentication()
                .getPrincipal();
        model.addAttribute("loginemp", loginemp);

        String path = session
                .getServletContext()
                .getRealPath("/resources/upload/logistics");

        Date currentDateTime = new Date();
        if (upFile != null) {
            for (MultipartFile mf : upFile) {
                if (!mf.isEmpty()) {
                    String oriName = mf.getOriginalFilename();
                    String ext = oriName.substring(oriName.lastIndexOf("."));
                    Date today = new Date(System.currentTimeMillis());
                    int randomNum = (int)(Math.random() * 10000) + 1;
                    String rename = "Rocket_Product_File_" + (new SimpleDateFormat("yyyyMMddHHmmssSSS").format(
                            today)) + "_" + randomNum + ext;
                    try {
                        mf.transferTo(new File(path, rename));
                        PrdAttach file = PrdAttach
                                .builder()

                                .prdId(formdata1.getPrdId())
                                .prdFileNameOri(oriName)
                                .prdFileNameRe(rename)
                                .prdAttachIsdel("N")
                                .prdFileUploadDate(currentDateTime)
                                .build();

                        fileList
                                .getPrdAttach()
                                .add(file);
                    } catch (IOException | DataAccessException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        List<Integer> result2 = null;
        if (upFile != null) {
            for (PrdAttach attach : fileList.getPrdAttach()) {
                attach.setPrdId(formdata1.getPrdId());
            }
            result2 = service.insertProductAttach(fileList.getPrdAttach());
        }
        for (Integer result : result2) {
            if (result == 0) {
                return ResponseEntity
                        .status(HttpStatus.INTERNAL_SERVER_ERROR)
                        .body(Map.of("message", "실패 : 파일 추가 실패", "status", "error"));
            }
        }
        if (formdata1.getPrdId() != 0) {
            return ResponseEntity
                    .ok()
                    .body(Map.of("message", "추가 완료", "status", "success", "selectKey", formdata1.getPrdId(),
                                 "prdFileNameRe", fileList
                                         .getPrdAttach()
                                         .get(0)
                                         .getPrdFileNameRe()));
        } else {

            return ResponseEntity
                    .status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("message", "추가 실패", "status", "error"));
        }
    }
    @RequestMapping("/product/list")
    public String selectAllProductAndPublisherAndFiles(Model model) {

        List<Map<String, Object>> productAndFileList = service.selectAllProductAndPublisherAndFiles();
        List<Map<String, Object>> publisherList = service.selectAllPublisher();

        // iv_id 중복 제거를 위한 코드
        Set<Object> uniquePrdIds = new HashSet<>();
        List<Map<String, Object>> uniqueProductData = new ArrayList<>();


        for (Map<String, Object> data : productAndFileList) {
            Object prdId = data.get("PRD_ID");

            if (uniquePrdIds.add(prdId)) {
                uniqueProductData.add(data);
            }
        }


        model.addAttribute("uniqueProductList", uniqueProductData);
        model.addAttribute("productAndFileList", productAndFileList);
        model.addAttribute("publisherList", publisherList);
        return "logistics/productPage";
    }

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

    public void printFieldNames(Object obj) {
        Class<?> objClass = obj.getClass();
        Field[] fields = objClass.getDeclaredFields();

        log.debug("Field names of class " + objClass.getName() + ":");
        for (Field field : fields) {
            log.debug(field.getName());
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
