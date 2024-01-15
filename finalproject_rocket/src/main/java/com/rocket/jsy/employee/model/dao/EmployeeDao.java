package com.rocket.jsy.employee.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.web.multipart.MultipartFile;

public interface EmployeeDao {
	List<Map<String, Object>> selectEmployeeAll(SqlSession session);
	List<Map<String, Object>> selectBranch(SqlSession session);
    List<Map<String, Object>> selectDepartment(SqlSession session);
    List<Map<String, Object>> selectDwrules(SqlSession session);
    
	List<Map<String, Object>> selectEmployeeHolidayAll(SqlSession session);
	
	Map<String, Object> selectEmployeeByNo(SqlSession session, int empNo);
	
//	int insertEmployee(SqlSession session, Map<String, Object> params);
	
	int insertEmployee(SqlSession session, HashMap<String, Object> employee);
	
    int updateEmpFile(SqlSession session, String empFile, int empNo);
	
	int updateEmployee(SqlSession session, HashMap<String, Object> employee);
}
