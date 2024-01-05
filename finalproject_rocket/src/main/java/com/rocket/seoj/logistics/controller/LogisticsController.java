package com.rocket.seoj.logistics.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.Reader;
import java.lang.reflect.Field;
import java.sql.Clob;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;

import com.rocket.seoj.logistics.model.dto.Inventory;
import com.rocket.seoj.logistics.model.dto.InventoryAttach;
import jakarta.servlet.http.HttpSession;
import org.springframework.dao.DataAccessException;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rocket.seoj.logistics.model.service.LogisticsService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.multipart.MultipartFile;

/**
 * Brief description of functions
 *
 * @author J
 * @version 2023-12-25
 */
@Controller
@RequestMapping("/logistics")
@RequiredArgsConstructor
@Slf4j
public class LogisticsController {

    private final LogisticsService service;
	
	/*	@ExceptionHandler (DataAccessException.class)
		public ResponseEntity<Object>
		       handleDataAccessException(DataAccessException ex,
		                                 WebRequest request) {
			Map<String, Object> body = new LinkedHashMap<>();
			body.put("timestamp", LocalDateTime.now());
			body.put("message", "업데이트 실패");
	
			return new ResponseEntity<>(body, HttpStatus.BAD_REQUEST);
		}*/

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

    @PostMapping("/inventory/list/tableupdate")
    public ResponseEntity<?> updateTable(SQLException ex,
                                         @RequestParam("id") long id,
                                         @RequestParam("columnName") String columnName,
                                         @RequestParam("tableName") String tableName,
                                         @RequestParam("value") String value,
                                         @RequestParam("parentTableName") String parentTableName,
                                         @RequestParam("parentColumnName") String parentColumnName) throws DataAccessException {
        System.out.println("parentTableName : " + parentTableName);

        String parentColumnId = tableIdColumnMap.get(parentTableName.toUpperCase());
        String columnId = tableIdColumnMap.get(tableName);

        if (parentColumnName.equals("IV_VAT_TYPE")) {
            value = value.toUpperCase();
        }

        System.out.println("ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ컨트롤러ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ" + String.valueOf(
                id) + ", " + columnName + ", " + tableName + ", " + value + ", " + parentTableName + ", " + parentColumnId + ", " + parentColumnName + ", " + columnId);

        System.out.println("업데이트 실행합니다");
        int result = 0;

        try {

            result = service.updateColumn(id, columnName, tableName.toUpperCase(), value, parentTableName.toUpperCase(),
                                          parentColumnId, parentColumnName, columnId);
            System.out.println("result : " + result);

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

    @RequestMapping("inventory/write/prdinfo")
    public ResponseEntity<?> getProductInfo(@RequestParam("prdId") long id) {
        Map<String, Object> prdInfo = service.getProductInfo(id);

        if (prdInfo.isEmpty()) {
            return ResponseEntity
                    .noContent()
                    .build();
        }
        log.debug("prdInfo: {}", prdInfo);
        return ResponseEntity.ok(prdInfo);

    }

    @RequestMapping("inventory/endwrite")
    public ResponseEntity<?> endWriteInventory(@RequestParam("files") MultipartFile[] upFile,
                                               @RequestParam("tableData") String tableData,
                                               Inventory inv,
                                               InventoryAttach invAttach,
                                               Model model,
                                               HttpSession session,
                                               @ModelAttribute Inventory formData
//                                               @RequestParam("formData") Object formData,
    ) {
        String path = session
                .getServletContext()
                .getRealPath("/resources/upload/logistics");
/*        try {
            ObjectMapper objectMapper = new ObjectMapper();
            String json = objectMapper.writeValueAsString(formData);
            System.out.println("JSON: " + json);
            // 이제 json 변수에 formData의 JSON 표현이 저장되어 있습니다.
        } catch (Exception e) {
            e.printStackTrace();
            // JSON 변환 중 발생한 오류 처리
        }*/

//        System.out.println("ivType: " + ivType);
//        printFieldNames(formData);
//        System.out.println("formData: " + formData.toString());
      /*  System.out.println("formData: " + formData
                .getClass()
                .getName());
*/
        if (upFile != null) {
            for (MultipartFile mf : upFile) {
//				if(!upFile.isEmpty()) {
                if (!mf.isEmpty()) {
//					String oriName=upFile.getOriginalFilename();
                    String oriName = mf.getOriginalFilename();
                    String ext = oriName.substring(oriName.lastIndexOf("."));
                    Date today = new Date(System.currentTimeMillis());
                    int randomNum = (int)(Math.random() * 10000) + 1;
                    String rename = "Rocket_Inventory_File_" + (new SimpleDateFormat("yyyyMMddHHmmssSSS").format(
                            today)) + "_" + randomNum + ext;
                    try {
//						upFile.transferTo(new File(path,rename));
                        mf.transferTo(new File(path, rename));
                        InventoryAttach file = InventoryAttach
                                .builder()
                                .ivFileNameOri(oriName)
                                .ivFileNameRe(rename)
                                .ivAttachIsdel("N")
                                .build();


                    } catch (IOException | DataAccessException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        System.out.println("컨트롤러 inv : " + inv);
        System.out.println("컨트롤러 invAttach : " + invAttach);
        System.out.println("컨트롤러 formData : " + formData);
//        System.out.println("formDataJson: " + (String)formData);
        System.out.println("컨트롤러 tableData: " + tableData);

        System.out.println("깐트롤라");

        int result = service.insertInventory(formData);

        if (result > 0) {
            return ResponseEntity.ok("입고 등록 성공");
        } else {
            return ResponseEntity
                    .badRequest()
                    .body("입고 등록 실패");
        }
//        return ResponseEntity.ok(tableData);
    }

    public void printFieldNames(Object obj) {
        Class<?> objClass = obj.getClass();
        Field[] fields = objClass.getDeclaredFields();

        System.out.println("Field names of class " + objClass.getName() + ":");
        for (Field field : fields) {
            System.out.println(field.getName());
        }
    }

    @RequestMapping("inventory/write")
    public String inventoryWrite(Model model) {
		/*		List<Map> inventories = service.selectAllInventories();
				model.addAttribute("inventories", inventories);*/
        List<Map<String, Object>> writeInventoryItem = service.selectWriteInventory();

        Map<Object, Object> prdTitleToIdMap = new HashMap<>(); // PRD_TITLE을 키로, PRD_ID를 값으로 하는 맵
        Set<Object> prdTitles = new HashSet<>(); // 중복 제거를 위한 Set

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
            System.out.println();
            model.addAttribute("jsonMap", jsonMap);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }

        model.addAttribute("prdTitleToIdMap", prdTitleToIdMap);
        model.addAttribute("writeInventoryItem", writeInventoryItem);
        return "logistics/inventoryWrite";
    }

    @RequestMapping("inventory/list")
    public String getAllItems(Model model) {
		/*		List<Map> inventories = service.selectAllInventories();
				model.addAttribute("inventories", inventories);*/
        List<Map<String, Object>> inventories = service.selectAllInventories();

        // iv_id 중복 제거를 위한 코드
        Set<Object> uniqueIvIds = new HashSet<>();
        List<Map<String, Object>> uniqueInventoryData = new ArrayList<>();

        for (Map<String, Object> data : inventories) {
            Object ivId = data.get("IV_ID");

            if (uniqueIvIds.add(ivId)) {
                uniqueInventoryData.add(data);
            }
        }
		
		/*		for (Map<String, Object> inventory : inventories) {
					Object ivDate = inventory.get("IV_DATE");
					
					if (ivDate != null) {
						System.out.println("IV_DATE의 자료형: " + ivDate.getClass().getName());
					} else {
						System.out.println("IV_DATE 키에 해당하는 값이 없습니다.");
					}
				}*/
        System.out.println();
        model.addAttribute("inventories", uniqueInventoryData);
        return "logistics/inventoryList";
    }

    @PostMapping("inventory/list/delete")
    public String deleteInventoryAndAttachments(@RequestParam("iv_id") Long inventoryId, Model model) {
        System.out.println("ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ딜리트ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ " + inventoryId);
        boolean deletionSuccess = service.deleteInventoryAndAttachmentAndPrdIv(inventoryId); // 서비스 레이어에서 삭제 로직 수행

        String msg, loc;

        if (deletionSuccess) {
            msg = "삭제 성공";
            loc = "logistics/inventory/list";
        } else {
            msg = "삭제 실패";
            loc = "logistics/inventory/list";
        }
        model.addAttribute("msg", msg);
        model.addAttribute("loc", loc);
		/*	ModelAndView modelAndView = new ModelAndView();
			modelAndView.setViewName("redirect:/inventory/list"); // 삭제 후 리다이렉트할 페이지
			return modelAndView;*/
        return "logistics/common/msg";
    }

    @GetMapping("/inventories")
    @ResponseBody
    public List<Map<String, Object>> getInventories() {
        List<Map<String, Object>> items = service.selectAllInventories();

        for (Map<String, Object> item : items) {

            for (Map.Entry<String, Object> entry : item.entrySet()) {

                if (entry.getValue() instanceof Clob) {
                    Clob clobData = (Clob)entry.getValue();
                    String convertedValue = clobToString(clobData);
                    entry.setValue(convertedValue);
                }
            }
        }

        return items;
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
	
	/*	@Controller
		@RequestMapping ("/logistics")
		@RequiredArgsConstructor
		public class LogisticsController {
	
			private final LogisticsService service;
	
			@GetMapping ("/List") @ResponseBody
			public Map<String, Object> getAllItems(Model model) {
				List<Inventory> inventories = service.selectAllInventories();
				model.addAttribute("inventories", inventories);
	
				Map<String, Object> response = new HashMap<>();
				response.put("data", inventories);
				response.put("recordsTotal", inventories.size());
				response.put("recordsFiltered", inventories.size());
				return response;
			}*/
	
	/*	@GetMapping ("/index")
		public ResponseEntity<List<Inventory>> getAllItems() {
			List<Inventory> items = service.selectAllInventories();
	
			if (items.isEmpty()) {
				return ResponseEntity.noContent().build();
			}
	
			return ResponseEntity.ok(items);
		}
	
	/*	@GetMapping
		public ResponseEntity<List<InventoryDto>> selectAllInventories() {
			InventoryDto dto = new InventoryDto();
			List<Inventory> items = service.selectAllInventories();
			List<InventoryDto> dtos
			   = items.stream().map(dto::of).collect(Collectors.toList());
	
			if (items.isEmpty()) {
				return ResponseEntity.noContent().build();
			}
	
			return ResponseEntity.ok(dtos);
		}*/

}
