package com.rocket.jsy.employee.controller;


import static com.rocket.common.Getrequest.getParameterMap;

import java.sql.Clob;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.rocket.jsy.employee.service.EmployeeService;
import com.rocket.jsy.employee.service.MypageService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class EmployeeController {
	
	private final BCryptPasswordEncoder encoder=new BCryptPasswordEncoder();
	private final Gson gson;
	private final EmployeeService service;
	private final MypageService mypageservice;
	
	@GetMapping("/mypage")
	public String mypage(Model model) {
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    if(authentication != null && authentication.getPrincipal() instanceof UserDetails) {
	        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
	        int empNo = Integer.parseInt(userDetails.getUsername());
	        Map<String, Object> employee = service.selectEmployeeByNo(empNo);
	        Map<String, Object> coomute = mypageservice.selectEmployeeByNo(empNo);
	        log.info("Employee: " + employee.toString());
	        log.info("Coomute: " + coomute.toString());
	        model.addAttribute("employee", employee);
	        model.addAttribute("coomute", coomute);
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
	    List<Map<String, Object>> employees = service.selectEmployeeHolidayAll();

	    for (Map<String, Object> map : employees) {
	        String textData = "";
	        if(map.get("DOC_CONT") instanceof java.sql.Clob) { 
	            Clob text = (Clob) map.get("DOC_CONT");
	            try {
	                String clobContent = text.getSubString(1, (int) text.length());
	                if (clobContent.startsWith("[") && clobContent.endsWith("]")) {
	                    String[] contentArray = clobContent.substring(1, clobContent.length() - 1).split(",");
	                    for (String content : contentArray) {
	                        textData += content.trim();
	                    }
	                } else {
	                    textData += clobContent;
	                }
	            } catch (Exception e1) {
	                e1.printStackTrace();
	            } finally {
	                map.put("DOC_CONT", textData); 
	            }
	        }
	    }

	    model.addAttribute("employees", employees);
	    return "employee/employeeholidaylist";
	}
	 
	 @PostMapping("/employeeinsert")
	 @ResponseBody
	 public String insertEmployee(HttpServletRequest request) {
		 HashMap<String, Object>map=getParameterMap(request);
		 log.info("받은 데이터: {}", map);
		 String pw=(String)map.get("empPw");
		 pw=encoder.encode(pw);
		 map.put("empPw", pw);
		 int result = service.insertEmployee(map);
		 return result > 0 ? "success" : "fail";
	 }
	 @PostMapping("/employeeupdate")
	 @ResponseBody
	 public String updateEmployee(HttpServletRequest request) {
	     HashMap<String, Object> updateMap = getParameterMap(request);
	     log.info("받은 데이터: {}", updateMap);
	     String pw=(String)updateMap.get("empPw");
		 pw=encoder.encode(pw);
		 updateMap.put("empPw", pw);
	     int result = service.updateEmployee(updateMap);
	     return result > 0 ? "success" : "fail";
	     
	 }
	 
	 

}

