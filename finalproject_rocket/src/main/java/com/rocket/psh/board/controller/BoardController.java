package com.rocket.psh.board.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.rocket.jsy.employee.model.dto.Employee;
import com.rocket.psh.board.model.dto.Fboard;
import com.rocket.psh.board.model.dto.FboardFile;
import com.rocket.psh.board.model.service.FboardCommentService;
import com.rocket.psh.board.model.service.FboardService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/board")
@Slf4j
public class BoardController {
	
	
	  private final FboardService service;
	  private final FboardCommentService commService;
		
	
	
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
	    
	    @GetMapping("/fboardView/{fboardNo}")
	    public ModelAndView fboardDetail(@PathVariable int fboardNo) {
	    	log.info("보드 번호{}",fboardNo);
	    	
	        ModelAndView mv = new ModelAndView("board/fboardView");

	        

	        // 게시글 상세 정보 조회
	        Fboard fboard = service.selectFboardDetail(fboardNo);
	        mv.addObject("fboard", fboard);
	        log.info("보드 정보{}",fboard);

	        // 댓글 목록 조회 (댓글 기능이 있다면)
	        List<Map<String, Object>> comments = service.selectFboardComments(fboardNo);
	        mv.addObject("comments", comments);
	        log.info("댓글 정보{}",comments);

	        return mv;
	    }
	
	    @GetMapping("/fboardWrite")//board/fboardWrite
	    public String writepage() {
	    	return "board/fboardWrite";
	    }
	    
	    
	 // 게시글 작성 처리
	    @PostMapping("/fboardWrite")
	    public ModelAndView submitFboardWrite(MultipartFile upfile,Fboard fboardDTO, BindingResult result,HttpSession session) {
	        ModelAndView mv = new ModelAndView();
	        Employee em = (Employee) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	        int empNo=em.getEmpNo();
	        fboardDTO.setEmpNo(empNo);
	        
	        
	        // 입력 데이터 유효성 검사
	        if (result.hasErrors()) {
	            mv.setViewName("board/fboardwrite");
	            mv.addObject("fboard", fboardDTO);
	            mv.addObject("errors", result.getAllErrors());
	            return mv;
	        }

	        String path = session
	        		.getServletContext()
	        		.getRealPath("/resources/upload/fboard");
	        
	        String oriName="";
	        String reName="";
	        //serialize 값 가져오기
	        log.info("파일 업로드 정보 가져오기 upFile{}");
	        log.info("파일 업로드 정보 가져오기 upFile{}",upfile);
	        
	        File file1 = new File(path);
	        if(!file1.exists()) {
	        	file1.mkdirs();
	        }
	        
	        if (!upfile.isEmpty()) {
	        	oriName = upfile.getOriginalFilename();
	        	String ext = oriName.substring(oriName.lastIndexOf("."));
	        	Date today = new Date(System.currentTimeMillis());
	        	int randomNum = (int)(Math.random() * 10000) + 1;
	        	reName = "Rocket_ChatMessage_File_" + (new SimpleDateFormat("yyyyMMddHHmmssSSS").format(
	        			today)) + "_" + randomNum + ext;
	        	try {
	        		upfile.transferTo(new File(path, reName));
	        		fboardDTO.setFiles(List.of(FboardFile.builder().fboardFileOri(oriName).fboardFileRe(reName).build()));
	        	} catch (IOException | DataAccessException e) {
	        		e.printStackTrace();
	        	}
	        }
	        
	        // 게시글 작성 로직 수행
	        try {
	            service.insertFboard(fboardDTO);
	            mv.setViewName("redirect:/board/fboardlist.do");
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
	            Fboard fboard = service.selectFboardDetail(fboardNo);
	            if (fboard == null) {
	                mv.setViewName("redirect:/board/fboardlist");
	                mv.addObject("errorMessage", "해당 게시글이 존재하지 않습니다.");
	                return mv;
	            }
	            // TODO: 권한 검사 로직 구현
	            mv.addObject("fboard", fboard);
	            mv.setViewName("board/fboardedit");
	        } catch (Exception e) {
	            mv.setViewName("redirect:/board/fboardlist");
	            mv.addObject("errorMessage", "게시글 조회 중 오류가 발생했습니다.");
	        }
	        return mv;
	    }

	    // 게시글 수정 처리
	    @PostMapping("/fboardupdate")
	    public ModelAndView fboardUpdate(@RequestParam Map<String, Object> fboard) {
	        ModelAndView mv = new ModelAndView();
	        int result = service.updateFboard(fboard);
	        if (result > 0) {
	            mv.setViewName("redirect:/board/fboardlist");
	        } else {
	            mv.setViewName("redirect:/board/fboardedit?fboardNo=" + fboard.get("fboardNo"));
	        }
	        return mv;
	    }

	    // 게시글 삭제 처리
	    @PostMapping("/fboarddelete")
	    public ModelAndView fboardDelete(@RequestParam("fboardNo") int fboardNo) {
	        ModelAndView mv = new ModelAndView();
	        try {
	            // TODO: 권한 검사 로직 구현
	            service.deleteFboard(fboardNo);
	            mv.setViewName("redirect:/board/fboardlist.do");
	        } catch (Exception e) {
	            mv.setViewName("redirect:/board/fboardlist.do");
	            mv.addObject("errorMessage", "게시글 삭제 중 오류가 발생했습니다.");
	        }
	        return mv;
	    }
	   
	    //댓글  
	    @PostMapping("/comment/insertComment.do")
	    public ModelAndView insertComment(@RequestParam("fboardNo") int fboardNo, 
	                                      @RequestParam("regr_id") String regr_id, 
	                                      @RequestParam("content") String content) {
	        ModelAndView mav = new ModelAndView();

	        try {
	            Map<String, Object> param = new HashMap<>();
	            param.put("fboardNo", fboardNo);
	            param.put("empNo", regr_id);
	            param.put("fbdComment", content);

	            try {
	                fboardNo = commService.insertComment(param);
	                mav.addObject("message", "댓글이 성공적으로 추가되었습니다.");
	            } catch (Exception e) {
	                mav.addObject("message", "댓글 추가 중 오류가 발생하였습니다.");
	                e.printStackTrace();
	            }
	        } catch (Exception e) {
	            mav.addObject("message", "댓글 추가 중 오류가 발생하였습니다.");
	            log.error("댓글 추가 중 오류 발생", e);
	        }

	        mav.setViewName("redirect:/board/fboardView");
	        return mav;
	    }

	    
}