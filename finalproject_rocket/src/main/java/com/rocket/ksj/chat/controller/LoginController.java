package com.rocket.ksj.chat.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rocket.ksj.chat.model.service.LoginService;
import com.rocket.ksj.chat.model.service.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class LoginController {
	
	private final LoginService service;
	
	
	@GetMapping("/member/emailCheck")
	public boolean checkEmail(String empNo,String email) {
		log.info("check메소드 성공");
		return true;
	}
	
//	@PostMapping("/member/sendPwd")
//	public 
	
	
	
	@RequestMapping("/")
	public String index() {
		return "index";
	}
	
	@RequestMapping("/test")
	public String test() {
		return "test";
	}
	
	@RequestMapping("/chat")
	public String chat() {
		return "chat/chatting";
	}
	
	@RequestMapping("/login")
	public String login() {
		return "loginpage";
	}
}
