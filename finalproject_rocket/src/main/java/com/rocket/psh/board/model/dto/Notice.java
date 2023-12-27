package com.rocket.psh.board.model.dto;

import java.sql.Date;
import java.util.List;

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
	private int noticeNo;
	private Employee empNo;
	private String noticeTitle;
	private String noticeContent;
	private int noticeViews;
	private Date noticeDate;
	
	List<NoticeFile> files;
}
