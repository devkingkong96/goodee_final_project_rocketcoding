package com.rocket.psh.board.dto;

import java.sql.Date;

import com.rocket.jsy.employee.model.dto.Employee;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FboardComment {
	private int commentNo;
	private Fboard fboardNo;
	private Employee empNo;
	private String fbdComment;
	private Date fbdCommentDate;
}
