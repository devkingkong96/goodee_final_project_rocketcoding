package com.rocket.ksj.chat.model.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class EmpChat {
	
	private int empNo;
	private int chatRoomId;
}
