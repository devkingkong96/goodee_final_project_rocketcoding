package com.rocket.jsy.employee.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.rocket.jsy.employee.model.dao.CommuteDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CommuteServiceImpl implements CommuteService{
	
	private final CommuteDao dao;
	private final SqlSession session;
	
	@Override
	public List<Map<String, Object>> selectCommuteAll() {
		return dao.selectCommuteAll(session);
	}
	
	@Override
    public List<Map<String, Object>> selectEmployeeByCalendar(String employeeName) {
        return dao.selectEmployeeByCalendar(session, employeeName);
    }
	
	@Override
	public Map<String, Object> selectcommuteByName(String employeeName){
		return dao.selectcommuteByName(session, employeeName);
	}
	
	@Override
	public List<Map<String, Object>> employeesearch(String employeeName){
		return dao.employeesearch(session, employeeName);
	}
}
