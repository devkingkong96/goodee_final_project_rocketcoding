package com.rocket.ksj.chat.controller;

import java.util.Date;
import java.util.HashMap;
import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;

import org.springframework.dao.DataAccessException;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.multipart.MultipartFile;

import com.rocket.ksj.chat.model.dto.ChatMessage;
import com.rocket.ksj.chat.model.service.ChatMessageService;
import com.rocket.seoj.logistics.model.dto.InventoryAttach;
import static com.rocket.common.Getrequest.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class StompChatController {

	private final SimpMessagingTemplate template;
	private final ChatMessageService msgService;
	
	//채팅방 입장
	@MessageMapping("/chat/enter")
	public void enterMessage(ChatMessage message,SimpMessageHeaderAccessor headerAccessor) {
		log.info("{}님의 채팅방 입장 성공",message.getMsgEmpName());
		
		int roomNo=message.getMsgRoomNo();
		
		log.info("{}번 채팅방 입장 성공",roomNo);
		//socket session에 직원 정보,방 번호 저장
//		headerAccessor.getSessionAttributes().put("roomNo", headerAccessor);
		
		template.convertAndSend("/sub/chat/room/"+message.getMsgRoomNo(),message);
	}
	
	//채팅 메시지 전송
	@MessageMapping("/chat/send")
	public void sendMessage(ChatMessage message) {
		log.info("채팅메시지 발송 {}",message);
		
		// LocallDateTime 객체 생성(현재 시간)
		LocalDateTime now=LocalDateTime.now();
		// LocalDateTime -> Date 변환
		Date date=Timestamp.valueOf(now);
		
		message.setSendAt(date);
		
		//채팅 메시지 저장
		int result=msgService.insertMessage(message);
		if(result>0) {
			log.info("성공");
			template.convertAndSend("/sub/chat/room/"+message.getMsgRoomNo(),message);
		}else {
			log.info("실패");
		}
		
		
	}
	
	//채팅 파일 업로드 메시지
	@MessageMapping("/chat/filesend")
	public void filesendMessage(HttpServletRequest request,HttpSession session) {
		try {
			MultipartFile upFile=(MultipartFile)request.getPart("file");
		} catch (IOException | ServletException e) {
			e.printStackTrace();
		}
		//파일 경로
		String path = session
				.getServletContext()
				.getRealPath("/resources/upload/chatfile");
		
		//serialize 값 가져오기
		HashMap<String, Object>req=getParameterMap(request);
		log.info("파일 업로드 정보 가져오기 form{}",req);
		MultipartFile upFile=(MultipartFile)req.get("file");
		log.info("파일 업로드 정보 가져오기 upFile{}",upFile);
		
               if (!upFile.isEmpty()) {
//				String oriName=upFile.getOriginalFilename();
                   String oriName = upFile.getOriginalFilename();
                   String ext = oriName.substring(oriName.lastIndexOf("."));
                   Date today = new Date(System.currentTimeMillis());
                   int randomNum = (int)(Math.random() * 10000) + 1;
                   String rename = "Rocket_Inventory_File_" + (new SimpleDateFormat("yyyyMMddHHmmssSSS").format(
                           today)) + "_" + randomNum + ext;
                   try {
//					upFile.transferTo(new File(path,rename));
                   	upFile.transferTo(new File(path, rename));
                       InventoryAttach file = InventoryAttach.builder()
                                                             // TODO 사용자 id 나중에 넣어줘야함
                                                             .ivId(1)
                                                             .ivFileNameOri(oriName)
                                                             .ivFileNameRe(rename)
                                                              .ivAttachIsdel("N")
                                                              .build();

                    } catch (IOException | DataAccessException e) {
                        e.printStackTrace();
                    }
                }
               template.convertAndSend("/sub/chat/room/10035",req);
			}
}
