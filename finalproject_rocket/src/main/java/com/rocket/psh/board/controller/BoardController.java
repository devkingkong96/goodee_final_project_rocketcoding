package com.rocket.psh.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.rocket.psh.board.model.dto.Fboard;
import com.rocket.psh.board.model.service.FboardService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/board")
public class BoardController {
	
	
	  private final FboardService service;
	
	  // 게시물 목록 조회
	    @GetMapping("/fboardlist.do")
	    public ModelAndView fboardList(
	            @RequestParam(defaultValue = "1") int page,
	            @RequestParam(defaultValue = "title") String searchType,
	            @RequestParam(defaultValue = "") String keyword) {
	        
	        ModelAndView mv = new ModelAndView("board/fboardlist");
	        
	        // 페이징 처리를 위한 파라미터 설정
	        HashMap<String, Object> paramMap = new HashMap<>();
	        paramMap.put("page", page);
	        paramMap.put("searchType", searchType);
	        paramMap.put("keyword", keyword);

	        // 서비스에서 페이징 처리된 게시물 목록 데이터를 가져와서 모델에 추가
	        List<Map<String, Object>> list = service.selectFboardList(paramMap);
	        mv.addObject("list", list);

	        // 추가적인 모델 데이터 (예: 페이징 정보, 검색 정보 등)
//	        Map<String, Object> pageInfo = service.getFboardPageInfo(paramMap);
//	        mv.addObject("pageInfo", pageInfo);

	        // 검색 타입과 키워드 정보를 뷰에 전달
//	        mv.addObject("searchType", searchType);
//	        mv.addObject("keyword", keyword);

	        return mv;
	    }

	    // 게시글 상세 조회 (조회수 증가 포함)
	    @GetMapping("/fboarddetail")
	    public ModelAndView fboardDetail(@RequestParam("fboardNo") int fboardNo) {
	        ModelAndView mv = new ModelAndView("board/fboarddetail");

	        // 조회수 증가 처리 (중복 조회 방지 로직 포함)
	        int result=service.increaseViewCount(fboardNo);

	        // 게시글 상세 정보 조회
	        Map<String, Object> fboard = service.selectFboardDetail(fboardNo);
	        mv.addObject("fboard", fboard);

	        // 댓글 목록 조회 (댓글 기능이 있다면)
	        List<Map<String, Object>> comments = service.selectFboardComments(fboardNo);
	        mv.addObject("comments", comments);

	        return mv;
	    }
	
	    @GetMapping("/fboardWrite")
	    public String writepage() {
	    	return "board/fboardWrite";
	    }
	    
	    
	 // 게시글 작성 처리
	    @PostMapping("/fboardWrite")
	    public ModelAndView submitFboardWrite(Fboard fboardDTO, BindingResult result) {
	        ModelAndView mv = new ModelAndView();

	        // 입력 데이터 유효성 검사
	        if (result.hasErrors()) {
	            mv.setViewName("board/fboardwrite");
	            mv.addObject("fboard", fboardDTO);
	            mv.addObject("errors", result.getAllErrors());
	            return mv;
	        }

	        // 게시글 작성 로직 수행
	        try {
	            service.insertFboard(fboardDTO);
	            mv.setViewName("redirect:/board/fboardlist");
	        } catch (Exception e) {
	            mv.setViewName("board/fboardwrite");
	            mv.addObject("fboard", fboardDTO);
	            mv.addObject("errorMessage", "게시글 작성 중 오류가 발생했습니다.");
	        }

	        return mv;
	    }

	    // 게시글 수정 페이지 이동
	    @GetMapping("/fboardedit")
	    public ModelAndView fboardEdit(@RequestParam("fboardNo") int fboardNo) {
	        ModelAndView mv = new ModelAndView();

	        try {
	            Map<String, Object> fboard = service.selectFboardDetail(fboardNo);
	            
	            if (fboard == null || fboard.isEmpty()) {
	                mv.setViewName("redirect:/board/fboardlist");
	                mv.addObject("errorMessage", "해당 게시글이 존재하지 않습니다.");
	                return mv;
	            }

	            // 권한 검사 로직
	            // User user = (User) request.getSession().getAttribute("user");
	            // if (user == null || !user.canEdit(fboard)) {
	            //     mv.setViewName("redirect:/board/fboardlist");
	            //     mv.addObject("errorMessage", "수정 권한이 없습니다.");
	            //     return mv;
	            // }

	            mv.addObject("fboard", fboard);
	            mv.setViewName("board/fboardedit");
	        } catch (Exception e) {
	            mv.setViewName("redirect:/board/fboardlist");
	            mv.addObject("errorMessage", "게시글 조회 중 오류가 발생했습니다.");
	        }

	        return mv;
	    }

	    @PostMapping("/fboardupdate")
	    public ModelAndView fboardUpdate(@RequestParam Map fboard) {
	    	ModelAndView mv=new ModelAndView();
	    	int result=service.updateFboard(fboard);
	    	if(result>0) {
	    		mv.setViewName("redirect:/fboardlist");
	    	}else {
	    		mv.setViewName("redirect:/fboardedit?fboardNo="+fboard.get("fboardNo"));
	    	}
	    	
	    	return mv;
	    }
	    
	    // 게시글 삭제 처리
	    @PostMapping("/fboarddelete")
	    public ModelAndView fboardDelete(@RequestParam("fboardNo") int fboardNo) {
	        ModelAndView mv = new ModelAndView();

	        try {
	            // 권한 검사 로직
	            // User user = (User) request.getSession().getAttribute("user");
	            // if (user == null || !user.canDelete(fboardNo)) {
	            //     mv.setViewName("redirect:/board/fboardlist");
	            //     mv.addObject("errorMessage", "삭제 권한이 없습니다.");
	            //     return mv;
	            // }

	            service.deleteFboard(fboardNo);
	            mv.setViewName("redirect:/board/fboardlist");
	        } catch (Exception e) {
	            mv.setViewName("redirect:/board/fboardlist");
	            mv.addObject("errorMessage", "게시글 삭제 중 오류가 발생했습니다.");
	        }

	        return mv;
	    }
}