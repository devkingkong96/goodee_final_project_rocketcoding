package com.rocket.jsy.employee.controller;

import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.Gson;
import com.rocket.common.FileUtil;
import com.rocket.jsy.employee.service.EmployeeService;
import com.rocket.jsy.employee.service.MypageService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class MypageController {
	
	private final Gson gson;
	private final SqlSessionTemplate sqlSession;
	private final EmployeeService service;
	private final MypageService mypageservice;
	
	@Autowired
    private FileUtil fileUtil;

	@PostMapping("/upload")
	public String handleFileUpload(MultipartHttpServletRequest mpRequest, HttpServletRequest request, Principal session) throws Exception {
	    String empFile = fileUtil.updateImg(mpRequest, request);
	    service.updateEmpFile(empFile, Integer.parseInt(session.getName()));
	    request.setAttribute("emp_no", session.getName());
	    return "redirect:/mypage";
	}
//	@PostMapping("/upload")
//	public ModelAndView handleFileUpload(MultipartHttpServletRequest mpRequest, HttpServletRequest request, Principal session) throws Exception {
//	    String empFile = fileUtil.updateImg(mpRequest, request);
//
//	    service.updateEmpFile(empFile, Integer.parseInt(session.getName()));
//
//	    ModelAndView mv = new ModelAndView();
//	    mv.setViewName("employee/mypage");
//	    mv.addObject("emp_no", session.getName());
//
//	    return mv;
//	}


	@PostMapping("/startWork")
	public ResponseEntity<Map<String, String>> startWork(@RequestParam int empNo) {
	    mypageservice.startWork(empNo);
	    log.info("출근사원받은 데이터: {}",empNo);

	    SimpleDateFormat formatter = new SimpleDateFormat("HH:mm");
	    String currentTime = formatter.format(new Date());

	    Map<String, String> response = new HashMap<>();
	    response.put("time", currentTime);
	    response.put("message", "출근 완료했습니다.");

	    return ResponseEntity.ok(response);
	}
	
	@PostMapping("/endWork")
	public ResponseEntity<Map<String, String>> endWork(@RequestParam int empNo) {
	    mypageservice.endWork(empNo);
	    log.info("퇴근사원받은 사원번호: {}",empNo);

	    SimpleDateFormat formatter = new SimpleDateFormat("HH:mm");
	    String currentTime = formatter.format(new Date());

	    Map<String, String> response = new HashMap<>();
	    response.put("time", currentTime);
	    response.put("message2", "퇴근 완료했습니다.");

	    return ResponseEntity.ok(response);
	}
	
	@GetMapping("/myevents")
	@ResponseBody
	public List<Map<String, Object>> mycalendar() {
	    List<Map<String, Object>> mycalendar = new ArrayList<>();
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
	        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
	        int empNo = Integer.parseInt(userDetails.getUsername());
	        mycalendar = mypageservice.selectEmployeeByCalendar(empNo);
	        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd");
	        SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
	        inputFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
	        for(Map<String, Object> event : mycalendar) {
	            Object endDateObj = event.get("END_DAY");
	            Object startDateObj = event.get("START_DAY");
	            
	            if (endDateObj != null) {
	                try {
	                    Date endDate = inputFormat.parse(endDateObj.toString());
	                    String formattedEndDate = outputFormat.format(endDate);
	                    event.put("END_DAY", formattedEndDate);
	                } catch (ParseException e) {
	                    e.printStackTrace();
	                }
	            } else {
	                event.put("END_DAY", "");
	            }
	            
	            if (startDateObj != null) {
	                try {
	                    Date startDate = inputFormat.parse(startDateObj.toString());
	                    String formattedStartDate = outputFormat.format(startDate);
	                    event.put("START_DAY", formattedStartDate);
	                } catch (ParseException e) {
	                    e.printStackTrace();
	                }
	            } else {
	                event.put("START_DAY", "");
	            }
	        }
	        log.info("mycalendar:" + mycalendar.toString());
	    }
	    return mycalendar;
	}
    
}
