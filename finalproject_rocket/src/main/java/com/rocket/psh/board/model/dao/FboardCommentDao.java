package com.rocket.psh.board.model.dao;

import java.util.HashMap;
import java.util.List;

public interface FboardCommentDao {
	 // 댓글 조회
    HashMap<String, Object> selectCommentByCommentNo(int commentNo);

    // 게시글에 대한 모든 댓글 조회
    List<HashMap<String, Object>> selectCommentsByFboardNo(int fboardNo);

    // 댓글 추가
    int insertComment(HashMap<String, Object> commentData);
    //int insertComment(Map param);

    // 댓글 수정
    int updateComment(HashMap<String, Object> commentData);

    // 댓글 삭제여부 업데이트 (실제 삭제는 하지 않음)
    int deleteComment(int commentNo);
}
