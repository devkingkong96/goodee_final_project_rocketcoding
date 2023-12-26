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
public class Fboard {
	private int FBOARD_NO;
	private int EMP_NO;
	private String FBOARD_TITLE;
	private String FBOARD_CONTENT;
	private int FBOARD_VIEWS;
	private Date FBOARD_DATE;
}
