package com.rocket.psh.board.model.dto;

import java.sql.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import com.rocket.jsy.employee.model.dto.Employee;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Notice {
	
	private int noticeNo; //공지글 번호
	private int empNo; //사원번호
	private String noticeTitle; //공지제목
	private String noticeContent; //공지내용
	private int noticeViews; //조회수
	private Date noticeDate; //공지사항 작성일 
	
}
