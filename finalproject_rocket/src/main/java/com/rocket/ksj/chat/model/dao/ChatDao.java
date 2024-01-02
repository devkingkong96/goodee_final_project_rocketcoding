package com.rocket.ksj.chat.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.rocket.ksj.chat.model.dto.EmpChat;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ChatDao {
	
	private final SqlSession session;
	
	//회원의 채팅방 가져오기
	public List<EmpChat> selectAllRooms(int empNo){
		return session.selectList("empchat.selectAllRooms",empNo);
	}
	
	
}
