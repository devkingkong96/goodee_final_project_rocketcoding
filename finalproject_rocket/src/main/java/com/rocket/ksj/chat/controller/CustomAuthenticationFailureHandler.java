package com.rocket.ksj.chat.controller;

import java.io.IOException;
import java.net.URLEncoder;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		String errorMessage;
		if(exception instanceof BadCredentialsException) {
			errorMessage = "아이디 또는 비밀번호가 맞지 않습니다.";
		}else {
			errorMessage = "알 수 없는 오류로 로그인 실패.관리자에게 문의하세요.";
		}
		
		request.setAttribute("errorMessage", errorMessage);
		request.getRequestDispatcher("/WEB-INF/views/loginpage.jsp").forward(request, response);
	}
	
	
}
