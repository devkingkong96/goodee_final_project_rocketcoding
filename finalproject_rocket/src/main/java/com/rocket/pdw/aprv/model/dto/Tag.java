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
@JsonIdentityInfo (
   generator = ObjectIdGenerators.IntSequenceGenerator.class)
public class Tag {
	
	private long docTag;
	private String tagName;
	private String tagCont;
	
	private Document docNo;
}