package com.rocket.pdw.aprv.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.HttpClientErrorException.BadRequest;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Repository
public class ApprovalDaoImpl implements ApprovalDao{


	@Override
	public List<Map<String, Object>> selectAprvList(SqlSession session, int no) {
		
		return session.selectList("approval.selectAprvList",no);
	}

	@Override
	public List<Map<String, Object>> ckLvList(SqlSession session, List<Map<String, Object>> ckLvList) {
	    List<Map<String, Object>> result = new ArrayList<>();
	    
	    for(Map<String, Object> map : ckLvList) {
	        result.addAll(session.selectList("approval.ckLvList", map));
	    }
	    
	    return result;
	}

	@Override
	public List<Map<String, Object>> findName(SqlSession session, Integer depCode) {
		
		return session.selectList("approval.findName",depCode);
	}
	@Override
	public List<Map<String, Object>> selectEmployee(SqlSession session, int no) {
	
		return session.selectList("approval.selectEmployee", no);
	}
	//document, approval insert
	@Override
	@Transactional
	public int insertAprvDocu(SqlSession session, Map<String, Object> reqAll) {
	    
		
		try {
		
		int docu = session.insert("approval.insertDocu", reqAll);
		 
	    
		String[] testArrays  = (String[])reqAll.get("APRV_EMP");	
		String[] testArrays2 = (String[])reqAll.get("APRV_SQ");
		
		int [] aprvEmpArrays = new int[testArrays.length];
		for(int i=0;i<testArrays.length;i++) {
			aprvEmpArrays[i]=Integer.parseInt(testArrays[i]);
		}
		
		int [] aprvSQArrays=new int[testArrays2.length];
		for(int i=0;i<testArrays2.length;i++) {
			aprvSQArrays[i]=Integer.parseInt(testArrays2[i]);
	    }
		

		int count=1;
			for(int i=0;i<aprvEmpArrays.length;i++) { 
			  Map<String,Object> aprv = new HashMap<String,Object>();
			  if(i==0) { 
				aprv.put("APRV_SQ", 1);
			  	aprv.put("APRV_LV", count++);
			  	aprv.put("APRV_EMP",aprvEmpArrays[i]);
			  	
			  	session.insert("approval.fistAprv",aprv);
			  	
			  }else {
			  	aprv.put("APRV_SQ", 0);
			  	aprv.put("APRV_LV", count++);
			  	aprv.put("APRV_EMP", aprvEmpArrays[i]);
			  	
			  	session.insert("approval.insertAprv", aprv);
			  }
		  }
		  
		  for(int i=0;i<aprvSQArrays.length;i++) { 
			  Map<String,Object> aprv = new HashMap<String,Object>();
			  	aprv.put("APRV_SQ", 0);
			  	aprv.put("APRV_LV", 99);
			  	aprv.put("APRV_EMP", aprvSQArrays[i]);
			  	session.insert("approval.insertAprv", aprv);
		  }
		  return 1; 
		  
		}catch(Exception e) {
				e.printStackTrace();
		  return 0;
		}		
	}

	@Override
	public List<Map<String, Object>> selectAprvDocu(SqlSession session, int docNo) {
		
		return session.selectList("approval.selectAprvDocu",docNo);
	}

	
	
}
