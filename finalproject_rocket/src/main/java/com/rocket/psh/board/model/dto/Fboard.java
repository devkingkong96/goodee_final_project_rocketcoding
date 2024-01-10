package com.rocket.psh.board.model.dto;

import java.sql.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
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
public class Fboard {
	
	private int fboardNo; //게시판 번호
	private int empNo;	  //게시글 작성자 
	private String fboardTitle;	// 게시글 제목
	private String fboardContent; //게시글 내용
	private int fboardViews;	//조회수
	private Date fboardDate;	//게시글 작성일
	private String fboard_Yn;// 삭제여뷰
	
	
}
