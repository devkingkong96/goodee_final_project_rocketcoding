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
public class ChatMessage {
	
	private int messageId;
	private String message;
	private Date sendAt;
	private String readCheck;
	private int msgEmChNo; //중간테이블 fk키
	private int msgEmpNo; //회원테이블 fk키
	private int msgRoomNo; //채팅방 fk키
	
}
