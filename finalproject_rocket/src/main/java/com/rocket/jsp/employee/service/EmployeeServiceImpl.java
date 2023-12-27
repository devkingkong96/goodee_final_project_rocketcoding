package com.rocket.jsp.employee.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.rocket.jsy.employee.model.dao.EmployeeDao;
import com.rocket.jsy.employee.model.dto.Employee;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EmployeeServiceImpl implements EmployeeService{
	
	private final EmployeeDao dao;
	private final SqlSession session;
	
	@Override
	public List<Employee> selectEmployeeAll() {
		return dao.selectEmployeeAll(session);
	}
	@Override
	public Employee selectEmployeeByNo(String EmpNo) {
		return dao.selectEmployeeByNo(session, EmpNo);
	}
	@Override
	public int insertEmployee(Employee e) {
		return dao.insertEmployee(session, e);
	}
	@Override
	public int updateEmployee(Employee e) {
		return dao.updateEmployee(session, e);
	}
	

	
}
