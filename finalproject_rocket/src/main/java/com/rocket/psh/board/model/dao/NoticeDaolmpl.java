package com.rocket.psh.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.rocket.psh.board.model.dto.Notice;

@Repository

public class NoticeDaolmpl implements NoticeDao {

	// 공지사항 목록을 조회하는 메소드
    @Override
    public List<Map<String, Object>> selectNoticeList(SqlSession session, Map<String, Object> param) {
        // 매개변수로 받은 Map 객체에는 페이징 처리에 필요한 정보가 들어있습니다.
        // 현재 페이지 번호와 페이지당 보여줄 게시글 수 등의 정보를 사용하여, 해당 페이지에 보여줄 게시글 목록을 데이터베이스에서 조회합니다.
        // SQL 쿼리는 MyBatis의 매퍼 파일에 정의되어 있습니다.
        return session.selectList("notice.selectNoticeList", param);
    }

    // 공지사항을 추가하는 메소드
    @Override
    public int insertNotice(SqlSession session, Notice notice) {
        // 매개변수로 받은 Notice 객체에는 추가할 공지사항의 정보가 들어있습니다.
        // 이 정보를 데이터베이스에 추가하고, 추가된 행의 수를 반환합니다.
        // SQL 쿼리는 MyBatis의 매퍼 파일에 정의되어 있습니다.
        return session.insert("notice.insertNotice", notice);
    }

    // 특정 공지사항의 상세 정보를 조회하는 메소드
    @Override
    public Notice selectNoticeDetail(SqlSession session, int noticeNo) {
        // 매개변수로 받은 공지사항 번호를 사용하여, 해당 번호의 공지사항을 데이터베이스에서 조회하고 반환합니다.
        // SQL 쿼리는 MyBatis의 매퍼 파일에 정의되어 있습니다.
        return session.selectOne("notice.selectNoticeDetail", noticeNo);
    }

    // 공지사항을 수정하는 메소드
    @Override
    public int updateNotice(SqlSession session, Notice notice) {
        // 매개변수로 받은 Notice 객체에는 수정할 공지사항의 정보가 들어있습니다.
        // 이 정보를 데이터베이스에 반영하고, 수정된 행의 수를 반환합니다.
        // SQL 쿼리는 MyBatis의 매퍼 파일에 정의되어 있습니다.
        return session.update("notice.updateNotice", notice);
    }

    // 공지사항을 삭제하는 메소드
    @Override
    public int deleteNotice(SqlSession session, int noticeNo) {
        // 매개변수로 받은 공지사항 번호를 사용하여, 해당 번호의 공지사항을 데이터베이스에서 삭제하고, 삭제된 행의 수를 반환합니다.
        // SQL 쿼리는 MyBatis의 매퍼 파일에 정의되어 있습니다.
        return session.delete("notice.deleteNotice", noticeNo);
    }

    // 공지사항의 조회수를 증가시키는 메소드
    @Override
    public int increaseViewCount(SqlSession session, int noticeNo) {
        // 매개변수로 받은 공지사항 번호를 사용하여, 해당 번호의 공지사항의 조회수를 데이터베이스에서 1 증가시킵니다.
        // SQL 쿼리는 MyBatis의 매퍼 파일에 정의되어 있습니다.
        return session.update("notice.increaseViewCount", noticeNo);
    }

	

}
