package com.rocket.ksj.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rocket.ksj.member.model.dto.Member;
import com.rocket.ksj.member.model.service.MemberService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MemberController {

	private final MemberService service;
	
//	@GetMapping
//	public String memberList(Model m) {
//		List<Member>members=service.selectMemberAll();
//		m.addAttribute("members",members);
//		return "index";
//	}
	
	@RequestMapping("/")
	public String index() {
		return "index";
	}
	
	@RequestMapping("/test")
	public String test() {
		return "test";
	}
	
	
}
