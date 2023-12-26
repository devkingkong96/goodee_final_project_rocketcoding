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
	private int fboardFileNo;
	private Fboard fboardNo;
	private String fboardFileOri;
	private String fboardFileRe;
}
