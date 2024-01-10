package com.rocket.psh.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.rocket.psh.board.model.dto.Fboard;

public interface BoardDao {
   
	List<Map<String, Object>> selectFboardList(SqlSession session, Map<String,Object> param);
	
	int insertFboard(SqlSession session,Fboard fboard);
	
	Map<String, Object> selectFboardDetail(SqlSession session, int fboardNo);
	
	int updateFboard(SqlSession session,Map<String, Object> map);
	
	int deleteFboard(SqlSession session,int fboardNo);
	
	int increaseViewCount(SqlSession session, int fboardNo);
	
	List<Map<String,Object>> selectFboardComments(SqlSession session, int fboardNo);
	
	
}
