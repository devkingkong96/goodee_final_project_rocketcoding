package com.rocket.seoj.logistics.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.rocket.seoj.logistics.model.dao.LogisticsDao;
import com.rocket.seoj.logistics.model.dto.Inventory;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class LogisticsService {
	
	private final LogisticsDao dao;
	private final SqlSession session;
	
	// 가안
	@Transactional
	public List<Inventory> selectAllInventories() {
		return dao.selectAllInventories(session);
	}
	
}
