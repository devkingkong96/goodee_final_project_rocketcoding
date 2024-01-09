package com.rocket.pdw.aprv.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface ApprovalService {
	List<Map<String,Object>> selectAprvList (int no);
	
	List<Map<String,Object>> ckLvList (List<Map<String,Object>>ckLvList);
	
	List<Map<String,Object>>findName (Integer depCode);
	
	List<Map<String,Object>>selectEmployee (int no);
}
