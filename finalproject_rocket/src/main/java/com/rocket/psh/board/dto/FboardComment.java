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
public class FboardComment {
	private int COMMENT_NO;
	private int FBOARD_NO;
	private int EMP_NO;
	private String FBD_COMMENT;
	private Date FBD_COMMENT_DATE;
}
