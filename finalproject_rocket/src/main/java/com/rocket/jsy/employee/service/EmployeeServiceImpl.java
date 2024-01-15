package com.rocket.jsy.employee.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.rocket.jsy.employee.model.dao.EmployeeDao;
import com.rocket.jsy.employee.model.dto.Employee;
import com.rocket.ksj.chat.model.dao.LoginDao;
import com.rocket.security.DBConnectionProvider;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EmployeeServiceImpl implements EmployeeService{
	
	
	private final LoginDao loginDao;
	private final EmployeeDao dao;
	private final SqlSession session;
	private final DBConnectionProvider pdbprovider;
	@Override
	public List<Map<String, Object>> selectEmployeeAll() {
		return dao.selectEmployeeAll(session);
	}
	@Override
    public List<Map<String, Object>> selectBranch() {
        return dao.selectBranch(session);
    }
    
    @Override
    public List<Map<String, Object>> selectDepartment(){
        return dao.selectDepartment(session);
    }
    
    @Override
    public List<Map<String, Object>> selectDwrules() {
        return dao.selectDwrules(session);
    }

	@Override
	public List<Map<String, Object>> selectEmployeeHolidayAll() {
		return dao.selectEmployeeHolidayAll(session);
	}
	
	@Override
	public Map<String, Object> selectEmployeeByNo(int EmpNo) {
		return dao.selectEmployeeByNo(session, EmpNo);
	}
	
	
	@Override
    @Transactional
    public int updateEmployee(HashMap<String, Object> employee) {
        return dao.updateEmployee(session, employee);
    }
	
	@Override
	@Transactional
	public int insertEmployee(HashMap<String, Object> employee) {
	    return dao.insertEmployee(session, employee);
	}
	@Override
	@Transactional
	  public int updateEmpFile(String empFile, int empNo) {

		int result=dao.updateEmpFile(session, empFile, empNo);
		if(result>0) {
			Employee e=loginDao.selectEmployeeByLoginId(session,String.valueOf(empNo));
			
			SecurityContextHolder.getContext().setAuthentication(pdbprovider
						.authenticate(new UsernamePasswordAuthenticationToken(e,"updateData")
							));
		}
	    return result;
	  }
	
}