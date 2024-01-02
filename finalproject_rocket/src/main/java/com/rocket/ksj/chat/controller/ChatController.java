package com.rocket.ksj.chat.controller;

import java.util.List;
import java.util.Map;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rocket.ksj.chat.model.service.ChatService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/chat")
public class ChatController {

	private final ChatService service;
	
	@ResponseBody
	@GetMapping("/employeelist")
	public List<Map<String, Object>> getEmployeeList(){
		List<Map<String, Object>>employeeList=service.selectEmployeeAll();
		return employeeList;
	}
	
}
