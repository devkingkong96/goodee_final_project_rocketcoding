package com.rocket.ksj.chat.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.rocket.ksj.chat.model.dto.EmpChat;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ChatDao {
	
	//채팅창 직원 목록 가져오기
	public List<Map<String, Object>>selectEmployeeAll(SqlSession session){
		return session.selectList("employee.selectEmployeeAll");
	}
	
	
	
	//회원의 채팅방 가져오기
	public List<EmpChat> selectAllRooms(int empNo,SqlSession session){
		return session.selectList("empchat.selectAllRooms",empNo);
	}
	
	
	
}
