package com.rocket.jsy.employee.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class EmpFile {
	private int empfileNo;
	private String empfileOri;
	private String empfileRename;
	
	private Employee empNo; //사원번호
}
