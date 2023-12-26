package com.rocket.pdw.aprv.model.dto;



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
	private String aprvOriname;
	private String aprvRenamed;
	private int docNo;
	
}
