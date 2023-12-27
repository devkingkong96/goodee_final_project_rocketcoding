package com.rocket.jsy.employee.model.dto;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.rocket.pdw.aprv.model.dto.Approval;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.rocket.ksj.chat.model.dto.EmpChat;
import com.rocket.pdw.aprv.model.dto.Document;
import com.rocket.psh.board.model.dto.Fboard;
import com.rocket.psh.board.model.dto.FboardComment;
import com.rocket.psh.board.model.dto.Notice;
import com.rocket.seoj.logistics.model.dto.Branch;
import com.rocket.seoj.logistics.model.dto.Inventory;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Employee implements UserDetails{
	private int empNo;
	private String empPw;
	private String empName;
	private String empLv;
	private Date empEndate;
	private String empStatus;
	private String empFication;
	private String empEmail;
	

	private Branch branchId;//지점고유번호

	private List<Commute> commuteList; //출.퇴근
	private List<Notice> noticeList; //공지사항
	private List<DwRules> dwrulesList; //일일근무규칙 설정
	private List<Fboard> fboardList; //자유게시판
	private List<FboardComment> fboardCommentList; //자유게시판 댓글
	private List<Document> documentList; //결재문서
	private List<Approval> approvalList; //결재자
	private List<Inventory> inventoryList; //입.출고
	private List<EmpChat> empChatList; //채팅참여




/*	private List<Commute> commuteList; //출.퇴근
	private List<DwRules> dwrulesList; //일일근무규칙 설정
	private List<EmpFile> empfileList; //사원정보 첨부파일


	private List<Inventory> inventoryList; //입.출고

	private List<Notice> noticeList; //공지사항
	private List<Fboard> fboardList; //자유게시판
	private List<FboardComment> fboardcommentList; //자유게시판 댓글

	private List<Document> documentList; //결재문서
	private List<EmpChat> empchatList; //채팅참여*/

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		List<GrantedAuthority> auth=new ArrayList<>();
		//기본 직원 권한 등록
		auth.add(new SimpleGrantedAuthority("USER"));
		
		//관리자 권한 부여(임시)
//		if(empLv.equals("admin")) {
//			auth.add(new SimpleGrantedAuthority("ADMIN"));
//		}
		
		return auth;
	}
	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return this.empPw;
	}
	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return String.valueOf(empNo);
	}
	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}
	
	
}
