package com.rocket.ksj.chat.model.service;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.rocket.ksj.chat.model.dao.LoginDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class LoginService {
	
	private final LoginDao dao;
	private final SqlSession session;
	
	
	public String getTempPassword() {
		String tempPw=UUID.randomUUID().toString().replace("-", ""); // - 제거
		tempPw=tempPw.substring(0,10); //pw 10자리까지 자르기
		return tempPw;
	}
}
