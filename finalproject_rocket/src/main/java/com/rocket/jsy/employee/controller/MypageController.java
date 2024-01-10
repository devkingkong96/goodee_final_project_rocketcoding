package com.rocket.jsy.employee.controller;

import java.security.Principal;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.rocket.common.FileUtil;
import com.rocket.jsy.employee.model.dto.Employee;
import com.rocket.jsy.employee.service.EmployeeService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class MypageController {
	
	private final SqlSessionTemplate sqlSession;
	private final EmployeeService service;
	
	@Autowired
    private FileUtil fileUtil;

	@PostMapping("/upload")
	public String handleFileUpload(MultipartHttpServletRequest mpRequest, 
			HttpServletRequest request, Principal session)throws Exception {
	    String empFile = fileUtil.updateImg(mpRequest, request); 

	    service.updateEmpFile(empFile, Integer.parseInt(session.getName()));
	    
	    
	    
	    return "employee/mypage";
	}
}
