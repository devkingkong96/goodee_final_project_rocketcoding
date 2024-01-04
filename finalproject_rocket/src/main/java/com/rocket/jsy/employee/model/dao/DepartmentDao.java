package com.rocket.jsy.employee.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

public interface DepartmentDao {
	List<Map<String,Object>>selectDepartmentAll(SqlSession session);
	void insertDepartment(SqlSession session, String depName);
}

