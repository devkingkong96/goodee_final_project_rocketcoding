package com.rocket.jsy.employee.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

public interface CommuteDao {
	List<Map<String,Object>>selectCommuteAll(SqlSession session);
}
