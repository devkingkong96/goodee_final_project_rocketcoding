package com.rocket.pdw.aprv.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

public interface ApprovalDao {
	List<Map<String,Object>> selectAprvList(SqlSession session, int no);
	List<Map<String,Object>> ckLvList(SqlSession session,List<Map<String, Object>> ckLvList);
	List<Map<String,Object>> findName(SqlSession session,Integer depCode);
	List<Map<String,Object>> selectEmployee(SqlSession session, int no);
	int insertAprvDocu(SqlSession session,Map<String, Object> reqAll);
}
