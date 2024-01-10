package com.rocket.pdw.aprv.model.service;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.rocket.pdw.aprv.model.dao.ApprovalDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ApprovalServiceImpl implements ApprovalService{
	private final ApprovalDao dao;
	private final SqlSession session;
	@Override
	public List<Map<String,Object>> selectAprvList(int no) {
		
		return dao.selectAprvList(session,no);
	}
	@Override
	public List<Map<String, Object>> ckLvList(List<Map<String, Object>> ckLvList) {
		
		return dao.ckLvList(session,ckLvList);
	}
	@Override
	public List<Map<String, Object>> findName(Integer depCode) {
		
		return dao.findName(session,depCode);
	}
	@Override
	public List<Map<String,Object>> selectEmployee(int no) {
		 
		return dao.selectEmployee(session,no);
	}
	@Override
	public int insertAprvDocu(Map<String, Object> reqAll) {
		
		return dao.insertAprvDocu(session,reqAll);
	}
	
	
	
}

