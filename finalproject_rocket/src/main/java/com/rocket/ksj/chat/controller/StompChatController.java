package com.rocket.ksj.chat.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;

import org.springframework.dao.DataAccessException;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.multipart.MultipartFile;

import com.rocket.ksj.chat.model.dto.ChatMessage;
import com.rocket.ksj.chat.model.service.ChatMessageService;
import com.rocket.ksj.chat.model.service.ChatService;
import com.rocket.seoj.logistics.model.dto.InventoryAttach;
import static com.rocket.common.Getrequest.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class StompChatController {

	private final SimpMessagingTemplate template;
	private final ChatMessageService msgService;
	private final ChatService chatService;
	
	//채팅방 입장
	@MessageMapping("/chat/enter")
	public void enterMessage(ChatMessage message,SimpMessageHeaderAccessor headerAccessor) {
		log.info("{}님의 채팅방 입장 성공",message.getMsgEmpName());
		
		int roomNo=message.getMsgRoomNo();
		
		log.info("{}번 채팅방 입장 성공",roomNo);
		//socket session에 직원 정보,방 번호 저장
//		headerAccessor.getSessionAttributes().put("roomNo", headerAccessor);
		
		template.convertAndSend("/sub/chat/room/"+message.getMsgRoomNo(),message);
	}
	
	//채팅 메시지 전송
	@MessageMapping("/chat/send")
	public void sendMessage(ChatMessage message) {
		log.info("채팅메시지 발송 {}",message);
		
		// LocallDateTime 객체 생성(현재 시간)
		LocalDateTime now=LocalDateTime.now();
		// LocalDateTime -> Date 변환
		Date date=Timestamp.valueOf(now);
		
		message.setSendAt(date);
		
		//채팅 메시지 저장
		int result=msgService.insertMessage(message);
		if(result>0) {
			log.info("성공");
			template.convertAndSend("/sub/chat/room/"+message.getMsgRoomNo(),message);
		}else {
			log.info("실패");
		}
	}
	
	//채팅방에서 직원 초대
	@MessageMapping("/chat/invite")
	public void RoomInviteEmployees(Map<String, Object> param) {
		log.info("방 번호{}",param);
		int roomId=Integer.parseInt((String)param.get("roomId"));
		Map<String,Object> responseData=new HashMap();
		List<Map<String, Object>>result=chatService.selectEmployeeInRoom(roomId);
		responseData.put("inPerson",result);
		//log.info("방에 있는 사람들{}",result);
		//result.add(Map.of("type","ROOMINVITE"));
		responseData.put("type","ROOMINVITE");
		
		log.info("delresult:{}",param.get("delEmps").getClass());
		//대화방에서 초대된 직원 목록에서 없애기
		if(param.get("delEmps")!=null) {
			responseData.put("delEmps", param.get("delEmps"));
		}
		
		template.convertAndSend("/sub/chat/room/"+roomId,responseData);
	}
	
	//채팅방에서 모달 초대된 직원 목록 빼기
	@MessageMapping("/chat/leave")
	public void RoomDeleteEmployees(ChatMessage msg) {
		log.info("받아온 메시지 정보 : {}",msg);
		
		template.convertAndSend("/sub/chat/room/"+msg.getMsgRoomNo(),msg);
	}
	
	//리스트에서 채팅방 생성(초대한 멤버들 리스트 갱신 시키기)
	@MessageMapping("/list/invite")
	public void ListInviteEmployees(List<Object>param) {
		log.info("초대한 리스트 MessageMapping{}",param);
		Map<String, Object>responseData = new HashMap<>();
		responseData.put("inviteemps",param);
		responseData.put("type", "CREATEROOM");
		
		template.convertAndSend("/sub/chat/list",responseData);
	}
	
	}
