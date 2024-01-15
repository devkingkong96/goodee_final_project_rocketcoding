package com.rocket.jsy.employee.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.rocket.jsy.employee.model.dao.MypageDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MypageServiceImpl implements MypageService{
	private final MypageDao dao;
	private final SqlSession session;
	
	@Override
	public void startWork(int empNo) {
		dao.startWork(session, empNo);
	}
	
	@Override
	public void endWork(int empNo) {
		dao.endWork(session, empNo);
	}
	
	@Override
	public Map<String, Object> selectEmployeeByNo(int EmpNo) {
		return dao.selectEmployeeByNo(session, EmpNo);
	}
	
	@Override
	public List<Map<String ,Object>> selectEmployeeByCalendar(int EmpNo){
		return dao.selectEmployeeByCalendar(session, EmpNo);
	}
}
