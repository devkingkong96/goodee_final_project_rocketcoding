package com.rocket.common;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

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
@Controller
public class ErrorHandler implements ErrorController{
	
	@GetMapping("/error")
	public String handleError(HttpServletRequest request) {
		// 403,404,500...값 가져오기
		Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
		
//		if(ObjectUtils.isEmpty(status)) {
		if(status!=null) {
			int statusCode = Integer.valueOf(status.toString());
			
			if(statusCode == HttpStatus.NOT_FOUND.value()) {
				return "errors/404";
			} else if(statusCode == HttpStatus.INTERNAL_SERVER_ERROR.value()) {
				return "errors/500";
			}
		}
		return "errors/404";
	}
}