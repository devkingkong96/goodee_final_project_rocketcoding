package com.rocket.ksj.chat.controller;

import java.util.Date;
import java.sql.Timestamp;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import com.rocket.ksj.chat.model.dto.ChatMessage;
import com.rocket.ksj.chat.model.service.ChatMessageService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class StompChatController {

	private final SimpMessagingTemplate template;
	private final ChatMessageService msgService;
	
	//채팅방 입장
	@MessageMapping("/chat/enter")
	public void message(ChatMessage message,SimpMessageHeaderAccessor headerAccessor) {
		log.info("{} 채팅방 입장 성공",message.getMsgEmpNo());
		
		int roomNo=message.getMsgRoomNo();
		
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
		}else {
			log.info("실패");
		}
		
		
		template.convertAndSend("/sub/chat/room/"+message.getMsgRoomNo(),message);
	}
	
}
