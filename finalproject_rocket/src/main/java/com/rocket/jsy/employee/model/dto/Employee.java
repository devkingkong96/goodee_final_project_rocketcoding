package com.rocket.jsy.employee.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Employee {
	private int empNo;
	private String empPw;
	private String empName;
	private String empLv;
	private Date empEndate;
	private String empStatus;
	private String empFication; //재직/퇴직 여부
	private int branchId;//지점고유번호
}
