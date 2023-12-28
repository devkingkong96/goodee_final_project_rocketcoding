package com.rocket.psh.board.model.dto;

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
public class FboardFile {
	
	private int fboardFileNo;
	private Fboard fboardNo;
	private String fboardFileOri;
	private String fboardFileRe;
}
