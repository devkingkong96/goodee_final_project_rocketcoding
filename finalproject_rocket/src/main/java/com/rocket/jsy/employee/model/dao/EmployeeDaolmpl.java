package com.rocket.jsy.employee.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

@Repository
public class EmployeeDaolmpl implements EmployeeDao{

	@Override
	public List<Map<String, Object>> selectEmployeeAll(SqlSession session) {
		return session.selectList("employee.selectEmployeeAll");
	}
	@Override
    public List<Map<String, Object>> selectBranch(SqlSession session) {
        return session.selectList("employee.selectBranch");
    }

    @Override
    public List<Map<String, Object>> selectDepartment(SqlSession session) {
        return session.selectList("department.selectDepartment");
    }

    @Override
    public List<Map<String, Object>> selectDwrules(SqlSession session) {
        return session.selectList("employee.selectDwrules");
    }
    
	@Override
	public List<Map<String, Object>> selectEmployeeHolidayAll(SqlSession session) {
		return session.selectList("employee.selectEmployeeHolidayAll");
	}

	@Override
	public Map<String, Object> selectEmployeeByNo(SqlSession session, int empNo) {
		return session.selectOne("employee.selectEmployeeByNo",empNo);
	}
	
	@Override
	public int updateEmployee(SqlSession session, HashMap<String, Object> employee) {
		return session.update("employee.updateEmployee",employee);
	}
	@Override
	public List<Map<String, Object>> selectEmployeeMyPageCalendar(SqlSession session) {
	    return session.selectList("employee.selectEmployeeMyPageCalendar");
	}
	@Override
	public int insertEmployee(SqlSession session, HashMap<String, Object> employee) {
	    return session.insert("employee.insertEmployee", employee);
	}
	@Override
    public int updateEmpFile(SqlSession session, String empFile, int empNo) {
        HashMap<String, Object> map = new HashMap<>();
        map.put("empFile", empFile);
        map.put("empNo", empNo);
        return session.update("employee.updateEmpFile", map);
    }
	
}
