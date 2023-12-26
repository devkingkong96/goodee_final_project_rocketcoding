package com.rocket.pdw.aprv.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Approval {

	private int aprvNo;
	private int aprvSq;
	private int aprvLv;
	private String aprvRe;
	private int docNo;
	private Date aprvDate;
	private int empNo;
	
}
