package com.rocket.jsy.employee.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.rocket.jsy.employee.model.dao.DwRulesDao;
import com.rocket.jsy.employee.model.dto.DwRules;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class DwRulesServiceImpl implements DwRulesService{
	
	private final DwRulesDao dao;
	private final SqlSession session;
	
	@Override
	public List<Map<String,Object>>selectDwRulesAll(){
		return dao.selectDwRulesAll(session);
	}
	@Override
	@Transactional
	public void addDwRules(DwRules dwRules) {
	    log.info("dwrulesStart: {}, dwrulesEnd: {}, dwrulesEarly: {}", 
        dwRules.getDwrulesStart(), dwRules.getDwrulesEnd(), dwRules.getDwrulesEarly());
	    dao.insertDwRules(session, dwRules);
	}
	@Override
	public void deleteDwRule(String comNo) {
	    dao.deleteDwRule(session, comNo);
	}
}
