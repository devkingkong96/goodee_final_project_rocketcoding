package com.rocket.jsy.employee.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

public interface CommuteDao {
	List<Map<String,Object>>selectCommuteAll(SqlSession session);
    List<Map<String,Object>> selectEmployeeByCalendar(SqlSession session, String employeeName);
    Map<String,Object> selectcommuteByName(SqlSession session, String employeeName);
    List<Map<String,Object>>employeesearch(SqlSession session, String employeeName);
}
