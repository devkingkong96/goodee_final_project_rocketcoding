package com.rocket.ksj.chat.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.rocket.ksj.chat.model.dao.ChatRoomDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ChatRoomService {
	
	private final ChatRoomDao dao;
	private final SqlSession session;
	
	//채팅참여 중간 테이블 있는지 확인하는 메소드(회원번호,채팅참여 번호 체크)
	public int checkEmpChatByNo(Map<String, String>no) {
		return dao.checkEmpChatByNo(session,no);
	}
	
	public List<Map<String, Object>>selectRoomById(int roomNo){
		return dao.selectRoomById(session,roomNo);
	}
}
