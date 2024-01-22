package com.rocket.psh.board.model.dto;

import java.sql.Date;

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
public class FboardComment {
	
	private int commentNo; //댓글번호
	private int fboardNo;//게시글 번호
	private Employee writer; //댓글 작성자
	private String fbdComment; //댓글
	private Date fbdCommentDate; //댓글 작성일
	private String FBD_COMMENT_YN;//댓글 삭제여부
	
	
}
