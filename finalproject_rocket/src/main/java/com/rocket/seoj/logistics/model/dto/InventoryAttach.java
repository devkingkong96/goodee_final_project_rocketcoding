package com.rocket.seoj.logistics.model.dto;

import java.sql.Date;

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
public class InventoryAttach {
	
	private long ivFileId;
	private String ivFileNameOri;
	private String ivFileNameRe;
	private Date ivUploadDate;
	private String ivAttachIsdel;
	
	private long ivId;
}
