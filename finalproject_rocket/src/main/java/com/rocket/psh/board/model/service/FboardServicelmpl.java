package com.rocket.psh.board.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.rocket.psh.board.model.dao.BoardDao;
import com.rocket.psh.board.model.dto.Fboard;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FboardServicelmpl implements FboardService {
	
	public final BoardDao dao;
	public final SqlSession session;
	@Override
	public List<Map<String, Object>> selectFboardList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return dao.selectFboardList(session, map);
	}
	@Override
	public int insertFboard(Fboard fboard) {
		// TODO Auto-generated method stub
		return dao.insertFboard(session, fboard);
	}
	@Override
	public int increaseViewCount(int fboardNo) {
		// TODO Auto-generated method stub
		return dao.increaseViewCount(session,fboardNo);
	}
	@Override
	public Map<String, Object> selectFboardDetail(int fboardNo) {
		// TODO Auto-generated method stub
		return dao.selectFboardDetail(session, fboardNo);
	}
	@Override
	public List<Map<String, Object>> selectFboardComments(int fboardNo) {
		// TODO Auto-generated method stub
		return dao.selectFboardComments(session,fboardNo);
	}
	@Override
	public int updateFboard(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return dao.updateFboard(session, map);
	}
	@Override
	public int deleteFboard(int fboardNo) {
		// TODO Auto-generated method stub
		return dao.deleteFboard(session, fboardNo);
	}
	

	
			
}
