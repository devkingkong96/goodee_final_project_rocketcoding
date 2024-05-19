package com.rocket.psh.board.model.dto;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class NoticeFile {
	
	private int noticeFileNo; //공지사항 첨부파일 번호
	private int noticeNo; //공지글 번호
	private String noticeFileOri;//첨부파일
	private String noticeFileRe; //수정첨부파이
}
