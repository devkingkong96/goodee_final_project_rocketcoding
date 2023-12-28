package com.rocket.psh.board.model.dto;

import java.sql.Date;
import java.util.List;

import com.rocket.jsy.employee.model.dto.Employee;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString(exclude = {"empNo","comments"})
public class Fboard {
	private int fboardNo;
	private Employee empNo;
	private String fboardTitle;
	private String fobardContent;
	private int fboardViews;
	private Date fboardDate;
	
	List<FboardComment> comments;
	List<FboardFile> files;
}
