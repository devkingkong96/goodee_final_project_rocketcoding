package com.rocket.jsy.employee.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DwRules {
	
	private int dwrulesCode;
	private String dwrulesStart;
	private String dwrulesEnd;
	private String dwrulesEarly;
	
	private int empNo;
}
