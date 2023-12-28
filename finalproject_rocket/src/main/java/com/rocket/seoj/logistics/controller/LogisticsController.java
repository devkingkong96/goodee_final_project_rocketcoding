package com.rocket.seoj.logistics.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rocket.seoj.logistics.model.dto.Inventory;
import com.rocket.seoj.logistics.model.service.LogisticsService;

import lombok.RequiredArgsConstructor;

/**
 * Brief description of functions
 *
 * @author J
 * @version 2023-12-25
 */
@Controller
@RequestMapping ("/logistics/index")
@RequiredArgsConstructor
public class LogisticsController {
	
	private final LogisticsService service;
	
	@GetMapping
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
