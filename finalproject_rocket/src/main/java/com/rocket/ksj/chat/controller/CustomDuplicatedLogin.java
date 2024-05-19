//package com.rocket.ksj.chat.controller;
//
//import java.io.IOException;
//
//import org.springframework.security.authentication.BadCredentialsException;
//import org.springframework.security.web.session.SessionInformationExpiredEvent;
//import org.springframework.security.web.session.SessionInformationExpiredStrategy;
//import org.springframework.stereotype.Component;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.ControllerAdvice;
//import org.springframework.web.bind.annotation.ExceptionHandler;
//
//import jakarta.servlet.ServletException;
//
//@ControllerAdvice
//public class CustomDuplicatedLogin{
//
//	@ExceptionHandler(BadCredentialsException.class)
//	public String handleBadCredentialsException(BadCredentialsException ex,Model model) {
//		model.addAttribute("errorMessage", "아이디 또는 비밀번호가 맞지 않습니다. 다시 확인해주세요.");
//		return "loginpage";
//	}
//}
