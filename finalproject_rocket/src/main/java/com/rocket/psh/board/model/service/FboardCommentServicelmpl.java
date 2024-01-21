package com.rocket.psh.board.model.service;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rocket.pdw.aprv.model.dao.ApprovalDao;
import com.rocket.psh.board.model.dao.FboardCommentDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FboardCommentServicelmpl implements FboardCommentService {

    private final FboardCommentDao fboardCommentDao;

    @Override
    public int insertComment(Map<String, Object> commentMap) {
        
        return fboardCommentDao.insertComment(commentMap);
    }

}
