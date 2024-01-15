package com.rocket.ksj.chat.model.service;

import java.util.HashMap;
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
	//해당 채팅방의 정보 가져오기
	public Map<String, Object> selectRoomById(int roomNo){
		return dao.selectRoomById(session,roomNo);
	}
	//채팅방,채팅참여 중간 테이블 생성
	@Transactional
	public String createChatRoomAll(HashMap<String, Object>req) {
		String roomName=(String)req.get("roomName");
		log.info("방 이름 {}",roomName);
		//채팅방 생성
		dao.createChatRoom(session,roomName);
		
		//채팅방 생성자의 중간 테이블 생성
		String logempNoStr=(String)req.get("logempNo");
		int logempNo=Integer.parseInt(logempNoStr);
		log.info("로그인한 회원 번호{}",logempNo);
		dao.createEmpChat(session, logempNo);
		
		//초대된 회원마다 채팅참여 중간 테이블 생성
		if(req.get("empCheck")!=null) {
			//1:1 개인방
			if(req.get("empCheck") instanceof String) {
				int empNo=Integer.parseInt((String)req.get("empCheck"));
				dao.createEmpChat(session,empNo);
				//1:N 단체방
			}else if(req.get("empCheck") instanceof String[]) {
				String [] employees=(String[])req.get("empCheck");
				for(String e:employees) {
					int empNo=Integer.parseInt(e);
					dao.createEmpChat(session,empNo);
				}
			}
		}
		return "success";
	}
	//채팅방,채팅 참여 중간테이블,채팅메시지 삭제
//	@Transactional
//	public String deleteRoomAll(HashMap<String, Object>req) {
//		if(req.get("roomCheck")!=null) {
//			//방 한개만 삭제
//			if(req.get("roomCheck") instanceof String) {
//				int roomNo=Integer.parseInt((String)req.get("roomCheck"));
//				dao.deleteRoomByNo(session,roomNo);
//				dao.deleteEmpChatByNo(session,roomNo);
//				dao.deleteMessageByNo(session,roomNo);
//			//여러방 삭제
//			}else if(req.get("roomCheck") instanceof String[]) {
//				String [] rooms=(String[])req.get("roomCheck");
//				for(String room:rooms) {
//					int roomNo=Integer.parseInt(room);
//					dao.deleteRoomByNo(session,roomNo);
//					dao.deleteEmpChatByNo(session,roomNo);
//					dao.deleteMessageByNo(session,roomNo);
//				}
//			}
//		}
//		return "success";
//	}
	//채팅방 나가기(숨기기) ->채팅 목록에서
	@Transactional
	public String hiderooms(HashMap<String, Object>req) {
		Map<String, Object>param=new HashMap<>();
		if(req.get("roomCheck")!=null) {
			//방 한개만 나가기
			if(req.get("roomCheck") instanceof String) {
				int roomId=Integer.parseInt((String)req.get("roomCheck"));
				int empNo=Integer.parseInt((String)req.get("logempNo"));
				param.put("roomId", roomId);
				param.put("empNo", empNo);
				dao.hiderooms(session,param);
			//여러방 나가기
			}else if(req.get("roomCheck") instanceof String[]) {
				String [] rooms=(String[])req.get("roomCheck");
				for(String room:rooms) {
					int roomId=Integer.parseInt(room);
					int empNo=Integer.parseInt((String)req.get("logempNo"));
					param.put("roomId", roomId);
					param.put("empNo", empNo);
					dao.hiderooms(session,param);
				}
			}
		}
		return "success";
	}
	//방 나가기(방 숨기기)
	public int hideRoomById(Map<String, Object>param) {
		return dao.hideRoomById(session,param);
	}
	
}
