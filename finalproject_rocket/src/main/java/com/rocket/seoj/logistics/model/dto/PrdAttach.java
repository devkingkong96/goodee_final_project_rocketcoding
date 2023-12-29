package com.rocket.seoj.logistics.model.dto;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Brief description of functions
 *
 * @author J
 * @version 2023-12-23
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PrdAttach {
	
	private long prdFileId;
	private String prdFileNameOri;
	private String prdFileNameRe;
	private Date prdFileUploadDate;
	private String prdAttachIsdel;
	
	private long prdId;
	
}
