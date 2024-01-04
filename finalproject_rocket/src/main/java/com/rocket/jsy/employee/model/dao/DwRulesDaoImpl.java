package com.rocket.jsy.employee.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class DwRulesDaoImpl implements DwRulesDao{
	@Override
	public List<Map<String,Object>> selectDwRulesAll(SqlSession session){
		return session.selectList("dwrules.selectDwRulesAll");
	}
}
