package com.rocket.seoj.logistics.controller;

import com.rocket.seoj.logistics.model.dto.Inventory;
import com.rocket.seoj.logistics.model.service.LogisticsService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * Brief description of functions
 *
 * @author J
 * @version 2023-12-25
 */
@RestController
@RequestMapping("/logistics/index")
@RequiredArgsConstructor
public class LogisticsController {
    private final LogisticsService service;

    @GetMapping
    public ResponseEntity<List<Inventory>> getAllItems(){
        List<Inventory> items = service.getAllItems();

        if (items.isEmpty()) {
            return ResponseEntity.noContent().build();
        }

        return ResponseEntity.ok(items);
    }
}
