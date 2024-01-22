//package com.rocket.common;
//
//import org.springframework.security.core.context.SecurityContextHolder;
//import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
//import org.springframework.web.bind.annotation.ControllerAdvice;
//import org.springframework.web.bind.annotation.ExceptionHandler;
//
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import lombok.extern.slf4j.Slf4j;
//
//@ControllerAdvice
//@Slf4j
//public class ExceptionController {
//	
//	@ExceptionHandler(Exception.class)
//	public String handleAllException(final Exception ex,HttpServletRequest request,HttpServletResponse response){
//		log.error("error : " +ex);
////		SecurityContextHolder.getContext().setAuthentication(null);
//		SecurityContextHolder.clearContext();
//		SecurityContextLogoutHandler logouthandler=new SecurityContextLogoutHandler();
//		logouthandler.logout(request, response, null);
//		return "loginpage";
//	}
//}
