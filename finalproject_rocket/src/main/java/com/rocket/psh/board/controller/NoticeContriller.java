package com.rocket.psh.board.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.rocket.jsy.employee.model.dto.Employee;
import com.rocket.psh.board.model.dto.Notice;
import com.rocket.psh.board.model.service.NoticeService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/notice")
@RequiredArgsConstructor
//@Slf4j
public class NoticeContriller {
	
	private final NoticeService service;
	private Map<String, Object> param;
	  
	@GetMapping("/notice.do")
	public ModelAndView showNoticeMainPage(@RequestParam(defaultValue="1") int cPage,
		@RequestParam(defaultValue="10") int numPerpage) {
		Map param=new HashMap();
		param.put("cPage", cPage);
		param.put("numPerpage",numPerpage);
		ModelAndView mv = new ModelAndView("board/notice");
		List<Map<String, Object>> noticeList = service.selectNoticeMainPage(param);
		mv.addObject("noticeList", noticeList);
		return mv;
	}

	// 공지사항 상세 정보를 조회하는 핸들러 메소드
    @GetMapping("/detail.do")
    public ModelAndView showNoticeDetail(@RequestParam int noticeNo) {
        ModelAndView mv = new ModelAndView("board/noticeDetail");
        // 조회수 증가
        service.increaseViewCount(noticeNo);
        // 공지사항 상세 정보 조회 후 모델에 추가
        mv.addObject("notice", service.selectNoticeDetail(noticeNo));
        // ModelAndView 반환
        return mv;
    }

    // 공지사항 작성 페이지를 보여주는 핸들러 메소드
    @GetMapping("/write.do")
    public String showNoticeWritePage() {
        return "board/noticeWrite";
    }
    
    // 공지사항을 작성하는 핸들러 메소드
    @PostMapping("/writerend")
    public ModelAndView writeNotice(@RequestParam MultipartFile upfile, Notice notice, 
    		HttpSession session) {
        ModelAndView mv = new ModelAndView();
        
        
        Employee em = (Employee) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        notice.setEmpNo(em.getEmpNo());
        
        // 파일 업로드 처리
        String path = session.getServletContext().getRealPath("/resources/upload/notice");
        File dir = new File(path);
        // 디렉토리가 없으면 생성
        if (!dir.exists()) {
            dir.mkdirs();
        }
        // 파일이 있는 경우에만 업로드 처리
        if (!upfile.isEmpty()) {
            String originalFilename = upfile.getOriginalFilename();
            String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
            int randomNum = (int)(Math.random() * 10000) + 1;
            // 새 파일 이름 생성
            String renamedFilename = "Notice_" + sdf.format(new Date(randomNum)) + "_" + randomNum + extension;
            try {
                // 파일 저장
                upfile.transferTo(new File(path, renamedFilename));
                // 파일 이름을 notice 객체에 설정
                notice.setNoticeContent(renamedFilename);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        // 게시글 작성
        int result = service.insertNotice(notice);
        // 결과가 0보다 크면 작성 성공, 상세 페이지로 리다이렉트
        mv.setViewName("redirect:/notice/notice.do");
        // ModelAndView 반환
        return mv;
    }

    // 공지사항을 수정하는 핸들러 메소드
    @PostMapping("/update.do")
    public ModelAndView updateNotice(Notice notice) {
        ModelAndView mv = new ModelAndView();
        // 공지사항 수정 후 결과를 받아옴
        int result = service.updateNotice(notice);
        // 결과가 0보다 크면 수정 성공, 상세 페이지로 리다이렉트
        if (result > 0) {
            mv.setViewName("redirect:/notice/detail.do?noticeNo=" + notice.getNoticeNo());
        } else {
            // 결과가 0이하면 수정 실패, 에러 페이지로 이동
            mv.setViewName("board/error");
        }
        // ModelAndView 반환
        return mv;
    }

    // 공지사항을 삭제하는 핸들러 메소드
    @PostMapping("/delete.do")
    public ModelAndView deleteNotice(@RequestParam int noticeNo) {
        ModelAndView mv = new ModelAndView();
        // 공지사항 삭제 후 결과를 받아옴
        int result = service.deleteNotice(noticeNo);
        // 결과가 0보다 크면 삭제 성공, 메인 페이지로 리다이렉트
        mv.setViewName("redirect:/notice/notice.do");
        // ModelAndView 반환
        return mv;
    }
    
}
