package com.rocket.ksj.chat.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;



@Repository
public class ChatDao {
	
	
	//채팅창 직원 목록 가져오기
	public List<Map<String, Object>>selectEmployeeAll(SqlSession session,int roomId){
		return session.selectList("empchat.selectEmployeeAll",roomId);
	}
	//회원 정보 가져오기(DEPT JOIN)
	public Map<String, Object>selectEmpInfo(SqlSession session,int empNo){
		return session.selectOne("empchat.selectEmpInfo",empNo);
	}
	//회원의 채팅방,중간테이블 가져오기
	public List<Map<String, Object>> selectChatAll(SqlSession session,int empNo){
		return session.selectList("empchat.selectChatAll",empNo);
	}
	//채팅방 생성
	public int createChatRoom(SqlSession session,int count) {
		return session.insert("chatroom.createChatRoom",count);
	}
	//채팅방 전체 출력하기
	public List<Map<String, Object>>selectRoomAll(SqlSession session){
		return session.selectList("chatroom.selectRoomAll");
	}
	//채팅방 직원 목록 가져오기
	public List<Map<String, Object>>selectEmployeeInRoom(SqlSession session,int roomNo){
		return session.selectList("chatroom.selectEmployeeInRoom",roomNo);
	}
	//ajax 채팅방 직원 목록 검색
	public List<Map<String, Object>>modalSearch(SqlSession session,Map<String, Object> param){
		return session.selectList("chatroom.modalSearch",param);
	}
	
}
