package com.rocket.jsy.employee.model.dto;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class EmployeeDto {
	
	private int empNo;
	private String empPw;
	private String empName;
	private String empLv;
	private Date empEndate;
	private String empStatus;
	private String empFication;
	private String empEmail;
	
	public static EmployeeDto of(Employee emp) {
		return new EmployeeDto(emp.getEmpNo(), emp.getEmpPw(), emp.getEmpName(),
		                       emp.getEmpLv(), emp.getEmpEndate(),
		                       emp.getEmpStatus(), emp.getEmpFication(),
		                       emp.getEmpEmail()
		
		);
		
	}
}
