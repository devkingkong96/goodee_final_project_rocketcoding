package com.rocket.jsy.employee.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.rocket.jsy.employee.model.dto.Employee;

@Repository
public class EmployeeDaolmpl implements EmployeeDao{

	@Override
	public List<Map<String, Object>> selectEmployeeAll(SqlSession session) {
		return session.selectList("employee.selectEmployeeAll");
	}
	@Override
	public List<Map<String, Object>> selectEmployeeHolidayAll(SqlSession session) {
		return session.selectList("employee.selectEmployeeHolidayAll");
	}

	@Override
	public Map<String, Object> selectEmployeeByNo(SqlSession session, int empNo) {
		return session.selectOne("employee.selectEmployeeByNo",empNo);
	}

//	@Override
//    public int insertEmployee(SqlSession session, Map<String, Object> params) {
//        return session.insert("employee.insertEmployee", params);
//    }

	@Override
	public int updateEmployee(SqlSession session, Employee e) {
		return session.update("employee.updateEmployee",e);
	}
	@Override
	public List<Map<String, Object>> selectEmployeeMyPageCalendar(SqlSession session) {
	    return session.selectList("employee.selectEmployeeMyPageCalendar");
	}
	@Override
	public int insertEmployee(SqlSession session, Employee employee) {
	    return session.insert("employee.insertEmployee", employee);
	}
	
}
