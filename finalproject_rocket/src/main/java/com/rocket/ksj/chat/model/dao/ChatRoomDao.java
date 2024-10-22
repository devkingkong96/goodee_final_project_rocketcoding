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
	public Map<String, Object> selectRoomById(SqlSession session,int roomNo){
		return session.selectOne("chatroom.selectRoomById",roomNo);
	}
	//해당 채팅방의 인원수 가져오기
	public int numberOfChatRoom(SqlSession session,int roomId) {
		return session.selectOne("chatroom.numberOfChatRoom",roomId);
	}
	//채팅방 이름으로 채팅방 생성
	public int createChatRoom(SqlSession session,String roomName) {
		return session.insert("chatroom.createChatRoom",roomName);
	}
	//직원마다 중간 테이블 생성
	public int createEmpChat(SqlSession session,int empNo) {
		return session.insert("empchat.createEmpChat",empNo);
	}
	//채팅방 번호로 채팅메시지 삭제
	public int deleteRoomByNo(SqlSession session,int roomNo) {
		return session.delete("chatroom.deleteRoomByNo",roomNo);
	}
	//채팅방 번호로 채팅참여 중간 테이블 삭제
	public int deleteEmpChatByNo(SqlSession session,int roomNo) {
		return session.delete("empchat.deleteEmpChatByNo",roomNo);
	}
	//채팅방 번호로 채팅메시지 삭제
	public int deleteMessageByNo(SqlSession session,int roomNo) {
		return session.delete("chatmessage.deleteMessageByNo",roomNo);
	}
	//채팅방 나가기(숨기기) ->채팅방에서
	public int deleteEmpChatRoomById(SqlSession session,Map<String, Object>param) {
		return session.delete("empchat.deleteEmpChatRoomById",param);
	}
	//채팅방 나가기(숨기기) ->채팅 목록에서
	public int hiderooms(SqlSession session,Map<String, Object> param) {
		return session.update("empchat.hideRoomById",param);
	}
	//채팅방에서 직원 초대하기 ->채팅방에서
	public int plusEmpChat(SqlSession session,Map<String, Object> param) {
		return session.insert("empchat.plusEmpChat",param);
	}
	//채팅방 첫 생성 인원수 증가
//	public int listEmpCountPlus(SqlSession session) {
//		return session.update("empchat.listEmpCountPlus");
//	}
//	//채팅방 중간 테이블 생성 인원수 증가
//	public int roomEmpCountPlus(SqlSession session,int roomId) {
//		return session.update("empchat.roomEmpCountPlus",roomId);
//	}
//	//채팅방 나가기(인원수 감소)
//	public int empCountMinus(SqlSession session,int roomId) {
//		return session.update("empchat.empCountMinus",roomId);
//	}
}
