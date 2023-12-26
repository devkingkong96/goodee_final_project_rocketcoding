package com.rocket.psh.board.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Notice {
	private int NOTICE_CO;
	private int EMP_NO;
	private String NOTICE_TITLE;
	private String NOTICE_CONTENT;
	private int NOTICE_VIEWS;
	private Date NOTICE_DATE;
}
