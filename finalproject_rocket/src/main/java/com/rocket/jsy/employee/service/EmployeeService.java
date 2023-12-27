package com.rocket.jsy.employee.service;

import java.util.List;

import com.rocket.jsy.employee.model.dto.Employee;

public interface EmployeeService {
	
	List<Employee> selectEmployeeAll();
	
	Employee selectEmployeeByNo(String EmpNo);
	
	int insertEmployee(Employee e);
	
	int updateEmployee(Employee e);
}
