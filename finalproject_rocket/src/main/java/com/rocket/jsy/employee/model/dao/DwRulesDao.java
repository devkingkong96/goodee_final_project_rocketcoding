package com.rocket.jsy.employee.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

public interface DwRulesDao {

	List<Map<String, Object>> selectDwRulesAll(SqlSession session);

}
