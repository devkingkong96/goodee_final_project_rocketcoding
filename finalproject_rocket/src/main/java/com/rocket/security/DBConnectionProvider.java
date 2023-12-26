package com.rocket.security;

import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import com.rocket.jsy.employee.model.dto.Employee;
import com.rocket.ksj.member.model.service.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@RequiredArgsConstructor
public class DBConnectionProvider implements AuthenticationProvider,UserDetailsService{
	
	private final MemberService service;
	private final BCryptPasswordEncoder encoder=new BCryptPasswordEncoder();
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		String empNo=authentication.getName();
		String pw=(String)authentication.getCredentials();
		
		//empNo와 일치하는 직원 정보 DB에서 가져오기
		Employee loginEMP=service.selectEmployeeById(empNo);
		
		//회원이 없으면 예외처리
		if(loginEMP==null)
			throw new UsernameNotFoundException("유효한 직원 아이디가 없습니다.");
				
		//비밀번호 체크
		if(!encoder.matches(pw, loginEMP.getEmpPw()))
			throw new BadCredentialsException("비밀번호가 틀렸습니다.");
		
		return new UsernamePasswordAuthenticationToken(loginEMP, loginEMP.getPassword(),loginEMP.getAuthorities());
	}
	@Override
	public boolean supports(Class<?> authentication) {
		return UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication);
	}
	 @Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		Employee loginEMP=service.selectEmployeeById(username);
		return loginEMP;
	}
	
}
