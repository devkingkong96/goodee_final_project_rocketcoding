package com.rocket.pdw.aprv.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AprvController {
	
	@RequestMapping("/aprvlist")
	public String index() {
		return "aprv/aprvlist";
	}
	
}
