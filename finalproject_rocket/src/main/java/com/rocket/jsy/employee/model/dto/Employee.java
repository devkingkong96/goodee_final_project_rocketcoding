package com.rocket.jsy.employee.model.dto;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Employee implements UserDetails{
	private String empNo;
	private String empPw;
	private String empName;
	private String empLv;
	private Date empEndate;
	private String empStatus;
	private String empFication; //재직/퇴직 여부
	private int branchId;//지점고유번호
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
		return this.empNo;
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
