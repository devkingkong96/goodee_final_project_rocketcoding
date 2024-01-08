package com.rocket.psh.board.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.rocket.psh.board.model.dao.BoardDao;

import lombok.RequiredArgsConstructor;
@Service
@RequiredArgsConstructor
public class FboardServicelmpl implements FboardService {
	
	public final BoardDao dao;
	public final SqlSession session;
	
	@Override
	public List<Map<String, Object>> selectFboardList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public int insertFboard(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public Map<String, Object> selectFboardDetail(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public int updateFboard(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public int deleteFboard(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}
		
}
