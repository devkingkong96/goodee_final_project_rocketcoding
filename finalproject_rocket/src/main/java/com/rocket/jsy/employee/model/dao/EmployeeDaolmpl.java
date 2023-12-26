package com.rocket.jsy.employee.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.rocket.jsy.employee.model.dto.Employee;

public class EmployeeDaolmpl implements EmployeeDao{

	@Override
	public List<Employee> selectEmployeeAll(SqlSession session) {
		return session.selectList("");
	}

	@Override
	public Employee selectEmployeeByNo(SqlSession session, String empNo) {
		return session.selectOne("",empNo);
	}

	@Override
	public int insertEmployee(SqlSession session, Employee e) {
		return session.insert("",e);
	}

	@Override
	public int updateEmployee(SqlSession session, Employee e) {
		return session.update("",e);
	}
	
}
