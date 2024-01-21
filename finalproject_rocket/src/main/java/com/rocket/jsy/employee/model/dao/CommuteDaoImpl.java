package com.rocket.jsy.employee.model.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class CommuteDaoImpl implements CommuteDao{
	@Override
	public List<Map<String, Object>> selectCommuteAll(SqlSession session) {
		return session.selectList("commute.selectCommuteAll");
	}
	@Override
    public List<Map<String, Object>> selectEmployeeByCalendar(SqlSession session, String employeeName) {
        return session.selectList("employee.selectEmployeeByCalendar", employeeName);
    }
	@Override
	public Map<String, Object> selectcommuteByName(SqlSession session, String employeeName){
		return session.selectOne("employee.selectcommuteByName",employeeName);
	}
	@Override
	public List<Map<String, Object>> employeesearch(SqlSession session, String employeeName){
		return session.selectList("employee.employeesearch",employeeName);
	}
}
