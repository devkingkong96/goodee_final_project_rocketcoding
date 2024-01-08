package com.rocket.ksj.chat.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.rocket.ksj.chat.model.dao.ChatRoomDao;
import com.rocket.ksj.chat.model.dto.ChatRoom;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ChatRoomService {
	
	private final ChatRoomDao dao;
	private final SqlSession session;
	
	//채팅참여 중간 테이블 있는지 확인하는 메소드(회원번호,채팅참여 번호 체크)
	public int checkEmpChatByNo(Map<String, String>no) {
		return dao.checkEmpChatByNo(session,no);
	}
	
	public ChatRoom selectRoomById(int roomNo){
		return dao.selectRoomById(session,roomNo);
	}
	
//	@Transactional
//	public int createChatRoom(HashMap<String, Object>req) {
//		dao.createChatRoom(session,req);
//		String [] employees=(String[])req.get("empCheck");
//		for(String e:employees) {
//			dao.createEmpChat(session,e);
//			log.info("직원 리스트 {}",e);
//		}
//	}
}
