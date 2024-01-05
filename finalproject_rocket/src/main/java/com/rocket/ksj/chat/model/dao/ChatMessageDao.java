package com.rocket.ksj.chat.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.rocket.ksj.chat.model.dto.ChatMessage;

@Repository
public class ChatMessageDao {

	public List<Map<String,Object>>selectChatMessageByNo(SqlSession session,int roomNo){
		return session.selectList("chatmessage.selectChatMessageByNo",roomNo);
	}
	
	public int insertMessage(SqlSession session,ChatMessage msg) {
		return session.insert("chatmessage.insertMessage",msg);
	}
}
