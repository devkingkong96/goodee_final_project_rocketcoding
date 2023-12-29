package com.rocket.seoj.logistics.model.dto;

import java.util.List;

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
public class Publisher {
	
	private long pubId;
	private String pubName;
	private String pubAddr;
	private int pubPhone;
	private String pubIsdel;
	private String pubRepresentative;
	private String pubBank;
	
	private List<Product> productList;
}
