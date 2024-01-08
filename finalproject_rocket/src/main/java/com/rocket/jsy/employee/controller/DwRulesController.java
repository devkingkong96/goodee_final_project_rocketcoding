package com.rocket.jsy.employee.controller;

import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.rocket.jsy.employee.model.dto.DwRules;
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
	@PostMapping("/dwrulesadd")
	public String addDwRule(@RequestParam String dwrulesStart, @RequestParam String dwrulesEnd, @RequestParam String dwrulesEarly) {
	    DwRules dwRules = new DwRules();
	    dwRules.setDwrulesStart(dwrulesStart);
	    dwRules.setDwrulesEnd(dwrulesEnd);
	    dwRules.setDwrulesEarly(dwrulesEarly);
	    service.addDwRules(dwRules);
	    return "redirect:/dwruleslist";
	}
	@PostMapping("/deleteDwRule")
	public ResponseEntity<?> deleteDwRule(@RequestParam String comNo) {
	    service.deleteDwRule(comNo);
	    return ResponseEntity.ok().build();
	}

}
