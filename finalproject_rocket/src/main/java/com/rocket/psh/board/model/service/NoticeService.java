package com.rocket.psh.board.model.service;

import java.util.List;
import java.util.Map;

import com.rocket.psh.board.model.dto.Notice;

public interface NoticeService {
    // 메인 페이지에 보여줄 공지사항을 조회하는 메소드입니다.
    List<Map<String, Object>> selectNoticeMainPage(Map<String, Object> param);

    // 공지사항을 추가하는 메소드입니다.
    int insertNotice(Notice notice);

    // 공지사항 상세 정보를 조회하는 메소드입니다.
    Notice selectNoticeDetail(int noticeNo);

    // 공지사항을 수정하는 메소드입니다.
    int updateNotice(Notice notice);

    // 공지사항을 삭제하는 메소드입니다.
    int deleteNotice(int noticeNo);

    // 공지사항 조회수를 증가시키는 메소드입니다.
    int increaseViewCount(int noticeNo);
}
