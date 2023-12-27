package com.rocket.ksj.chat.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rocket.ksj.chat.model.service.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class MemberController {

	private final MemberService service;
	
//	@GetMapping("/list")
//	public String memberList(Model m) {
//		List<Member>members=service.selectMemberAll();
//		
//		log.info("members : {}",members);
//		
//		m.addAttribute("members",members);
//		return "list";
//	}
	
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
	
//	@RequestMapping("/member/sendEmail")
//	public String sendEmail(String empNo,String email) {
//		
//	}
	
	
}
