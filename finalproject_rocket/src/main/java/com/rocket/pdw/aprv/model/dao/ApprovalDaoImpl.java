package com.rocket.pdw.aprv.model.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

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
	
	
}
