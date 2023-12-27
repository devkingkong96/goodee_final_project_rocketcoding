package com.rocket.ksj.chat.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.rocket.jsy.employee.model.dto.Employee;
import com.rocket.ksj.chat.model.dao.MemberDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberService {
	
	private final MemberDao dao;
	private final SqlSession session;
	
	public List<Employee> selectEmployeeAll(){
		return dao.selectEmployeeAll(session);
	}
	
	public Employee selectEmployeeById(String empNo) {
		return dao.selectEmployeeById(session,empNo);
	}
}
