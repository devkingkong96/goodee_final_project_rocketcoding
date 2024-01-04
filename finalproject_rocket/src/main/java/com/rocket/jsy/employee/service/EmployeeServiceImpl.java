package com.rocket.jsy.employee.service;

<<<<<<< HEAD
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.rocket.jsy.employee.model.dao.EmployeeDao;
import com.rocket.jsy.employee.model.dto.Employee;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EmployeeServiceImpl implements EmployeeService{
	
	private final EmployeeDao dao;
	private final SqlSession session;
	
	@Override
	public List<Map<String, Object>> selectEmployeeAll() {
		return dao.selectEmployeeAll(session);
	}
	
	@Override
	public List<Map<String, Object>> selectEmployeeHolidayAll() {
		return dao.selectEmployeeHolidayAll(session);
	}
	
	@Override
	public Map<String, Object> selectEmployeeByNo(int EmpNo) {
		return dao.selectEmployeeByNo(session, EmpNo);
	}
//	@Override
//	public int insertEmployee(Employee employee, int dwrulesCode) {
//	    Map<String, Object> params = new HashMap<>();
//	    params.put("employee", employee);
//	    params.put("dwrulesCode", dwrulesCode);
//	    return dao.insertEmployee(session, params);
//	}
//	@Override
//    @Transactional
//    public int updateEmployee(Employee e, Date comEnroll) {
//        int result = EmployeeDao.updateEmployee(session, e,comEnroll);
//        
//        CommuteDao.updateCommute(session, e.getEmpNo(), comEnroll);
//        
//        return result;
//    }
	@Override
	public int insertEmployee(Employee employee) {
	    return dao.insertEmployee(session, employee);
	}
	@Override
    public List<Map<String, Object>> selectEmployeeMyPageCalendar() {
        return dao.selectEmployeeMyPageCalendar(session);
    }
		
}
=======
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.rocket.jsy.employee.model.dao.EmployeeDao;
import com.rocket.jsy.employee.model.dto.Employee;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EmployeeServiceImpl implements EmployeeService{
	
	private final EmployeeDao dao;
	private final SqlSession session;
	
	@Override
	public List<Employee> selectEmployeeAll() {
		return dao.selectEmployeeAll(session);
	}
	
	@Override
	public List<Employee> selectEmployeeHolidayAll() {
		return dao.selectEmployeeHolidayAll(session);
	}
	
	@Override
	public Employee selectEmployeeByNo(String EmpNo) {
		return dao.selectEmployeeByNo(session, EmpNo);
	}
	@Override
	public int insertEmployee(Employee e) {
		return dao.insertEmployee(session, e);
	}
	@Override
	public int updateEmployee(Employee e) {
		return dao.updateEmployee(session, e);
	}
	@Override
    public List<Map<String, Object>> selectEmployeeMyPageCalendar() {
        return dao.selectEmployeeMyPageCalendar(session);
    }
	

	
}
>>>>>>> branch 'dev' of https://github.com/devkingkong96/final_project_rocketcoding.git
