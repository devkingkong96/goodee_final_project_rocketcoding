package com.rocket.jsy.employee.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.rocket.jsy.employee.model.dto.Employee;

public interface EmployeeService {
	
	List<Map<String, Object>> selectEmployeeAll();
	
	List<Map<String, Object>> selectEmployeeHolidayAll();
	
	Map<String, Object> selectEmployeeByNo(int EmpNo);
	
//	int insertEmployee(Employee employee, int dwrulesCode);
	
	int insertEmployee(Employee employee);

	List<Map<String, Object>> selectEmployeeMyPageCalendar();

	
}
