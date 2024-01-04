package com.rocket.pdw.aprv.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rocket.pdw.aprv.model.dto.Tag;
import com.rocket.pdw.aprv.model.service.ApprovalService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class AprvController {
	
	private final ApprovalService service;
	
	
	@RequestMapping("/aprvlist")
	public String index() {
		return "aprv/aprvlist";
	}
	
	@GetMapping("/aprv")
	public String index2() {
		return "aprv/aprv";
	}
	@PostMapping("/aprv/insertaprv")
	public String insertaprv(Tag dt) {
		System.out.println(dt);
		service.inserttag(dt);
		
		return "aprv/aprv";
	}
}
