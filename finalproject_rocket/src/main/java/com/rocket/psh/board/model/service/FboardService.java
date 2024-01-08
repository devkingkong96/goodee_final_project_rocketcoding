package com.rocket.psh.board.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.rocket.psh.board.model.dto.Fboard;

public interface FboardService {
	
	List<Map<String, Object>> selectFboardList(Map<String, Object> map); 
	
	int insertFboard(Map<String, Object> map) throws Exception;

	Map<String, Object> selectFboardDetail(Map<String, Object> map);

	int updateFboard(Map<String, Object> map);

	int deleteFboard(Map<String, Object> map); 

}
