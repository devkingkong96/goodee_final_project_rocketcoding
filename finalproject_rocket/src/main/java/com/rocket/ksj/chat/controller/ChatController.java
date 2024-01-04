package com.rocket.ksj.chat.controller;

import java.util.List;
import java.util.Map;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rocket.jsy.employee.model.dto.Employee;
import com.rocket.ksj.chat.model.service.ChatService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/chat")
public class ChatController {

	private final ChatService service;
	
	
	@GetMapping("/list")
	public String chatlist(Model m,HttpSession session) {
		Employee emp=(Employee)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		int empNo=emp.getEmpNo();
		//직원 리스트 가져오기
		List<Map<String, Object>>emplist=service.selectEmployeeAll();
		//로그인한 직원 채팅방 가져오기
//		List<Map<String, Object>>chatlist=service.selectChatAll(empNo);
		//모든 대화방 가져오기
		List<Map<String, Object>>chatroomlist=service.selectRoomAll();
		
		m.addAttribute("emplist",emplist);
//		m.addAttribute("chatlist",chatlist);
		m.addAttribute("chatroomlist",chatroomlist);
		
		return "chat/chatlist";
	}
	
	@PostMapping
	public String chatCreateRoom(Model m,int count) {
		int result=service.createChatRoom(count);
		
		String msg,loc;
		
		if(result>0) {
			msg="대화방 생성 성공";
			loc="chat/list";
		}else {
			msg="대화방 생성 실패";
			loc="chat/list";
		}
		
		m.addAttribute("msg",msg);
		m.addAttribute("loc",loc);
		
		return "common/msg";
	}
	
//	@GetMapping("roomid")
//	public String chat
}
