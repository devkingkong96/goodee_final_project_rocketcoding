package com.rocket.pdw.aprv.model.dto;

import java.sql.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import com.rocket.jsy.employee.model.dto.Employee;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@JsonIdentityInfo (
   generator = ObjectIdGenerators.IntSequenceGenerator.class)
public class Document {
	
	private long docNo;
	
	private Tag docTag; // 외래 키 DOC_TAG에 해당하는 Tag 타입의 참조
	
	private String docTitle;
	private String docCont;
	private int docStatcd;
	private Date uDate;
	
	private Employee empNo; // 외래 키 EMP_NO에 해당하는 Employee 타입의 참조
	
	private Date startDate;
	private Date endDate;
	
	/* private ApprovalFile approvalFile;*/
	
	List<Approval> approvalList;
	/*    private Inventory inventory;*/
}
