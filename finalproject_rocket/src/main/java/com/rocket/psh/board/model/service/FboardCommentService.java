package com.rocket.psh.board.model.service;

import java.util.Map;

public interface FboardCommentService {
	
	 int insertComment(Map<String, Object> commentMap);
	 
	 int updateComment(Map<String, Object> commentMap);
	 
	 int deleteComment(int commentNo);
}
