package com.rocket.jsy.employee.model.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class CommuteDaoImpl implements CommuteDao{
	@Override
	public List<Map<String, Object>> selectCommuteAll(SqlSession session) {
		return session.selectList("commute.selectCommuteAll");
	}
}
