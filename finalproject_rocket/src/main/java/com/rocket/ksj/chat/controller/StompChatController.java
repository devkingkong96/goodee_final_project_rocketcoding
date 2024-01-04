package com.rocket.ksj.chat.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
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
	
	@MessageMapping("/chat/message")
	public void message(ChatMessage message) {
		log.info("메세지 보내기 성공");
		
		//채팅 메시지 저장
//		msgService.insertMessage(msg);
		
		template.convertAndSend("/sub/chat/room/"+message.getMsgRoomNo(),message);
	}
	
	
}
