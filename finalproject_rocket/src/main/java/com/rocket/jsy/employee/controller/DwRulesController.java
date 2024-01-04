package com.rocket.jsy.employee.controller;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.rocket.jsy.employee.service.DwRulesService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class DwRulesController {
	
	private final DwRulesService service;
	
	@GetMapping("/dwruleslist")
	public String commutelist(Model model) {
		List<Map<String, Object>> dwrules = service.selectDwRulesAll();
	    model.addAttribute("dwrules", dwrules);
	    return "employee/dwruleslist";
	}
}
