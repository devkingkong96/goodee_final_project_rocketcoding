package com.rocket.psh.board.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
public class FboardCommentDaolmpl implements FboardCommentDao {
		
//		// 댓글 조회
	    public HashMap<String, Object> selectCommentByCommentNo(SqlSession session,int commentNo) {
	            return session.selectOne("fboardcomment.selectCommentByCommentNo", commentNo);
	    }
	
//	    // 게시글에 대한 모든 댓글 조회
	    public List<HashMap<String, Object>> selectCommentsByFboardNo(SqlSession session,int fboardNo) {
	            return session.selectList("fboardcomment.selectCommentsByFboardNo", fboardNo);
	    }
	
	    // 댓글 추가

		 
//	    //댓글 추가 
//	    public int (SqlSession session,Map param) {
//	        return commentMapper.insertComment(param);
//	    }
	    
		public int insertComment(SqlSession session, Map<String, Object> reqAll) { 
			return session.insert("fboardcomment.insertComment", reqAll); 
		} 
		  
		  // 댓글 수정 
		public int updateComment(SqlSession session,Map<String, Object> commentData) {
		  int result = session.update("fboardcomment.updateComment", commentData); 
		  return result;
		}
		  
		  // 댓글 삭제여부 업데이트 (실제 삭제는 하지 않음) 
		public int deleteComment(SqlSession session,int commentNo) { 
		  HashMap<String,Object> params = new HashMap<>(); 
		  params.put("commentNo", commentNo);
		  params.put("FBD_COMMENT_YN", "Y"); 
		  int result = session.update("fboardcomment.deleteComment", params);
		  return result; 
		} 
		  
		 

		
}

