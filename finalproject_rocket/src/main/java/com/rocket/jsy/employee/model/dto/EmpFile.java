package com.rocket.jsy.employee.model.dto;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EmpFile {
	private int empfileNo;
	private String empfileOri;
	private String empfileRename;
	
	private Employee empNo; //사원번호
}
