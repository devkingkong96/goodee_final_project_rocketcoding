package com.rocket.pdw.aprv.controller;

import static com.rocket.common.Getrequest.getParameterMap;

import java.math.BigDecimal;
import java.sql.Clob;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rocket.jsy.employee.model.dto.Employee;
import com.rocket.pdw.aprv.model.service.ApprovalService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@RequestMapping("/docu")
@Controller
@RequiredArgsConstructor
@Slf4j
public class AprvController {

	private final ApprovalService service;
	

	// 로그인한 사원이 갖고있는 문서리스트
	private List<Map<String, Object>> getAprvListByEmpNo() {
		Employee e = (Employee) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		int no = e.getEmpNo();
		return service.selectAprvList(no);
	}
	

	// 진행중인 전체 문서
	// map.get("DOC_STATCD").equals(BigDecimal.ZERO) 문서상태가 0
	@GetMapping("/lists/a")
	public String selectListAll(Model m) {
		List<Map<String, Object>> alist = getAprvListByEmpNo().stream()
				// 타입이 BigDecimal이다..
				// 진행중인문서
				.filter(map -> map.get("DOC_STATCD").equals(BigDecimal.ZERO)).collect(Collectors.toList());

		m.addAttribute("lists", alist);
		return "aprv/aprvlists";
	}

	// 3.자기 결재순서일때 대기
	// 진행중인 결재문서들의 전 결재자가 결재를했으면 리스트에 담음.
	@GetMapping("/lists/w")
	public String selectListWait(Model m) {

		List<Map<String, Object>> alist = getAprvListByEmpNo().stream()
				// 타입이 BigDecimal이다..	
				// 진행중인문서그리고 참조자가 아니어야함
				.filter(map -> map.get("DOC_STATCD").equals(BigDecimal.ZERO)
						&& !map.get("APRV_LV").equals(BigDecimal.valueOf(99))
					    && map.get("APRV_SQ").equals(BigDecimal.ZERO))
				.collect(Collectors.toList());

		List<Map<String, Object>> ckLvList = alist.stream().map(oldMap -> {
			Map<String, Object> newMap = new HashMap<>();
			BigDecimal aprvLv = (BigDecimal) oldMap.get("APRV_LV");
			newMap.put("DOC_NO", oldMap.get("DOC_NO")); // DOC_NO 값은 그대로 복사
			newMap.put("APRV_LV", aprvLv.subtract(BigDecimal.ONE)); // APRV_LV 값에서 1을 뺌
			return newMap;
		}).collect(Collectors.toList());

		List<Map<String, Object>> ck = service.ckLvList(ckLvList);
		
		
		List<Map<String, Object>> wlist = ck.stream().filter(map -> map.get("APRV_SQ").equals(BigDecimal.ONE))
				.collect(Collectors.toList());
		
		m.addAttribute("lists", wlist);
		
		
		return "aprv/aprvlists";
	}

	// 4.참조자라면 확인
	// 진행중이고 APRV_LV이=99
	@GetMapping("/lists/v")
	public String selectListVali(Model m) {
		List<Map<String, Object>> vlist = getAprvListByEmpNo().stream()
				.filter(map -> map.get("APRV_LV").equals(BigDecimal.valueOf(99))
						&& map.get("DOC_STATCD").equals(BigDecimal.ZERO)
						&& !map.get("APRV_SQ").equals(BigDecimal.ONE))
				.collect(Collectors.toList());

		m.addAttribute("lists", vlist);
		return "aprv/aprvlists";
	}

	// 5.결재라인에 있으면 예정
	@GetMapping("/lists/e")
	public String selectListExpect(Model m) {
		List<Map<String, Object>> alist = getAprvListByEmpNo().stream()
				// 진행중인문서그리고 참조자가 아니어야함
				.filter(map -> map.get("DOC_STATCD").equals(BigDecimal.ZERO)
						&& !map.get("APRV_LV").equals(BigDecimal.valueOf(99)))
				.collect(Collectors.toList());

		List<Map<String, Object>> ckLvList = alist.stream().map(oldMap -> {
			Map<String, Object> newMap = new HashMap<>();
			BigDecimal aprvLv = (BigDecimal) oldMap.get("APRV_LV");
			newMap.put("DOC_NO", oldMap.get("DOC_NO")); // DOC_NO 값은 그대로 복사
			newMap.put("APRV_LV", aprvLv.subtract(BigDecimal.ONE)); // APRV_LV 값에서 1을 뺌
			return newMap;
		}).collect(Collectors.toList());

		List<Map<String, Object>> ck = service.ckLvList(ckLvList);
		List<Map<String, Object>> elist = ck.stream().filter(map -> !map.get("APRV_SQ").equals(BigDecimal.ONE))// 1이아니면
				.collect(Collectors.toList());

		m.addAttribute("lists", elist);
		
		return "aprv/aprvlists";
	}

	// 6.결재라인에 있고 결재했으면 진행
	// APRV_SQ=1 (결재완료) // DOC_STATCD가 ==0
	@GetMapping("/lists/p")
	public String selectListProgress(Model m) {
		List<Map<String, Object>> plist = getAprvListByEmpNo().stream()
				.filter(map -> map.get("APRV_SQ").equals(BigDecimal.ONE)
						&& map.get("DOC_STATCD").equals(BigDecimal.ZERO))
				.collect(Collectors.toList());

		m.addAttribute("lists", plist);
		return "aprv/aprvlists";
	}

	
	@GetMapping("/box/all")
	public String selectBoxAll(Model m) {
		List<Map<String, Object>> alist = getAprvListByEmpNo().stream()
				.filter(map -> !map.get("DOC_STATCD").equals(BigDecimal.ZERO)).collect(Collectors.toList());

		m.addAttribute("lists", alist);
		return "aprv/aprvbox";
	}

	@GetMapping("/box/write")
	public String selectBoxWrite(Model m) {
		Employee e = (Employee) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		int no = e.getEmpNo();

		List<Map<String, Object>> writer = getAprvListByEmpNo().stream()
				.filter(map -> !map.get("DOC_STATCD").equals(BigDecimal.ZERO)
						&& map.get("EMP_NO").equals(BigDecimal.valueOf(no)))
				.collect(Collectors.toList());

		m.addAttribute("lists", writer);
		return "aprv/aprvbox";
	}

	@GetMapping("/box/aprv")
	public String selectBoxAprv(Model m) {
		List<Map<String, Object>> alist = getAprvListByEmpNo().stream().filter(
				map -> !map.get("DOC_STATCD").equals(BigDecimal.ZERO) && map.get("APRV_SQ").equals(BigDecimal.ONE))
				.collect(Collectors.toList());

		m.addAttribute("lists", alist);
		return "aprv/aprvbox";
	}

	@GetMapping("/box/refer")
	public String selectBoxRefer(Model m) {
		List<Map<String, Object>> alist = getAprvListByEmpNo().stream()
				.filter(map -> !map.get("DOC_STATCD").equals(BigDecimal.ZERO)
						&& map.get("APRV_LV").equals(BigDecimal.valueOf(99)))
				.collect(Collectors.toList());

		m.addAttribute("lists", alist);
		return "aprv/aprvbox";
	}

	@GetMapping("/box/return")
	public String selectBoxReturn(Model m) {
		List<Map<String, Object>> alist = getAprvListByEmpNo().stream()
				.filter(map -> map.get("DOC_STATCD").equals(BigDecimal.valueOf(-1))).collect(Collectors.toList());

		m.addAttribute("lists", alist);
		return "aprv/aprvbox";
	}
	

	// ==============================================select list
	// ==================================================================

	
	  @RequestMapping("/insertaprv")
      public String insertAprvView(@RequestParam(value = "startDate", required = false) String startDate, 
                           @RequestParam(value = "endDate", required = false) String endDate,
                             Model m, 
                             HttpSession session) {
          
          Employee e = (Employee)SecurityContextHolder
                  .getContext()
                  .getAuthentication()
                  .getPrincipal();
          int no = e.getEmpNo();
          
          List<Map<String,Object>> saveFile = service.cheackSaveFile(no);
          log.info("+++++++++++saveFile++++++++++++{}",saveFile);
          if(saveFile.size()>0) {
             m.addAttribute("saveFile", saveFile);
             m.addAttribute("uDate", saveFile.get(0).get("U_DATE"));
             
          }else {
             m.addAttribute("saveFile", "null");
          }


          ArrayList<Map<String, Object>> inventoryInfo = (ArrayList<Map<String, Object>>)session.getAttribute(
                  "inventoryInfo");


       m.addAttribute("inventoryInfo", inventoryInfo);


        // 별도의 스레드에서 10초 후에 세션에서 inventoryInfo 속성 제거
       new Thread(() -> {
          try {
             Thread.sleep(10000); // 10초 대기
             session.removeAttribute("inventoryInfo"); // 세션에서 속성 제거
          } catch (InterruptedException e2) {
             e2.printStackTrace();
          }
       	  }).start();

          List<Map<String, Object>> employee = service.selectEmployee(no);
          
          int saveCount =service.countSaveList(no);


          m.addAttribute("user", e);
          m.addAttribute("dept", employee
                  .get(0)
                  .get("DEP_NAME"));
          m.addAttribute("startDate", startDate);
          m.addAttribute("endDate", endDate);
          m.addAttribute("saveCount", saveCount);
          return "aprv/aprvwrite";
      }

	@GetMapping("/aprv/savefile")
	public String saveFileurl(Model m){
		Employee e = (Employee)SecurityContextHolder
                .getContext()
                .getAuthentication()
                .getPrincipal();
        int no = e.getEmpNo();
        int saveCount =service.countSaveList(no);
		List<Map<String,Object>> saveFile = service.cheackSaveFile(no);
		//log.info("=========saveFile========{}",saveFile);
		
		
		
		Clob text = (Clob)saveFile.get(0).get("DOC_CONT");
		String textData = "";
		try {
		    String clobContent = text.getSubString(1, (int) text.length());
		    if (clobContent.startsWith("[") && clobContent.endsWith("]")) {
		        String[] contentArray = clobContent.substring(1, clobContent.length() - 1).split(",");
		        for (String content : contentArray) {
		            textData += content.trim();
		        }
		    } else {
		        textData += clobContent;
		    }
		} catch (Exception e1) {
		    e1.printStackTrace();
		}
		
		
		
		
		List<Map<String, Object>> employee = service.selectEmployee(no);
		m.addAttribute("dept", employee
                .get(0)
                .get("DEP_NAME"));
		m.addAttribute("saveFile", saveFile);
		m.addAttribute("user", e);
		m.addAttribute("textData", textData);
		m.addAttribute("saveCount", saveCount);
		
		return "aprv/aprvsavefile";
	}
	@GetMapping("/checkDept")
	@ResponseBody
	public List<Map<String, Object>> findName(@RequestParam(value = "DEP_CODE", defaultValue = "1") Integer depCode) {

		return service.findName(depCode);
	}

		
	@PostMapping("/submit") 
	@ResponseBody
	public ResponseEntity<?> submitDocu(HttpServletRequest req) {
		
		HashMap<String, Object> reqAll = getParameterMap(req);
  	
		//log.info("reqAll{}",reqAll);
		
		int result = service.insertAprvDocu(reqAll);
		
		//log.info("====================================================등록됬나여 {}",result);
		if(result>0) {
			if(reqAll.get("DOC_TAG").equals("1")) {
				
				return ResponseEntity.ok("mypage");	
			}else {
				
				return ResponseEntity.ok("logistics/inventory/list");
			}
		}
		else 
			
			return ResponseEntity.ok("저장실패");
	}
	@PostMapping("/save") 
	@ResponseBody
	public ResponseEntity<?> saveDocu(HttpServletRequest req) {
		HashMap<String, Object> reqAll = getParameterMap(req);
  	
		log.info("reqAll{}",reqAll);
		
		int result = service.saveDocu(reqAll);
		
		if(ObjectUtils.isEmpty(reqAll.get("DOC_CONT")) || ObjectUtils.isEmpty(reqAll.get("DOC_TITLE"))) {
			return ResponseEntity.badRequest().body("값이 비었습니다");
		}
		
		log.info("====================================================등록됬나여 {}",result);
		if(result>0) {
			if(reqAll.get("DOC_TAG").equals("1")) {
				
				return ResponseEntity.ok("mypage");	
			}else {
				
				return ResponseEntity.ok("logistics/inventory/list");
			}
		}
		else 
			
			return ResponseEntity.ok("저장실패");
	}
	@GetMapping("/aprv/{docNo}")
	public String aprvDocu(@PathVariable int docNo,Model m) {
		
		Employee e=(Employee)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		/* log.info("docNo : {} ",docNo); */
		List<Map<String,Object>>aprvDocu=service.selectAprvDocu(docNo);
		log.info("===========aprvDocu : {} ",aprvDocu);
		
		Clob text = (Clob)aprvDocu.get(0).get("DOC_CONT");
		String textData = "";
		try {
		    String clobContent = text.getSubString(1, (int) text.length());
		    if (clobContent.startsWith("[") && clobContent.endsWith("]")) {
		        String[] contentArray = clobContent.substring(1, clobContent.length() - 1).split(",");
		        for (String content : contentArray) {
		            textData += content.trim();
		        }
		    } else {
		        textData += clobContent;
		    }
		} catch (Exception e1) {
		    e1.printStackTrace();
		}
		
		
		  
	       
	    m.addAttribute("user", e);  
		m.addAttribute("docNo", docNo);
		m.addAttribute("docu", aprvDocu);
		m.addAttribute("textData", textData);
		
		
		return "aprv/aprv";
	}
	

	
	@PostMapping("/updateaprv")
	@ResponseBody
	public ResponseEntity<?> updateAprv(HttpServletRequest req) {
		
		
		HashMap<String, Object> reqAll = getParameterMap(req);	
		
		
		int result = service.updateAprv(reqAll);
	
			
		if (result > 0) {
			return ResponseEntity.ok().body("결재 성공");

		} else {
			return ResponseEntity.ok().body("결재 실패");

		}


	}
	@PostMapping("/rejectaprv")
	@ResponseBody
	public ResponseEntity<?> rejectAprv(HttpServletRequest req) {
		
		HashMap<String, Object> reqAll = getParameterMap(req);
		
		int result = service.rejectAprv(reqAll);
		
		if (result > 0) {
			return ResponseEntity.ok().body("반려 성공");

		} else {
			return ResponseEntity.ok().body("반려 실패");

		}
		
		
	}
	@PostMapping("/checkaprvlv")
	@ResponseBody
	public boolean checkAprvLv(HttpServletRequest req) {
		Employee e = (Employee) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		HashMap<String,Object> reqAll= getParameterMap(req);
		
		
		int docNo = Integer.parseInt((String)reqAll.get("DOC_NO")); 
		
		List<Map<String,Object>>aprvDocu=service.selectAprvDocu(docNo);
		
		List<Map<String,Object>> myDocu= aprvDocu.stream().filter(aprv -> aprv.get("APRV_EMP").equals(BigDecimal.valueOf(e.getEmpNo()))).collect(Collectors.toList());
		
		BigDecimal myLv = (BigDecimal) myDocu.get(0).get("APRV_LV");
		BigDecimal nowLv = myLv.subtract(BigDecimal.ONE);
		
		
		List<Map<String,Object>> preAprv=aprvDocu.stream().filter(aprv-> aprv.get("APRV_LV").equals(nowLv)).toList();
		
		
		boolean result = 
                ((BigDecimal) preAprv.get(0).get("APRV_SQ")).compareTo(BigDecimal.ONE) == 0;
		
		
		return result;
		
		
	}
	
	@GetMapping("/savefilelists")
	@ResponseBody
	public List<Map<String, Object>> saveFileList () {
		Employee e = (Employee) SecurityContextHolder
				.getContext().getAuthentication().getPrincipal();
		int no = e.getEmpNo();
		List<Map<String,Object>>saveLists = service.selectSaveList(no);
		
		String textData = "";
		for (Map<String, Object> map : saveLists) {
			Clob text = (Clob)map.get("DOC_CONT");
			try {
			    String clobContent = text.getSubString(1, (int) text.length());
			    if (clobContent.startsWith("[") && clobContent.endsWith("]")) {
			        String[] contentArray = clobContent.substring(1, clobContent.length() - 1).split(",");
			        for (String content : contentArray) {
			            textData += content.trim();
			        }
			    } else {
			        textData += clobContent;
			    }
			}catch (Exception e1) {
			    e1.printStackTrace();
			}finally {
				map.put("DOC_CONT", textData);
			}
		} 
		return saveLists;
		
		
		
	}
	@GetMapping("/save/{docNo}")
	public String saveFileNo(@PathVariable int docNo,Model m) {
		
		Employee e=(Employee)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		int no = e.getEmpNo();
		
		List<Map<String,Object>>aprvDocu=service.selectAprvDocu(docNo);
		log.info("===========aprvDocu : {} ",aprvDocu);
		
		Clob text = (Clob)aprvDocu.get(0).get("DOC_CONT");
		String textData = "";
		try {
		    String clobContent = text.getSubString(1, (int) text.length());
		    if (clobContent.startsWith("[") && clobContent.endsWith("]")) {
		        String[] contentArray = clobContent.substring(1, clobContent.length() - 1).split(",");
		        for (String content : contentArray) {
		            textData += content.trim();
		        }
		    } else {
		        textData += clobContent;
		    }
		} catch (Exception e1) {
		    e1.printStackTrace();
		}
		int saveCount =service.countSaveList(no);

	    m.addAttribute("user", e);
	    List<Map<String, Object>> employee = service.selectEmployee(no);
		m.addAttribute("dept", employee
                .get(0)
                .get("DEP_NAME"));
		m.addAttribute("docNo", docNo);
		m.addAttribute("saveFile", aprvDocu);
		m.addAttribute("textData", textData);
		m.addAttribute("saveCount", saveCount);
		
		
		return "aprv/aprvsavefile";
	}
	@GetMapping("/countlist")
	@ResponseBody
	public String countList() {

		List<Map<String, Object>> alist = getAprvListByEmpNo().stream()
				// 타입이 BigDecimal이다..	
				// 진행중인문서그리고 참조자가 아니어야함
				.filter(map -> map.get("DOC_STATCD").equals(BigDecimal.ZERO)
						&& !map.get("APRV_LV").equals(BigDecimal.valueOf(99))
					    && map.get("APRV_SQ").equals(BigDecimal.ZERO))
				.collect(Collectors.toList());

		List<Map<String, Object>> ckLvList = alist.stream().map(oldMap -> {
			Map<String, Object> newMap = new HashMap<>();
			BigDecimal aprvLv = (BigDecimal) oldMap.get("APRV_LV");
			newMap.put("DOC_NO", oldMap.get("DOC_NO")); // DOC_NO 값은 그대로 복사
			newMap.put("APRV_LV", aprvLv.subtract(BigDecimal.ONE)); // APRV_LV 값에서 1을 뺌
			return newMap;
		}).collect(Collectors.toList());

		List<Map<String, Object>> ck = service.ckLvList(ckLvList);
		
		
		List<Map<String, Object>> wlist = ck.stream().filter(map -> map.get("APRV_SQ").equals(BigDecimal.ONE))
				.collect(Collectors.toList());
		
		
		int size= wlist.size();
		String strSize = String.valueOf(size);
		
		return strSize;
	}
}
