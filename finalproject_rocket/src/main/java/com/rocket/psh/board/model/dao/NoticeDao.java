package com.rocket.psh.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.rocket.psh.board.model.dto.Notice;

public interface NoticeDao {
	// 공지사항 리스트 조회
    List<Map<String, Object>> selectNoticeList(SqlSession session, Map<String,Object> param);

    // 공지사항 추가
    int insertNotice(SqlSession session, Notice notice);

    // 공지사항 상세 조회
    Notice selectNoticeDetail(SqlSession session, int noticeNo);

    // 공지사항 수정
    int updateNotice(SqlSession session, Notice notice);

    // 공지사항 삭제
    int deleteNotice(SqlSession session,int noticeNo);

    // 공지사항 조회수 증가
    int increaseViewCount(SqlSession session, int noticeNo);
}
