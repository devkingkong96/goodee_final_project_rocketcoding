package com.rocket.psh.board.model.service;

import java.util.Map;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.rocket.psh.board.model.dao.NoticeDao;
import com.rocket.psh.board.model.dto.Notice;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NoticeServiceImpl implements NoticeService {

    private final NoticeDao dao;
    private final SqlSession session;

    
    @Override
    public List<Map<String, Object>> selectNoticeMainPage(Map<String, Object> param) {
        try {
            return dao.selectNoticeList(session,param);
        } catch(Exception e) {
            // 로깅 처리
            throw new RuntimeException("공지사항 목록 조회 중 오류가 발생했습니다.", e);
        }
    }

    @Override
    public int insertNotice(Notice notice) {
        try {
            return dao.insertNotice(session, notice);
        } catch(Exception e) {
            // 로깅 처리
            throw new RuntimeException("공지사항 등록 중 오류가 발생했습니다.", e);
        }
    }

    @Override
    public Notice selectNoticeDetail(int noticeNo) {
        try {
            return dao.selectNoticeDetail(session, noticeNo);
        } catch(Exception e) {
            // 로깅 처리
            throw new RuntimeException("공지사항 상세 정보 조회 중 오류가 발생했습니다.", e);
        }
    }

    @Override
    public int updateNotice(Notice notice) {
        try {
            return dao.updateNotice(session, notice);
        } catch(Exception e) {
            // 로깅 처리
            throw new RuntimeException("공지사항 수정 중 오류가 발생했습니다.", e);
        }
    }

    @Override
    public int deleteNotice(int noticeNo) {
        try {
            return dao.deleteNotice(session, noticeNo);
        } catch(Exception e) {
            // 로깅 처리
            throw new RuntimeException("공지사항 삭제 중 오류가 발생했습니다.", e);
        }
    }

    @Override
    public int increaseViewCount(int noticeNo) {
        try {
            return dao.increaseViewCount(session, noticeNo);
        } catch(Exception e) {
            // 로깅 처리
            throw new RuntimeException("조회수 증가 처리 중 오류가 발생했습니다.", e);
        }
    }
    
	/*
	 * @Override public List<Map<String, Object>> selectNoticeMainPage(Map<String,
	 * Object> param) { // NoticeMapper를 통해 DB에서 공지사항 데이터를 조회하고 이를 반환합니다. return
	 * dao.selectNoticeList(session,param); }
	 * 
	 * @Override public int insertNotice(Notice notice) { // NoticeMapper를 통해 DB에
	 * 공지사항 데이터를 추가합니다. return dao.insertNotice(session, notice); }
	 * 
	 * @Override public Notice selectNoticeDetail(int noticeNo) { // NoticeMapper를
	 * 통해 DB에서 특정 공지사항의 상세 정보를 조회합니다. return dao.selectNoticeDetail(session,
	 * noticeNo); }
	 * 
	 * @Override public int updateNotice(Notice notice) { // NoticeMapper를 통해 DB에서
	 * 특정 공지사항을 수정합니다. return dao.updateNotice(session, notice); }
	 * 
	 * @Override public int deleteNotice(int noticeNo) { // NoticeMapper를 통해 DB에서 특정
	 * 공지사항을 삭제합니다. return dao.deleteNotice(session, noticeNo); }
	 * 
	 * @Override public int increaseViewCount(int noticeNo) { // NoticeMapper를 통해
	 * DB에서 특정 공지사항의 조회수를 증가시킵니다. return dao.increaseViewCount(session, noticeNo); }
	 */
}
