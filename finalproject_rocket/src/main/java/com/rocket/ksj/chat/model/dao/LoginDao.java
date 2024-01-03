package com.rocket.ksj.chat.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.rocket.jsy.employee.model.dto.Employee;
import com.rocket.pdw.aprv.model.dto.Approval;
import com.rocket.psh.board.model.dto.Fboard;
import com.rocket.psh.board.model.dto.Notice;

@Repository
public class LoginDao {
	
	public List<Employee>selectEmployeeAll(SqlSession session){
		return session.selectList("employee.selectEmployeeAll");
	}
	
	public Employee selectEmployeeByLoginId(SqlSession session,String empNo) {
		return session.selectOne("employee.selectEmployeeByLoginId",empNo);
	}
	//임시 비밀번호 메일 전송 메소드 - Id로 멤버 확인
	public int selectEmployeeByIdTmp(SqlSession session,String empNo) {
		return session.selectOne("employee.selectEmployeeByNoTmp",empNo);
	}
	//임시 비밀번호 메일 전송 메소드 - Email로 멤버 확인
	public int selectEmployeeByNoEmailTmp(SqlSession session,Map<String, String> map) {
		return session.selectOne("employee.selectEmployeeByNoEmailTmp",map);
	}
	//임시 비밀번호 메일 전송 메소드 - 임시 비밀번호 저장
	public int updateEmployeeTempPwd(SqlSession session,Map<String, String> emp) {
		return session.update("employee.updateEmployeeTempPwd",emp);
	}
	
	//메인화면 메소드
	public List<Map<String, String>> selectAprvMainPage(SqlSession session){
		return session.selectList("approval.selectAprvMainPage");
	}
	
	public List<Map<String, String>> selectFboardMainPage(SqlSession session){
		return session.selectList("fboard.selectFboardMainPage");
	}
	
	public List<Map<String, String>> selectNoticeMainPage(SqlSession session){
		return session.selectList("notice.selectNoticeMainPage");
	}
}
