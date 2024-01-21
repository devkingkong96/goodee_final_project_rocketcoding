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
	List<Map<String,Object>>selectAprvDocu(SqlSession session,int docNo);
	int updateAprv(SqlSession session,Map<String,Object>reqAll);
	int rejectAprv(SqlSession session,Map<String,Object>reqAll);
	List<Map<String,Object>>cheackSaveFile(SqlSession session,int no);
	int saveDocu(SqlSession session, Map<String,Object>reqAll);
	int deleteSaveFile(SqlSession session, int no);
	List<Map<String,Object>>selectSaveList(SqlSession session,int no);
	int countSaveList(SqlSession session, int no);
}
