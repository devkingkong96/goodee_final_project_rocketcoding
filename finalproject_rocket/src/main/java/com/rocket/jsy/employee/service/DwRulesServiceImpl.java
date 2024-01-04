package com.rocket.jsy.employee.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.rocket.jsy.employee.model.dao.DwRulesDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DwRulesServiceImpl implements DwRulesService{
	
	private final DwRulesDao dao;
	private final SqlSession session;
	
	@Override
	public List<Map<String,Object>>selectDwRulesAll(){
		return dao.selectDwRulesAll(session);
	}
}
