package com.rocket.psh.board.model.service;

import java.util.List;
import java.util.Map;

import com.rocket.psh.board.model.dto.Fboard;

public interface FboardService {
	
	List<Fboard> selectBoard(Map<String,Integer>page);
	
	int selectFboardCount();
	
	Fboard selectBoardByNo(int boardNo);
	
	int insertFboard(Fboard b);
}
