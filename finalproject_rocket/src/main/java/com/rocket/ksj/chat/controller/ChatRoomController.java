package com.rocket.ksj.chat.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import static com.rocket.common.Getrequest.*;
import com.rocket.jsy.employee.model.dto.Employee;
import com.rocket.ksj.chat.model.dto.ChatRoom;
import com.rocket.ksj.chat.model.service.ChatMessageService;
import com.rocket.ksj.chat.model.service.ChatRoomService;
import com.rocket.ksj.chat.model.service.ChatService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/chat/room")
@RequiredArgsConstructor
@Slf4j
public class ChatRoomController {
	
	private final Gson gson;
	private final ChatService chatService;
	private final ChatRoomService roomService;
	private final ChatMessageService msgService;
	
	
	//채팅방 생성
	@PostMapping
	@ResponseBody
	public String chatCreateRoom(HttpServletRequest request) {
		HashMap<String, Object>reqAll=getParameterMap(request);
		
		String result=roomService.createChatRoomAll(reqAll);
		
		String jsonString=gson.toJson(result);
		return jsonString;
	}
	
	//채팅방 입장
	@GetMapping("/{roomId}")
	public String inChatting(@PathVariable int roomId,Model m) {
		log.info("roomId : {}",roomId);
		//로그인한 직원 정보 가져오기
		Employee empinfo=(Employee)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		//해당 채팅방의 정보 가져오기
		ChatRoom room=roomService.selectRoomById(roomId);
		
//		//해당 채팅방의 채팅내역들 가져오기
		List<Map<String, Object>>messages=msgService.selectChatMessageByNo(roomId);
		
		log.info("직원 정보{}",empinfo);
		log.info("채팅방 정보{}",room);
		log.info("채팅내역 정보{}",messages);
		
		m.addAttribute("empinfo",empinfo);
		m.addAttribute("room",room);
		m.addAttribute("messages",messages);
		
		return "chat/chatting";
	}
	
	//채팅방 삭제
	@DeleteMapping
	@ResponseBody
	public String deleteRoom(HttpServletRequest req) {
		log.info("delete 채팅방 테스트{}");
		HashMap<String, Object>reqAll=getParameterMap(req);
		log.info("delete 채팅방 테스트{}",reqAll.get("roomCheck"));
		
		String result=roomService.deleteRoomAll(reqAll);
		
		String jsonString=gson.toJson(result);
		return jsonString;
	}
	
}
