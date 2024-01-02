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
	
	public List<Map<String, Object>>selectEmployeeAll(){
		return dao.selectEmployeeAll(session);
	}
}
