package com.rocket.ksj.chat.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
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
	
	private final ChatService chatService;
	private final ChatRoomService roomService;
	private final ChatMessageService msgService;
	
//	//채팅방 생성
//	@PostMapping
//	public String chatCreateRoom(Model m,int count) {
//		int result=chatService.createChatRoom(count);
//		
//		String msg,loc;
//		
//		if(result>0) {
//			msg="대화방 생성 성공";
//			loc="chat/list";
//		}else {
//			msg="대화방 생성 실패";
//			loc="chat/list";
//		}
//		
//		m.addAttribute("msg",msg);
//		m.addAttribute("loc",loc);
//		
//		return "common/msg";
//	}
	
	//채팅방 생성
	@PostMapping
	@ResponseBody
	public String chatCreateRoom(HttpServletRequest request) {
		HashMap<String, Object>reqAll=getParameterMap(request);
		
		String roomName=(String)reqAll.get("roomName");
		
		log.info("방 이름 {}",roomName);
		
		String [] employees=(String[])reqAll.get("empCheck");
		
		for(String e:employees) {
			log.info("직원 리스트 {}",e);
		}
		
//		List<Object>list=(List)reqAll.get("empCheck");
//		log.info("list값들 {}",list);
		
//		JsonObject jsonobj=gson.fromJson(json, JsonObject.class);
//		JsonObject jsonobj=JsonParser.parseString(json).getAsJsonObject();
		log.info("json값들 {}",reqAll);
		
//		int result=chatService.createChatRoom(count);
		
		return "success";
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
//	@DeleteMapping("/{roomId}")
//	public String deleteRoom(@PathVariable int roomId) {
//		
//	}
	
}
