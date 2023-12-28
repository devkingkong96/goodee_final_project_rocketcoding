package com.rocket.psh.board.model.service;

import java.util.List;

import com.rocket.psh.board.model.dto.Notice;

public interface NoticeService {
	List<Notice> getNoticeList() throws Exception;
	
	Notice getNoticeInfo(Notice pDTO, boolean type) throws Exception;
	
	//공지사항 등록 pDTO 화면에서 입력된 공지사항 입력된 값
	void insertNoticeInfo(Notice pDTO) throws Exception;
	
	//공지사항 수정 pDTO 화면에 입력된 수정되기 위한 공지사항 입력된 값들 집가고 싶다.
	void updateNoticeInfo(Notice pDTO) throws Exception;
	
	//공지사항 삭제 임둥~ pDTO 에서 삭제할 noticeSeq 값
	void deletNoticeInfo(Notice pDTO) throws Exception;
}
