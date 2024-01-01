package com.rocket.jsy.employee.service;

import java.util.List;
import java.util.Map;

import com.rocket.jsy.employee.model.dto.Employee;

public interface EmployeeService {
	
	List<Map<String, Object>> selectEmployeeAll();
	
	List<Employee> selectEmployeeHolidayAll();
	
	Employee selectEmployeeByNo(String EmpNo);
	
	int insertEmployee(Employee e);
	
	int updateEmployee(Employee e);

	List<Map<String, Object>> selectEmployeeMyPageCalendar();

	
}
