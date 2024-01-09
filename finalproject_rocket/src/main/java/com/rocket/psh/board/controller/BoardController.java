package com.rocket.psh.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.rocket.psh.board.model.service.FboardService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequiredArgsConstructor
/* @Log4j */	
@RequestMapping("/board")
public class BoardController {
	/* Logger log = LoggerFactory.getLogger(this.getClass()); */

	private final FboardService service;
	
	// 게시물 등록 할때 쓰는거
//	@RequestMapping(value = "/fboardlist", method = RequestMethod.POST)
//	public ModelAndView FboardList(HttpServletRequest request) {
//		HashMap<String, Object>param=getParameterMap(request);
//		
//	}

	@RequestMapping(value="/fboardlist", method = RequestMethod.POST)
	public ModelAndView FboardList(HttpServletRequest request) {
		HashMap<String, Object>param=getParameterMap(request);
		return null;
		
    }

	private HashMap<String, Object> getParameterMap(HttpServletRequest request) {
		// TODO Auto-generated method stub
		return null;
	}

}