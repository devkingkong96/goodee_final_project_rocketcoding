package com.rocket.seoj.logistics.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

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
