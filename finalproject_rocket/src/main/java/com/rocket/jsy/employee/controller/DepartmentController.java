package com.rocket.jsy.employee.controller;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rocket.jsy.employee.service.DepartmentService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class DepartmentController {
	
	private final DepartmentService service;
	
	@GetMapping("/departmentlist")
	public String departmentlist(Model model) {
		List<Map<String,Object>> departments=service.selectDepartmentAll();
		model.addAttribute("departments",departments);
		return "employee/departmentlist";
	}
	
	@PostMapping("/department/add")
	public String addDepartment(@RequestParam String depName) {
		service.addDepartment(depName);
		return "redirect:/departmentlist";
	}
	
	@GetMapping("/departmentdetail")
	@ResponseBody
	public List<Map<String,Object>> departmentdetail(@RequestParam("depName") String departmentName){
		List<Map<String,Object>> departmentdetailview = service.departmentdetail(departmentName);
		System.out.println("부서상세화면 : "+departmentdetailview);
		return departmentdetailview;
	}
	
}
