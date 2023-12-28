package com.rocket.psh.board.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.rocket.psh.board.model.dto.Fboard;
import com.rocket.psh.board.model.service.FboardService;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
@RequestMapping("/board")
public class BoardController {
	
	private FboardService service;
	
	
	@GetMapping("/fboardlist.do")
	public void selectFboard(
			@RequestParam(defaultValue="1") int cPage,
			@RequestParam(defaultValue="10") int numPerpage,
			Model model) {
		
		model.addAttribute("boards",service.selectBoard(Map.of("cPage",cPage,"numPage",numPerpage)));
		
		int totalData=service.selectFboardCount();
		
		
		
		model.addAttribute("totalContents",totalData);
	}
	@RequestMapping("/fboardView.do")
	public void selelctBoardByNo(int fboardNo,Model model) {
		model.addAttribute("board",service.selectBoardByNo(fboardNo));
	}
	@RequestMapping("/fboardWrite.do")
	public void boardWrite() {}
	
	@RequestMapping("insertFboard.do")
	public String insertFboard(Fboard b,Model model) {
		String msg,loc;
		int result=service.insertFboard(b);
		
		if(result>0) {
			msg="등록이 완료되었습니다.";
			loc="board/fboardlist.do";
		}else {
			msg="등록이 실패하셨습니다";
			loc="board/fdoardWrite.do";
		}
		model.addAttribute("msg",msg);
		model.addAttribute("loc",loc);
		
		return "common/msg";
	}
}
