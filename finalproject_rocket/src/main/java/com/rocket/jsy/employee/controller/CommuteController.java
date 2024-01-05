package com.rocket.jsy.employee.controller;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.rocket.jsy.employee.service.CommuteService;
import com.rocket.jsy.employee.service.EmployeeService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class CommuteController {
	
	private final CommuteService service;
	
	@GetMapping("/commutelist")
	public String commutelist(Model model) {
		List<Map<String, Object>> commutes = service.selectCommuteAll();
	    model.addAttribute("commutes", commutes);
	    return "employee/commutelist";
	}
}
