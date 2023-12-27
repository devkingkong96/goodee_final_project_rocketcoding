package com.rocket.jsy.employee.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.rocket.jsy.employee.model.dto.Employee;

public interface EmployeeDao {
	List<Employee> selectEmployeeAll(SqlSession session);
	
	Employee selectEmployeeByNo(SqlSession session, String empNo);
	
	int insertEmployee(SqlSession session, Employee e);
	
	int updateEmployee(SqlSession session, Employee e);
}
