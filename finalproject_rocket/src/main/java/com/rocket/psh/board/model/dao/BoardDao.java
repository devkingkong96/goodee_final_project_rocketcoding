package com.rocket.psh.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.rocket.psh.board.model.dto.Fboard;

public interface BoardDao {
		List<Fboard> selectBorad(SqlSession session, Map<String,Integer>page);
			
		int selectFboardCount(SqlSession session);
			
		Fboard selectBoardByNo(SqlSession session,int boardNo);
			
		int insertFboard(SqlSession session,Fboard b);
}
