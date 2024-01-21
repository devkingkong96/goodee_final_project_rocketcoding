package com.rocket.jsy.employee.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rocket.jsy.employee.service.CommuteService;

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
	@GetMapping("employeecommute")
	public String employeecommute(Model model) {
		model.addAttribute("");
		return "employee/employeecommute";
	}
	@GetMapping("/employeesearch")
	@ResponseBody
	public List<Map<String, Object>> employeesearch(@RequestParam("employeeName") String employeeName){
		List<Map<String, Object>> employeename = service.employeesearch(employeeName);
		System.out.println("키업 : "+employeename);
		return employeename;
	}
	
	@GetMapping("/employeeCalendar")
	@ResponseBody
	public Map<String, Object> commuteemployee(@RequestParam("employeeName") String employeeName) {
	    Map<String, Object> byname = service.selectcommuteByName(employeeName);
	    System.out.println("검색결과 : "+byname);
	    return byname;
	}
	
	
	@GetMapping("/myevents/{empName}")
	@ResponseBody
	public List<Map<String, Object>> mycalendar(@PathVariable String empName) {
	    List<Map<String, Object>> mycalendar = new ArrayList<>();
	    mycalendar = service.selectEmployeeByCalendar(empName);
	    SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd");
	    SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
	    inputFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
	    for(Map<String, Object> event : mycalendar) {
	        Object endDateObj = event.get("END_DAY");
	        Object startDateObj = event.get("START_DAY");
	     //it (endDateObj != null 이것보단) 
	     //ObjectUtils.isEmpty(byname) 이걸로 값을 체크 map 도 되고 배열도 되고 
	        if (endDateObj != null) {
	            try {
	                Date endDate = inputFormat.parse(endDateObj.toString());
	                String formattedEndDate = outputFormat.format(endDate);
	                event.put("END_DAY", formattedEndDate);
	            } catch (Exception e) {
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
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	        } else {
	            event.put("START_DAY", "");
	        }
	    }
	    	log.info("???:" + mycalendar.toString());
	    return mycalendar;
	}

	
}
