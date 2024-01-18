package com.rocket.jsy.employee.service;

import java.util.List;
import java.util.Map;

public interface CommuteService {
	List<Map<String, Object>> selectCommuteAll();
    List<Map<String, Object>> selectEmployeeByCalendar(String employeeName);
    Map<String, Object> selectcommuteByName(String employeeName);
    List<Map<String, Object>> employeesearch(String employeeName);
}
