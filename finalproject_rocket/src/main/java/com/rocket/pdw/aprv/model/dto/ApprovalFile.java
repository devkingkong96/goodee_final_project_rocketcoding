package com.rocket.pdw.aprv.model.dto;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ApprovalFile {
	
	private int aprvFileNo;
	private String aprvOriName;
	private String aprvReNamed;
	
	private int docNo;
}
