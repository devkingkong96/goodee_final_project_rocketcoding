package com.rocket.jsy.employee.model.dao;

import java.sql.Timestamp;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class MypageDaoImpl implements MypageDao{
	
	@Override
	public void startWork(SqlSession session,int empNo) {
		session.insert("commute.startWork",empNo);
	}
	
	@Override
	public void endWork(SqlSession session,int empNo) {
		session.insert("commute.endWork",empNo);
	}
	
	@Override
	public Map<String, Object> selectEmployeeByNo(SqlSession session, int empNo) {
		return session.selectOne("commute.selectCommuteSum",empNo);
	}
}
