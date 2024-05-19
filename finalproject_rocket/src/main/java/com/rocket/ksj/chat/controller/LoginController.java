package com.rocket.ksj.chat.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rocket.jsy.employee.model.dto.Employee;
import com.rocket.jsy.employee.service.EmployeeService;
import com.rocket.jsy.employee.service.MypageService;
import com.rocket.ksj.chat.model.service.LoginService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class LoginController {
	
	private final LoginService service;
	private final BCryptPasswordEncoder encoder=new BCryptPasswordEncoder();
	private final EmployeeService empservice;
	private final MypageService mypageservice;
	
	//사원번호, 이메일이 있는지 확인하는 메소드
	@GetMapping("/member/emailCheck")
	@ResponseBody
	public String checkEmail(@RequestParam("empNo")String empNo,@RequestParam("email")String email) {
		int CheckempNo=service.selectEmployeeByIdTmp(empNo);
		if(CheckempNo<1) {
			return "EmptyNo";
			}
		Map<String, String>map=new HashMap<>();
		map.put("empNo", empNo);
		map.put("email", email);
		int CheckempEmail=service.selectEmployeeByNoEmailTmp(map);
		if(CheckempEmail<1) {
			return "EmptyEmail";
			}
		
		return "emp";
	}
	
	//임시 비밀번호 메일로 전송
	@ResponseBody
	@PostMapping("/member/sendPwd")
	public String sendPwdEmail(String empNo,String email) {
		//Map에 담아 파라미터로 전달
		Map<String, String>emp=new HashMap<>();
		emp.put("empNo",empNo);
		
		//임시 비밀번호 생성
		String tmpPwd=service.getTempPassword();
		String BCtmpPwd=encoder.encode(tmpPwd);
		emp.put("BCtmpPwd",BCtmpPwd);
		
		//임시 비밀번호 DB에 저장
		if(service.updateEmployeeTempPwd(emp)<1) {
			return "DBfail";
		}
		
		//메일 생성 & 전송
		service.sendEmail(email,empNo,tmpPwd);
		
		return "success";
	}
	
	
	
	@RequestMapping("/")
	public String index(Model model) {
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    if(authentication != null && authentication.getPrincipal() instanceof UserDetails) {
	        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
	        int empNo = Integer.parseInt(userDetails.getUsername());
	        Map<String, Object> employee = empservice.selectEmployeeByNo(empNo);
	        Map<String, Object> coomute = mypageservice.selectEmployeeByNo(empNo);
//	        List<Map<String, Object>> mycalendar = mypageservice.selectEmployeeByCalendar(empNo);
	        log.info("Employee: " + employee.toString());
	        log.info("Coomute: " + coomute.toString());
//	        log.info("mycalendar:" + mycalendar.toString());
	        model.addAttribute("employee", employee);
	        model.addAttribute("coomute", coomute);
//	        model.addAttribute("mycalendar", mycalendar);	        
	    }
	    return "employee/mypage";
	}
	
//	@RequestMapping("/")
//	public String index(Model model,HttpSession session) {
//		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//	    if(authentication != null && authentication.getPrincipal() instanceof UserDetails) {
//	        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
//	        int empNo = Integer.parseInt(userDetails.getUsername());
//	        Map<String, Object> employee = Empservice.selectEmployeeByNo(empNo);
//	        Map<String, Object> coomute = mypageservice.selectEmployeeByNo(empNo);
//	        log.info("Employee: " + employee.toString());
//	        log.info("Coomute: " + coomute.toString());
//	        model.addAttribute("employee", employee);
//	        model.addAttribute("coomute", coomute);
//
//	    }
//	    return "employee/mypage";
//	}
	
	@RequestMapping("/chatting")
	public String test() {
		
		return "chat/chatting";
	}
	
	
	@RequestMapping("/login")
	public String login(@RequestParam(value="errorMessage",required = false)String error,Model model) {
		model.addAttribute("errorMessage",error);
		return "loginpage";
	}
	
//	@PostMapping("/loginError")
//	public String loginError(Model model) {
//		model.addAttribute("errormsg","인증실패");
//		return "loginpage";
//	}
}
