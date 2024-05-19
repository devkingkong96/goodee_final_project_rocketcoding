package com.rocket.seoj.logistics.model.dto;

import java.util.List;

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
public class Publisher {
	
	private long pubId;
	private String pubName;
	private String pubAddr;
	private int pubPhone;
	private String pubIsdel;
	private String pubRepresentative;
	private String pubBank;
	
}
