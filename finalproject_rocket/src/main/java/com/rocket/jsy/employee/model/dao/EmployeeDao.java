package com.rocket.jsy.employee.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.rocket.jsy.employee.model.dto.Employee;

public interface EmployeeDao {
	List<Map<String, Object>> selectEmployeeAll(SqlSession session);
	
	List<Employee>selectEmployeeHolidayAll(SqlSession session);
	
	Employee selectEmployeeByNo(SqlSession session, String empNo);
	
	int insertEmployee(SqlSession session, Employee e);
	
	int updateEmployee(SqlSession session, Employee e);

	List<Map<String, Object>> selectEmployeeMyPageCalendar(SqlSession session);
}
