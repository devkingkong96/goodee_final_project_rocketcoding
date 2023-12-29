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
	
	
	private final SqlSession session;
	
	private final BoardDao dao;
	
	

	@Override
	public int selectFboardCount() {
		return dao.selectFboardCount(session);
	}

	@Override
	public Fboard selectBoardByNo(int boardNo) {
		return dao.selectBoardByNo(session, boardNo);
	}

	@Override
	public int insertFboard(Fboard b) {
		return dao.insertFboard(session, b);
	}

	@Override
	public List<Fboard> selectBoard(Map<String, Integer> page) {
		// TODO Auto-generated method stub
		return dao.selectBoard(session, page);
	}

}
