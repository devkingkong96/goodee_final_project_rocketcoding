package com.rocket.ksj.chat.controller;

import static com.rocket.common.Getrequest.getParameterMap;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.net.MalformedURLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.tomcat.util.http.fileupload.FileUtils;
import org.json.simple.JSONObject;
import org.springframework.core.io.UrlResource;
import org.springframework.dao.DataAccessException;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.rocket.jsy.employee.model.dto.Employee;
import com.rocket.ksj.chat.model.dto.ChatMessage;
import com.rocket.ksj.chat.model.service.ChatService;
import com.rocket.seoj.logistics.model.dto.InventoryAttach;

import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
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

	private final Gson gson;
	private final ChatService service;
	
	
	@GetMapping("/list")
	public String chatlist(Model m) {
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
	
	@PostMapping("/file/download")
	@ResponseBody
	public String chatFileDownload(@RequestBody ChatMessage message,HttpSession session,HttpServletResponse response)
		throws ServletException, IOException{
		String oriName=message.getMsgFiOriName();
		String reName=message.getMsgFiReName();
		
		//파일 스트림 연결
		//실제 경로 가져오기
		String path = session
				.getServletContext()
				.getRealPath("/resources/upload/chatfile/");
		FileInputStream fis=new FileInputStream(path+reName);
		BufferedInputStream bis=new BufferedInputStream(fis);
		
		//파일명 인코딩 처리
		String encodingName=new String(reName.getBytes("UTF-8"),"ISO-8859-1");
		
		//응답 헤더 설정 -> contentType
		response.setContentType("application/octet-stream");
		response.setHeader("Content-disposition", "attachment;filename="+encodingName);
		
		//사용자에게 파일 데이터 전송
		ServletOutputStream sos=response.getOutputStream();
		BufferedOutputStream bos=new BufferedOutputStream(sos);
		
		int read=-1;
		while((read=bis.read())!=-1) {
			bos.write(read);
		}
		
		bis.close();
		bos.close();
		
//		log.info("메세지 정보{}",message);
//		
//		//파일 경로
//		
//		path=path+reName;
//			File file=new File(path,reName);
//			if(!file.isFile()) {
//				log.debug("파일없음");
//			}
//			
//			
////			FileInputStream in = new FileInputStream(path);
////			reName=new String(reName.getBytes("UTF-8"),"8859_1");
//			response.setHeader("Content-Transfer-Encoding", "binary;");
//			
//			OutputStream os = response.getOutputStream();
//		
//		int length;
//		byte[] b= new byte[(int) file.length()];
//		while((length=in.read(b))>0) {
//			os.write(b,0,length);
//		}
//		os.flush();
//		os.close();
//		in.close();
		
		//Body 설정
//		UrlResource resource;
//		try {
//			resource=new UrlResource("file:"+path);
//		} catch (MalformedURLException e) {
//			log.error("{}",e);
//			e.printStackTrace();
//		}
		//Header 설정
		
		
		String jsonString=gson.toJson("success");
		return jsonString;
	}
	
	@GetMapping("/room/modalsearch/{roomId}")
	@ResponseBody
	public List<Map<String, Object>>modalSearch(@PathVariable int roomId,String modalsearchValue){
		log.info("가져온 검색어{}",modalsearchValue);
		log.info("방 번호{}",roomId);
		
		Map<String,Object>param=new HashMap<>();
		param.put("modalsearchValue", modalsearchValue);
		param.put("roomId", roomId);
		List<Map<String, Object>>result=service.modalSearch(param);
		log.info("방 번호{}",result);
		
		return result;
	}
	
}
