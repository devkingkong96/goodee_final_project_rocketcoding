package com.rocket.pdw.aprv.model.service;


import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.rocket.pdw.aprv.model.dao.ApprovalDao;
import com.rocket.pdw.aprv.model.dto.Tag;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ApprovalService {
	private final ApprovalDao dao;
	private final SqlSession session; 
	
	public int inserttag(Tag dt) {
		return dao.inserttag(session,dt);
		
	}
}
