package com.rocket.ksj.chat.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
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
//		headerAccessor.getSessionAttributes().put(null, headerAccessor);
		
		template.convertAndSend("/sub/chat/room/"+message.getMsgRoomNo(),message);
	}
	
	//채팅 메시지 전송
	@MessageMapping("/chat/sendMessage")
	public void sendMessage(ChatMessage message) {
		log.info("채팅메시지 발송 {}",message);
		
		//채팅 메시지 저장
		//msgService.insertMessage(msg);
		template.convertAndSend("sub/chat/room/"+message.getMsgRoomNo(),message);
	}
	
}
