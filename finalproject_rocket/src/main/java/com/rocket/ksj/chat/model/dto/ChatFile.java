package com.rocket.ksj.chat.model.dto;

import java.sql.Date;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ChatFile {
	
	private int fileNo;
	private String originFileName;
	private String renamedFileName;
	private Date uploadAt;
	private int chFiRoomNo; //채팅방 테이블 fk키
	private int chFiEmpNo; //직원 테이블 fk키
	
}
