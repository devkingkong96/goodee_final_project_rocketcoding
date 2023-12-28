package com.rocket.jsy.employee.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rocket.jsy.employee.service.EmployeeService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class EmployeeController {
	
	private final EmployeeService service;
	
	@GetMapping("/mypage")
	public String mypage() {
		return "employee/mypage";
	}
	@GetMapping("/employeelist")
	public String employeelist() {
		return "employee/employeelist";
	}
}
