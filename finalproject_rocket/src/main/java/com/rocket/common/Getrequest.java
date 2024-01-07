package com.rocket.common;

import java.util.Enumeration;
import java.util.HashMap;

import org.springframework.stereotype.Component;

import jakarta.servlet.http.HttpServletRequest;

@Component
public class Getrequest {
	
	public static HashMap<String, Object> getParameterMap(HttpServletRequest request){

		   HashMap<String, Object> parameterMap = new HashMap<String, Object>();
		   Enumeration<String> enums = request.getParameterNames();
		   
		   while(enums.hasMoreElements()){
		      String paramName = (String)enums.nextElement();
		      String[] parameters = request.getParameterValues(paramName);
		      
		      if(parameters.length > 1){
		            parameterMap.put(paramName, parameters);
		         }else{
		            parameterMap.put(paramName, parameters[0]);
		         }
		   }
		   return parameterMap;
		}
}
