package com.rocket.seoj.logistics.model.dto;

import java.sql.Date;

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
@JsonIdentityInfo (
   generator = ObjectIdGenerators.IntSequenceGenerator.class)
public class InventoryAttach {
	
	private long ivFileId;
	private String ivFileNameOri;
	private String ivFileNameRe;
	private Date ivUploadDate;
	private String ivAttachIsdel;
	
	private Inventory ivId;
}
