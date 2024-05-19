package com.rocket.psh.board.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.rocket.psh.board.model.dto.Fboard;

public interface FboardService {
   
   List<Map<String, Object>> selectFboardList(Map<String, Object> map); 
   
   int insertFboard(Fboard fboard);

   int increaseViewCount(int fboardNo);
   
   Fboard selectFboardDetail(int fboardNo);

   List<Map<String, Object>> selectFboardComments(int fboardNo);
   
   int updateFboard(Fboard fboard0);

   int deleteFboard(int fboardNo);

   int deleteComment(int commentNo);

   
   
   
}
