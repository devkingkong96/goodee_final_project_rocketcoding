package com.rocket.jsy.employee.service;

import java.sql.Timestamp;
import java.util.Map;

public interface MypageService {
	void startWork(int empNo);
	void endWork(int empNo);
	Map<String, Object> selectEmployeeByNo(int EmpNo);

}
