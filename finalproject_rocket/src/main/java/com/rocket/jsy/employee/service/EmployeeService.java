package com.rocket.jsy.employee.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.rocket.jsy.employee.model.dto.Employee;

public interface EmployeeService {
	
	List<Map<String, Object>> selectEmployeeAll();
	
	List<Map<String, Object>> selectBranch();
    
    List<Map<String, Object>> selectDepartment();
    
    List<Map<String, Object>> selectDwrules();
	
	List<Map<String, Object>> selectEmployeeHolidayAll();
	
	Map<String, Object> selectEmployeeByNo(int EmpNo);
	
	int insertEmployee(Employee employee);

	List<Map<String, Object>> selectEmployeeMyPageCalendar();

	
}
