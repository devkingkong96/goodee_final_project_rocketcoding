package com.rocket.psh.board.model.service;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.rocket.psh.board.model.dao.FboardCommentDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FboardCommentServicelmpl implements FboardCommentService {

    private final FboardCommentDao fboardCommentDao;
    private final SqlSession session;
    
	@Override
	public int insertComment(Map<String, Object> commentMap) {
		// TODO Auto-generated method stub
		return fboardCommentDao.insertComment(session,commentMap);
	}
	@Override
	public int updateComment(Map<String, Object> commentMap) {
		// TODO Auto-generated method stub
		return fboardCommentDao.updateComment(session,commentMap);
	}

	@Override
	public int deleteComment(int commentNo) {
		// TODO Auto-generated method stub
		return fboardCommentDao.deleteComment(session, commentNo);
	}
	
	
//	@Override
//	public int deleteComment(int commentNo, int fboardNo) {
//		// TODO Auto-generated method stub
//		return 0;
//	}
	
	
}
