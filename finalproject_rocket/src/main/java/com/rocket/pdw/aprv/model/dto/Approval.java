package com.rocket.pdw.aprv.model.dto;

import java.sql.Date;

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
public class Approval {
	
	private int aprvNo;
	private int aprvSq;
	private int aprvLv;
	private String aprvRe;
	
	private int docNo;
	private Date aprvDate;
	
	private int empNo;
}