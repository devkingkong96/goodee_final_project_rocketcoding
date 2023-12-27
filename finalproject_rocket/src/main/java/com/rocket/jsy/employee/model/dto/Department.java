package com.rocket.jsy.employee.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Department {
	private int depCode;
	private String depName;
	
	private Employee empNo; //사원번호
}
