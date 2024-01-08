package com.rocket.jsy.employee.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.rocket.jsy.employee.model.dto.DwRules;

public interface DwRulesDao {

	List<Map<String, Object>> selectDwRulesAll(SqlSession session);
	void insertDwRules(SqlSession session, DwRules dwRules);
	void deleteDwRule(SqlSession session, String comNo);
}
