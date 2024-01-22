package com.rocket.pdw.aprv.model.service;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.rocket.jsy.employee.model.dto.Employee;
import com.rocket.pdw.aprv.model.dao.ApprovalDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@EnableScheduling
@Slf4j
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
	@Override
	public List<Map<String, Object>> selectAprvDocu(int docNo) {
		
		return dao.selectAprvDocu(session,docNo);
	}
	@Override
	public int updateAprv(Map<String, Object> reqAll) {
		// TODO Auto-generated method stub
		return dao.updateAprv(session,reqAll);
	}
	@Override
	public int rejectAprv(Map<String, Object> reqAll) {
		// TODO Auto-generated method stub
		return dao.rejectAprv(session,reqAll);
	}
	@Override
	public List<Map<String, Object>> cheackSaveFile(int no) {
		
		return dao.cheackSaveFile(session,no);
	}
	@Override
	public int saveDocu(Map<String, Object> reqAll) {
		// TODO Auto-generated method stub
		return dao.saveDocu(session,reqAll);
	}
	
	@Override
	public int deleteSaveFile() {
		// TODO Auto-generated method stub
		return dao.deleteSaveFile(session);
	}
	
	@Override
	public List<Map<String, Object>> selectSaveList(int no) {
		
		return dao.selectSaveList(session, no);
	}
	@Override
	public int countSaveList(int no) {
		// TODO Auto-generated method stub
		return dao.countSaveList(session, no);
	}
	
	@Scheduled(cron = "0 0 22 L * ?")
	public void deleteSaveFileRun() {
		int result = deleteSaveFile();
		log.info("삭제",result);

	}
	
}

