package com.rocket.psh.board.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class FboardCommentDaolmpl implements FboardCommentDao {
		
		private SqlSessionFactory sqlSessionFactory;
	
		
	    // 댓글 조회
	    public HashMap<String, Object> selectCommentByCommentNo(int commentNo) {
	        try (SqlSession session = sqlSessionFactory.openSession()) {
	            return session.selectOne("selectCommentByCommentNo", commentNo);
	        }
	    }
	
	    // 게시글에 대한 모든 댓글 조회
	    public List<HashMap<String, Object>> selectCommentsByFboardNo(int fboardNo) {
	        try (SqlSession session = sqlSessionFactory.openSession()) {
	            return session.selectList("selectCommentsByFboardNo", fboardNo);
	        }
	    }
	
	    // 댓글 추가
		/*
		 * public int insertComment(HashMap<String, Object> commentData) { try
		 * (SqlSession session = sqlSessionFactory.openSession()) { int result =
		 * session.insert("insertComment", commentData); session.commit(); return
		 * result; } }
		 */
	    //댓글 추가 
//	    public int (Map param) {
//	        return commentMapper.insertComment(param);
//	    }
	    

		public int insertComment(Map<String, Object> reqAll) {
			//임시저장하기	
			 try (SqlSession session = sqlSessionFactory.openSession()) {
		            return session.insert("insertComment", reqAll);
		        }
		}
	
	    // 댓글 수정
	    public int updateComment(HashMap<String, Object> commentData) {
	        try (SqlSession session = sqlSessionFactory.openSession()) {
	            int result = session.update("updateComment", commentData);
	            session.commit();
	            return result;
	        }
	    }
	
	    // 댓글 삭제여부 업데이트 (실제 삭제는 하지 않음)
	    public int deleteComment(int commentNo) {
	        try (SqlSession session = sqlSessionFactory.openSession()) {
	            HashMap<String, Object> params = new HashMap<>();
	            params.put("commentNo", commentNo);
	            params.put("FBD_COMMENT_YN", "Y");
	            int result = session.update("deleteComment", params);
	            session.commit();
	            return result;
	        }
	    }
}

