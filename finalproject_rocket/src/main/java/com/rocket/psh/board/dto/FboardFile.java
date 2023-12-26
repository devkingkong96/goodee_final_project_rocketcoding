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
public class FboardFile {
	private int FBOARD_FILE_NO;
	private int FBOARD_NO;
	private String FBOARD_FILE_ORI;
	private String FBOARD_FILE_RE;
}
