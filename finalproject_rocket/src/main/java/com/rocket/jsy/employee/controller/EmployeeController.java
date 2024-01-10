package com.rocket.jsy.employee.controller;


import static com.rocket.common.Getrequest.getParameterMap;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.rocket.jsy.employee.service.EmployeeService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class EmployeeController {
	
	private final Gson gson;
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
	 
//	 @GetMapping("/myPageCalendar")
//	 @ResponseBody
//	    public List<Map<String, Object>> myPageCalendar() {
//	        return service.selectEmployeeMyPageCalendar();
//	    }
	 
	 @PostMapping("/employeeinsert")
	 @ResponseBody
	 public String insertEmployee(HttpServletRequest request) {
		 HashMap<String, Object>map=getParameterMap(request);
		 log.info("받은 데이터: {}", map);
		 int result = service.insertEmployee(map);
		 return result > 0 ? "success" : "fail";
	 }
	 @PostMapping("/employeeupdate")
	 @ResponseBody
	 public String updateEmployee(HttpServletRequest request) {
	     HashMap<String, Object> updateMap = getParameterMap(request);
	     log.info("받은 데이터: {}", updateMap);
	     int result = service.updateEmployee(updateMap);
	     return result > 0 ? "success" : "fail";
	 }
	 
	 

}

