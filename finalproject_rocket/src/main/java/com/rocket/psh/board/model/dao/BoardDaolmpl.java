package com.rocket.psh.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.rocket.psh.board.model.dto.Fboard;
@Repository
public class BoardDaolmpl implements BoardDao {

	@Override
	public List<Map<String, Object>> selectBoard(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertFboard(Fboard fboard) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Fboard selectBoardByNo(int boardNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateFboard(Fboard fboard) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteFboard(int boardNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	

}
