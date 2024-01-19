package com.rocket.ksj.chat.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	public List<Object> chatCreateRoom(HttpServletRequest request) {
		HashMap<String, Object>reqAll=getParameterMap(request);
		
		List<Object> result=roomService.createChatRoomAll(reqAll);
		
		return result;
	}
	
	//채팅방 입장
	@GetMapping("/{roomId}")
	public String inChatting(@PathVariable int roomId,Model m) {
		//대화방에 참여중인 회원 제외한 직원 리스트 가져오기
		List<Map<String, Object>>emplistAll=chatService.selectEmployeeAll(roomId);
		log.info("roomId : {}",roomId);
		//로그인한 직원 정보 가져오기
		Employee emp=(Employee)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		int empNo=emp.getEmpNo();
		Map<String, Object>empinfo=chatService.selectEmpInfo(empNo);
		//해당 채팅방의 정보 가져오기
		Map<String, Object> room=roomService.selectRoomById(roomId);
		//채팅방 참여한 직원 정보 가져오기
		List<Map<String, Object>>emplist=chatService.selectEmployeeInRoom(roomId);
		
//		//해당 채팅방의 채팅내역들 가져오기
		List<Map<String, Object>>messages=msgService.selectChatMessageByNo(roomId);
		
		log.info("직원 정보{}",empinfo);
		log.info("채팅방 정보{}",room);
		log.info("채팅내역 정보{}",messages);
		log.info("채팅방 직원 목록{}",emplist);		
		
		
		m.addAttribute("empinfo",empinfo);
		m.addAttribute("room",room);
		m.addAttribute("messages",messages);
		m.addAttribute("emplist",emplist);
		m.addAttribute("emplistAll",emplistAll);
		
		return "chat/chatting";
	}
	
	//채팅방 중간테이블 나가기 -> 채팅 목록에서
	@DeleteMapping
	public ResponseEntity<Object> deleteEmpChatRooms(HttpServletRequest req) {
		HashMap<String, Object>reqAll=getParameterMap(req);
		log.info("delete 채팅방 테스트{}",reqAll.get("roomCheck"));
		
		String result=roomService.deleteEmpChatRooms(reqAll);
		log.info("result 결과{}",result);
		if(result.equals("success")) {
			return ResponseEntity.ok().build();
		}else {
			return ResponseEntity.badRequest().build();
		}
	}
	
	//채팅방 중간테이블 나가기 -> 채팅방안에서
	@RequestMapping(value = "/{msgRoomNo}", method = RequestMethod.PUT)
	public ResponseEntity<Object> deleteEmpChatRoom(@PathVariable int msgRoomNo,int msgEmpNo) {
		log.info("roomId {}",msgRoomNo);
		log.info("empNo {}",msgEmpNo);
		
		Map<String, Object> param=new HashMap<>();
		param.put("roomId", msgRoomNo);
		param.put("empNo", msgEmpNo);
		
		int result=roomService.deleteEmpChatRoomById(param);
		if(result>0) {
			return ResponseEntity.ok().build();
		}else {
			return ResponseEntity.badRequest().build();
		}
	}
	
	
}
