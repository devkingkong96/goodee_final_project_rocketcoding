package com.rocket.jsy.employee.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.rocket.jsy.employee.model.dto.Employee;

@Repository
public class EmployeeDaolmpl implements EmployeeDao{

	@Override
	public List<Employee> selectEmployeeAll(SqlSession session) {
		return session.selectList("employee.selectEmployeeAll");
	}

	@Override
	public Employee selectEmployeeByNo(SqlSession session, String empNo) {
		return session.selectOne("employee.selectEmployeeByNo",empNo);
	}

	@Override
	public int insertEmployee(SqlSession session, Employee e) {
		return session.insert("employee.insertEmployee",e);
	}

	@Override
	public int updateEmployee(SqlSession session, Employee e) {
		return session.update("employee.updateEmployee",e);
	}
	
}
