package com.rocket.jsy.employee.model.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Department {
	private int depCode;
	private String depName;
	
	private List<Employee> employeeList; //사원번호
}
