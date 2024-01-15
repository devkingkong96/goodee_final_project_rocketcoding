package com.rocket.jsy.employee.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

public interface EmployeeService {
	
	List<Map<String, Object>> selectEmployeeAll();
	
	List<Map<String, Object>> selectBranch();
    
    List<Map<String, Object>> selectDepartment();
    
    List<Map<String, Object>> selectDwrules();
    	
	List<Map<String, Object>> selectEmployeeHolidayAll();
	
	Map<String, Object> selectEmployeeByNo(int EmpNo);
	
	int insertEmployee(HashMap<String, Object>map);

	int updateEmpFile(String empFile, int empNo);
	
	int updateEmployee(HashMap<String, Object>updatemap);
	
}
