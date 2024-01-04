package com.rocket.jsy.employee.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class DepartmentDaoImpl implements DepartmentDao{
	@Override
	public List<Map<String,Object>>selectDepartmentAll(SqlSession session){
		return session.selectList("department.selectDepartmentAll");
	}
	@Override
	public void insertDepartment(SqlSession session, String depName) {
		session.insert("department.insertDepartment", depName);
	}
}
