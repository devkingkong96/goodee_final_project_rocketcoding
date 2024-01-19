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
	public List<Map<String, Object>>selectEmployeeAll(int roomId){
		return dao.selectEmployeeAll(session,roomId);
	}
	//로그인한 회원 제외한 직원 목록 가져오기
	public List<Map<String, Object>>selectEmployeeList(int empNo){
		return dao.selectEmployeeList(session,empNo);
	}
	
	//직원 정보 가져오기
	public Map<String, Object>selectEmpInfo(int empNo){
		return dao.selectEmpInfo(session,empNo);
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
	//채팅방 직원 목록 가져오기
	public List<Map<String, Object>>selectEmployeeInRoom(int roomNo){
		return dao.selectEmployeeInRoom(session,roomNo);
	}
	//ajax 채팅방 직원 목록 검색
	public List<Map<String, Object>>modalSearch(Map<String, Object> param){
		return dao.modalSearch(session,param);
	}
}
