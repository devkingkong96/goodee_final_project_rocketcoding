package com.rocket.jsy.employee.service;

import java.util.List;
import java.util.Map;

public interface DepartmentService {
	List<Map<String,Object>> selectDepartmentAll();
	void addDepartment(String depName);
}
