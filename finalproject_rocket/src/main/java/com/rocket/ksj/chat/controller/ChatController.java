package com.rocket.ksj.chat.controller;

import static com.rocket.common.Getrequest.getParameterMap;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.dao.DataAccessException;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.rocket.jsy.employee.model.dto.Employee;
import com.rocket.ksj.chat.model.service.ChatService;
import com.rocket.seoj.logistics.model.dto.InventoryAttach;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/chat")
public class ChatController {

	private final ChatService service;
	
	
	@GetMapping("/list")
	public String chatlist(Model m,HttpSession session) {
		Employee emp=(Employee)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		//로그인한 회원 번호
		int empNo=emp.getEmpNo();
		//로그인한 회원 제외한 직원 리스트 가져오기
		List<Map<String, Object>>emplist=service.selectEmployeeAll(empNo);
		//로그인한 직원 채팅방 가져오기
		List<Map<String, Object>>chatlist=service.selectChatAll(empNo);
		//모든 대화방 가져오기
//		List<Map<String, Object>>chatroomlist=service.selectRoomAll();
		
		m.addAttribute("emplist",emplist);
		m.addAttribute("chatlist",chatlist);
		m.addAttribute("logempNo",empNo);
//		m.addAttribute("chatroomlist",chatroomlist);
		
		return "chat/chatlist";
	}
	
	@PostMapping(value="/file/upload")
	@ResponseBody
	public Map chatFileUpload(MultipartFile file,HttpSession session) {
		
		//파일 경로
		String path = session
				.getServletContext()
				.getRealPath("/resources/upload/chatfile");
		
		String oriName="";
		String reName="";
		//serialize 값 가져오기
		log.info("파일 업로드 정보 가져오기 upFile{}");
		log.info("파일 업로드 정보 가져오기 upFile{}",file);
		
			File file1 = new File(path);
	        if(!file1.exists()) {
	            file1.mkdirs();
	        }
		
               if (!file.isEmpty()) {
                    oriName = file.getOriginalFilename();
                   String ext = oriName.substring(oriName.lastIndexOf("."));
                   Date today = new Date(System.currentTimeMillis());
                   int randomNum = (int)(Math.random() * 10000) + 1;
                    reName = "Rocket_ChatMessage_File_" + (new SimpleDateFormat("yyyyMMddHHmmssSSS").format(
                           today)) + "_" + randomNum + ext;
                   try {
                	   file.transferTo(new File(path, reName));

                    } catch (IOException | DataAccessException e) {
                        e.printStackTrace();
                    }
                }
            	   
               return Map.of("msgFiOriName", oriName,"msgFiReName",reName);
           
               

	}
	
}
