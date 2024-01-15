package com.rocket.jsy.employee.service;

import java.util.List;
import java.util.Map;

public interface MypageService {
	void startWork(int empNo);
	void endWork(int empNo);
	Map<String, Object> selectEmployeeByNo(int EmpNo);
	List<Map<String, Object>> selectEmployeeByCalendar(int EmpNo);
}
