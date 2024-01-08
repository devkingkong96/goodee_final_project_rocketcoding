package com.rocket.jsy.employee.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rocket.jsy.employee.model.dto.Employee;
import com.rocket.jsy.employee.service.EmployeeService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class EmployeeController {
	
	private final EmployeeService service;
	
	@GetMapping("/mypage")
	public String mypage(Model model) {
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    if(authentication != null && authentication.getPrincipal() instanceof UserDetails) {
	        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
	        int empNo = Integer.parseInt(userDetails.getUsername());
	        Map<String, Object> employee = service.selectEmployeeByNo(empNo);
	        model.addAttribute("employee", employee);
	    }
	    return "employee/mypage";
	}
	@GetMapping("/employeelist")
	public String employeelist(Model model) {
	    List<Map<String, Object>> employees = service.selectEmployeeAll();
	    List<Map<String,Object>> branches = service.selectBranch();
	    List<Map<String,Object>> departments = service.selectDepartment();
	    List<Map<String,Object>> dwrules = service.selectDwrules();
	    
	    model.addAttribute("employees", employees);
	    model.addAttribute("branches", branches);
	    model.addAttribute("departments", departments);
	    model.addAttribute("dwrules", dwrules);
	    
	    return "employee/employeelist"; 
	}
	
	@GetMapping("/employeeholidaylist")
	public String employeeholidaylist(Model model) {
		List<Map<String, Object>> employees=service.selectEmployeeHolidayAll();
		model.addAttribute("employees",employees);
		return "employee/employeeholidaylist";
	}
	 @GetMapping("/myPageCalendar")
	 @ResponseBody
	    public List<Map<String, Object>> myPageCalendar() {
	        return service.selectEmployeeMyPageCalendar();
	    }
	 @PostMapping("/employeeinsert")
	 public String insertEmployee(Employee employee) {
	     service.insertEmployee(employee);
	     return "redirect:/employee/employeelist";
	 }
	 @Autowired
	 private EmployeeService employeeService;
	 
//	 @PostMapping("/employeeupdate")
//	 	public String updateEmployee(Employee employee) {
//	     employeeService.updateEmployee(employee);
//		 return "redirect:/employee/employeelist";
//	 }
	 
	 

}

