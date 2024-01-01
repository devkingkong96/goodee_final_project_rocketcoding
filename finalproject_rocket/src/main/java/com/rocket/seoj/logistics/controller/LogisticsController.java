package com.rocket.seoj.logistics.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.Reader;
import java.sql.Clob;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rocket.seoj.logistics.model.service.LogisticsService;

import lombok.RequiredArgsConstructor;

/**
 * Brief description of functions
 *
 * @author J
 * @version 2023-12-25
 */
@Controller
@RequestMapping ("/logistics")
@RequiredArgsConstructor
public class LogisticsController {
	
	private final LogisticsService service;
	
	private Map<String, String> tableIdColumnMap
	   = new HashMap<String, String>() {
		   
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
	
	@PostMapping ("/inventory/List/tableupdate")
	public ResponseEntity< ? > updateTable(@RequestParam ("id") long id,
	                                       @RequestParam ("columnName") String columnName,
	                                       @RequestParam ("tableName") String tableName,
	                                       @RequestParam ("value") String value,
	                                       @RequestParam ("parentTableName") String parentTableName,
	                                       @RequestParam ("parentColumnName") String parentColumnName) {
		System.out.println("parentTableName : " + parentTableName);
		
		String parentColumnId
		   = tableIdColumnMap.get(parentTableName.toUpperCase());
		String columnId = tableIdColumnMap.get(tableName);
		
		System.out.println("ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ컨트롤러ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ" + String.valueOf(id)
		   + ", " + columnName + ", " + tableName + ", " + value + ", "
		   + parentTableName + ", " + parentColumnId + ", " + parentColumnName
		   + ", " + columnId);
		
		System.out.println("업데이트 실행합니다");
		int result
		   = service.updateColumn(id, columnName, tableName.toUpperCase(), value,
		                          parentTableName.toUpperCase(), parentColumnId,
		                          parentColumnName, columnId);
		System.out.println("result : " + result);
		
		if (result > 0) {
			// If one or more rows were updated
			return ResponseEntity.ok().body("업데이트 성공");
		} else {
			// If no rows were updated
			return ResponseEntity.status(HttpStatus.NOT_MODIFIED).body("업데이트 실패");
		}
	}
	
	@RequestMapping ("inventory/List")
	public String getAllItems(Model model) {
		/*		List<Map> inventories = service.selectAllInventories();
				model.addAttribute("inventories", inventories);*/
		List<Map<String, Object>> inventories = service.selectAllInventories();
		System.out.println();
		model.addAttribute("inventories", inventories);
		return "logistics/inventoryList";
	}
	
	@PostMapping ("inventory/List/delete")
	public String
	       deleteInventoryAndAttachments(@RequestParam ("iv_id") Long inventoryId,
	                                     Model model) {
		System.out.println("ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ딜리트ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ " + inventoryId);
		boolean deletionSuccess
		   = service.deleteInventoryAndAttachmentAndPrdIv(inventoryId); // 서비스 레이어에서 삭제 로직 수행
		
		String msg, loc;
		
		if (deletionSuccess) {
			msg = "삭제 성공";
			loc = "logistics/inventory/List";
		} else {
			msg = "삭제 실패";
			loc = "logistics/inventory/List";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("loc", loc);
		/*	ModelAndView modelAndView = new ModelAndView();
			modelAndView.setViewName("redirect:/inventory/list"); // 삭제 후 리다이렉트할 페이지
			return modelAndView;*/
		return "logistics/common/msg";
	}
	
	@GetMapping ("/inventories") @ResponseBody
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
		}
		catch (
		   SQLException
		   | IOException e) {
			
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
		}*/
	
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
