package com.rocket.ksj.chat.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.rocket.ksj.chat.model.dto.ChatRoom;

@Repository
public class ChatRoomDao {

	//채팅참여 중간 테이블 있는지 확인하는 메소드(회원번호,채팅참여 번호 체크)
	public int checkEmpChatByNo(SqlSession session,Map<String, String>no) {
		return session.selectOne("empchat.checkEmpChatByNo",no);
	}
	//ID로 특정 채팅방 정보 가져오기
	public ChatRoom selectRoomById(SqlSession session,int roomNo){
		return session.selectOne("chatroom.selectRoomById",roomNo);
	}
	
}
