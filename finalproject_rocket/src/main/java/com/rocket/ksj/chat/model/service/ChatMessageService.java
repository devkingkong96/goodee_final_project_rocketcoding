package com.rocket.ksj.chat.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.rocket.ksj.chat.model.dao.ChatMessageDao;
import com.rocket.ksj.chat.model.dto.ChatMessage;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ChatMessageService {

	private final ChatMessageDao dao;
	private final SqlSession session;
	
	//해당 채팅방 모든 메시지 출력
	public List<Map<String, Object>> selectChatMessageByNo(int roomNo){
		return dao.selectChatMessageByNo(session,roomNo);
	}
	
	//메시지 저장
	public int insertMessage(ChatMessage msg) {
		return dao.insertMessage(session,msg);
	}
}
