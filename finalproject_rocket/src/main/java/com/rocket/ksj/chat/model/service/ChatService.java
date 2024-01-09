package com.rocket.ksj.chat.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.rocket.ksj.chat.model.dao.ChatDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor

public class ChatService {

	private final ChatDao dao;
	private final SqlSession session;
	
	//전직원 조회하기
	public List<Map<String, Object>>selectEmployeeAll(int empNo){
		return dao.selectEmployeeAll(session,empNo);
	}
	//채팅방,채팅참여(중간테이블) 전체 조회하기
	public List<Map<String, Object>>selectChatAll(int empNo){
		return dao.selectChatAll(session,empNo);
	}
	//채팅방 생성
	public int createChatRoom(int count) {
		return dao.createChatRoom(session,count);
	}
	//채팅방 전체 조회하기
	public List<Map<String, Object>>selectRoomAll(){
		return dao.selectRoomAll(session);
	}
	
	
}
