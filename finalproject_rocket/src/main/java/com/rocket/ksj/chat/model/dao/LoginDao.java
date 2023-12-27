package com.rocket.ksj.chat.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.rocket.jsy.employee.model.dto.Employee;

@Repository
public class LoginDao {
	
	public List<Employee>selectEmployeeAll(SqlSession session){
		return session.selectList("employee.selectEmployeeAll");
	}
	
	public Employee selectEmployeeById(SqlSession session,String empNo) {
		return session.selectOne("employee.selectEmployeeByNo",empNo);
	}
	
	public Employee selectEmployeeByEmail(SqlSession session,String email) {
		return session.selectOne("employee.selectEmployeeByEmail",email);
	}
}
