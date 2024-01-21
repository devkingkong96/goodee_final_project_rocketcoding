package com.rocket.pdw.aprv.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface ApprovalService {
	List<Map<String,Object>> selectAprvList (int no);
	
	List<Map<String,Object>> ckLvList (List<Map<String,Object>>ckLvList);
	
	List<Map<String,Object>>findName (Integer depCode);
	
	List<Map<String,Object>>selectEmployee (int no);
	
	int insertAprvDocu(Map<String,Object>reqAll);
	
	List<Map<String,Object>>selectAprvDocu(int docNo);
	
	int updateAprv(Map<String,Object>reqAll);
	
	int rejectAprv(Map<String,Object>reqAll);
	
	List<Map<String,Object>> cheackSaveFile (int no);
	
	int saveDocu(Map<String,Object>reqAll);
	
	int deleteSaveFile(int no);
	
}
