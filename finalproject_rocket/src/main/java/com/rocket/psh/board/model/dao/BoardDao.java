package com.rocket.psh.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.rocket.psh.board.model.dto.Fboard;
import com.rocket.psh.board.model.dto.FboardFile;

public interface BoardDao {
   
	List<Map<String, Object>> selectFboardList(SqlSession session, Map<String,Object> param);
	
	int insertFboard(SqlSession session,Fboard fboard);
	
	Fboard selectFboardDetail(SqlSession session, int fboardNo);
	
	int updateFboard(SqlSession session, Fboard fboard);
	
	int deleteFboard(SqlSession session,int fboardNo);
	
	int increaseViewCount(SqlSession session, int fboardNo);
	
	List<Map<String,Object>> selectFboardComments(SqlSession session, int fboardNo);
	
	int insertFboardFile(SqlSession session, FboardFile ff);
	
	int deleteFile(SqlSession session, int boardNo);
	
	int updateFile(SqlSession session, FboardFile ff);
}
