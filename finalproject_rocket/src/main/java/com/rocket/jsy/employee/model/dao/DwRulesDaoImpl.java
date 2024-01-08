package com.rocket.jsy.employee.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.rocket.jsy.employee.model.dto.DwRules;

@Repository
public class DwRulesDaoImpl implements DwRulesDao{
	@Override
	public List<Map<String,Object>> selectDwRulesAll(SqlSession session){
		return session.selectList("dwrules.selectDwRulesAll");
	}
	@Override
	public void insertDwRules(SqlSession session, DwRules dwRules) {
		session.insert("dwrules.insertDwRules", dwRules);
	}
	@Override
	public void deleteDwRule(SqlSession session, String comNo) {
	    session.delete("dwrules.deleteDwRule", comNo);
	}
}
