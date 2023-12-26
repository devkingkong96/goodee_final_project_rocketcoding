package com.rocket.pdw.aprv.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Document {
	private int docNo;
	private int docTag;
	private String docTitle;
	private String docContent;
	private String docStatcd;
	private	Date uDate;
	private int empNo;
	private Date startDate;
	private Date endDate;
	
	
}
