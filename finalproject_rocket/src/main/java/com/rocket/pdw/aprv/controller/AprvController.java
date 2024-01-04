package com.rocket.pdw.aprv.controller;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rocket.jsy.employee.model.dto.Employee;
import com.rocket.pdw.aprv.model.service.ApprovalService;

import lombok.RequiredArgsConstructor;

@RequestMapping("/docu")
@Controller
@RequiredArgsConstructor
public class AprvController {
	
	private final ApprovalService service;
	//로그인한 사원이 갖고있는 문서리스트
	private List<Map<String, Object>> getAprvListByEmpNo() {  
		Employee e = (Employee) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        int no = e.getEmpNo();
        return service.selectAprvList(no);
    }
	
	//진행중인 전체 문서 
	//map.get("DOC_STATCD").equals(BigDecimal.ZERO) 문서상태가 0
	@GetMapping("/lists/a")
	public String a(Model m) {
		List<Map<String,Object>> alist = getAprvListByEmpNo().stream()
			    //타입이 BigDecimal이다..
				//진행중인문서
				.filter(map-> map.get("DOC_STATCD").equals(BigDecimal.ZERO))   
			    .collect(Collectors.toList());
		
		
		m.addAttribute("lists", alist);
		return "aprv/aprvlists";
	}
	//3.자기 결재순서일때 대기
	//진행중인 결재문서들의 전 결재자가 결재를했으면 리스트에 담음.
	@GetMapping("/lists/w")
	public String w(Model m) { 
	
		List<Map<String,Object>> alist = getAprvListByEmpNo().stream()
			    //타입이 BigDecimal이다..
				//진행중인문서그리고 참조자가 아니어야함
				.filter(map-> map.get("DOC_STATCD").equals(BigDecimal.ZERO) && !map.get("APRV_LV").equals(BigDecimal.valueOf(99)))   
			    .collect(Collectors.toList());
		
		List<Map<String, Object>> ckLvList = alist.stream().map(oldMap -> {
		    Map<String, Object> newMap = new HashMap<>();
		    BigDecimal aprvLv = (BigDecimal) oldMap.get("APRV_LV");
		    newMap.put("DOC_NO", oldMap.get("DOC_NO")); // DOC_NO 값은 그대로 복사
		    newMap.put("APRV_LV", aprvLv.subtract(BigDecimal.ONE)); // APRV_LV 값에서 1을 뺌
		    return newMap;
		}).collect(Collectors.toList());


		
		List<Map<String,Object>> ck = service.ckLvList(ckLvList);
		List<Map<String,Object>> wlist=ck.stream().filter(map-> map.get("APRV_SQ").equals(BigDecimal.ONE))
	    			.collect(Collectors.toList());
		
		
		m.addAttribute("lists", wlist);
		return "aprv/aprvlists";
	}
	
	//4.참조자라면 확인
	//진행중이고 APRV_LV이=99
	@GetMapping("/lists/v")
	public String v(Model m) {
		List<Map<String,Object>> vlist = getAprvListByEmpNo().stream()
			    .filter(map -> map.get("APRV_LV").equals(BigDecimal.valueOf(99)) && map.get("DOC_STATCD").equals(BigDecimal.ZERO))
			    .collect(Collectors.toList());
		
		m.addAttribute("lists", vlist);
		return "aprv/aprvlists";
	}
	
	//5.결재라인에 있으면 예정 
	@GetMapping("/lists/e")
	public String e(Model m) { 
		List<Map<String,Object>> alist = getAprvListByEmpNo().stream()
				//진행중인문서그리고 참조자가 아니어야함
				.filter(map-> map.get("DOC_STATCD").equals(BigDecimal.ZERO) && !map.get("APRV_LV").equals(BigDecimal.valueOf(99)))   
			    .collect(Collectors.toList());
		
		List<Map<String, Object>> ckLvList = alist.stream().map(oldMap -> {
		    Map<String, Object> newMap = new HashMap<>();
		    BigDecimal aprvLv = (BigDecimal) oldMap.get("APRV_LV");
		    newMap.put("DOC_NO", oldMap.get("DOC_NO")); // DOC_NO 값은 그대로 복사
		    newMap.put("APRV_LV", aprvLv.subtract(BigDecimal.ONE)); // APRV_LV 값에서 1을 뺌
		    return newMap;
		}).collect(Collectors.toList());
			
			List<Map<String,Object>> ck = service.ckLvList(ckLvList);
			List<Map<String,Object>> elist=ck.stream().filter(map-> !map.get("APRV_SQ").equals(BigDecimal.ONE))//1이아니면
		    			.collect(Collectors.toList());
	
			m.addAttribute("lists", elist);
		
		return "aprv/aprvlists";
	}
	
	//6.결재라인에 있고 결재했으면 진행
	//APRV_SQ=1 (결재완료) // DOC_STATCD가 ==0
	@GetMapping("/lists/p")
	public String p(Model m) {
		List<Map<String,Object>> plist = getAprvListByEmpNo().stream()
			    .filter(map -> map.get("APRV_SQ").equals(BigDecimal.valueOf(1)) && map.get("DOC_STATCD").equals(BigDecimal.ZERO))
			    .collect(Collectors.toList());
		
		m.addAttribute("lists", plist);
		return "aprv/aprvlists";
	}
	//========================================문서함================================================
	@GetMapping("/box/all")
	public String all(Model m) {
		List<Map<String,Object>> alist = getAprvListByEmpNo().stream()				
				.filter(map-> !map.get("DOC_STATCD").equals(BigDecimal.ZERO))   
			    .collect(Collectors.toList());
		
		m.addAttribute("lists", alist);
		return "aprv/aprvbox";
	}
	@GetMapping("/box/write")
	public String writer(Model m) {
		Employee e = (Employee) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        int no = e.getEmpNo();
		List<Map<String,Object>> writer = getAprvListByEmpNo().stream()				
				.filter(map-> !map.get("DOC_STATCD").equals(BigDecimal.ZERO) && map.get("EMP_NO").equals(no))   
			    .collect(Collectors.toList());
		
		m.addAttribute("lists", writer);
		return "aprv/aprvbox";
	}
	@GetMapping("/box/aprv")
	public String aprv(Model m) {
		List<Map<String,Object>> alist = getAprvListByEmpNo().stream()				
				.filter(map-> !map.get("DOC_STATCD").equals(BigDecimal.ZERO) && map.get("APRV_SQ").equals(BigDecimal.ONE))   
			    .collect(Collectors.toList());
		
		m.addAttribute("lists", alist);
		return "aprv/aprvbox";
	}
	@GetMapping("/box/refer")
	public String refer(Model m) {
		List<Map<String,Object>> alist = getAprvListByEmpNo().stream()				
				.filter(map-> !map.get("DOC_STATCD").equals(BigDecimal.ZERO) && map.get("APRV_LV").equals(BigDecimal.valueOf(99)))   
			    .collect(Collectors.toList());
		
		m.addAttribute("lists", alist);
		return "aprv/aprvbox";
	}
	
	@GetMapping("/box/return")
	public String aprvreturn (Model m) {
		List<Map<String,Object>> alist = getAprvListByEmpNo().stream()				
				.filter(map-> map.get("DOC_STATCD").equals(BigDecimal.valueOf(-1)))   
			    .collect(Collectors.toList());
		
		m.addAttribute("lists", alist);
		return "aprv/aprvbox";
	}
	
	
	//==============================================select list ==================================================================
	
	@GetMapping("/aprv")
	public String aprvDetail() {	
		return "aprv/aprv";
	}
	@GetMapping("/insertaprv")
	public String insertAprvView(Model m) {		
		return "aprv/aprvwrite";
	}
	
	@GetMapping("/checkDept")
	@ResponseBody
	public List<Map<String, Object>> findName(@RequestParam(value = "DEP_CODE", defaultValue = "1") Integer depCode) {
		
		return service.findName(depCode);
	}



}
