package com.rocket.psh.board.model.dao;

import java.util.List;
import java.util.Map;

import com.rocket.psh.board.model.dto.Fboard;

public interface BoardDao {
	
	// 게시글 목록 조회
	List<Map<String, Object>> selectBoard(Map<String, Object> map);
	
	// 게시글 삽입
	int insertFboard(Fboard fboard);
	
	// 게시글 상세 정보 조회
	Fboard selectBoardByNo(int boardNo);
	
	// 게시글 수정
	int updateFboard(Fboard fboard);
	
	// 게시글 삭제
	int deleteFboard(int boardNo);
	
}
