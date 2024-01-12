package com.rocket.pdw.aprv.model.dao;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

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

	@Override
	@Transactional
	public int updateAprv(SqlSession session, Map<String, Object> reqAll) {
	    log.info("===========updateAprv reqAll{}", reqAll);

	    String str = (String)reqAll.get("DOC_NO");
	    int docNo = Integer.valueOf(str);
	    List<Map<String, Object>> aprvDocu = selectAprvDocu(session, docNo);
	    int aprvCount = aprvDocu.stream()
	                            .filter(map -> !map.get("APRV_LV").equals(BigDecimal.valueOf(99)))
	                            .toList()
	                            .size();
	    List<Map<String, Object>> lastAprv = aprvDocu.stream()
	                                                  .filter(map -> map.get("APRV_LV").equals(BigDecimal.valueOf(aprvCount)))
	                                                  .toList();
	    log.info("{마지막결재자입니다} : " + lastAprv);

	    BigDecimal empNoBigDecimal = new BigDecimal((String)reqAll.get("EMP_NO"));
	    if(empNoBigDecimal.equals(lastAprv.get(0).get("APRV_EMP"))) {
	        int updateCount1 = session.update("approval.updateAprv", reqAll);
	        int updateCount2 = session.update("approval.updatedocu", reqAll);
	        if (updateCount1 > 0 && updateCount2 > 0) {
	            // 두 업데이트가 모두 성공적으로 수행되었다면 1을 반환
	            return 1;
	        } else {
	            // 하나라도 실패했다면, 실패한 업데이트의 반환 값을 반환
	            return Math.min(updateCount1, updateCount2);
	        }
	    } else {
	        // 마지막 결재자가 아닐 경우, updateAprv만 수행하고 결과 반환
	        return session.update("approval.updateAprv", reqAll);
	    }
	}


	@Override
	@Transactional
	public int rejectAprv(SqlSession session, Map<String, Object> reqAll) {
		int updateCount1 = session.update("approval.rejectAprv", reqAll);
        int updateCount2 = session.update("approval.rejectDocu", reqAll);
        if (updateCount1 > 0 && updateCount2 > 0) {
            // 두 업데이트가 모두 성공적으로 수행되었다면 1을 반환
            return 1;
        } else {
            // 하나라도 실패했다면, 실패한 업데이트의 반환 값을 반환
            return Math.min(updateCount1, updateCount2);
            
        }
	}

	
	
}
