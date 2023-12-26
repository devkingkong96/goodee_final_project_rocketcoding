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
public class NoticeFile {
	private int NOTICE_FILE_NO;
	private String NOTICE_FILE_ORI;
	private String NOTICE_FILE_RE;
}
