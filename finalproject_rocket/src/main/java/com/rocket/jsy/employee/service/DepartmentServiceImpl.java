package com.rocket.jsy.employee.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.rocket.jsy.employee.model.dao.DepartmentDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DepartmentServiceImpl implements DepartmentService{
	private final DepartmentDao dao;
	private final SqlSession session;
	
	@Override
	public List<Map<String,Object>>selectDepartmentAll(){
		return dao.selectDepartmentAll(session);
	}
	@Override
	public void addDepartment(String depName) {
		dao.insertDepartment(session, depName);
	}
}
