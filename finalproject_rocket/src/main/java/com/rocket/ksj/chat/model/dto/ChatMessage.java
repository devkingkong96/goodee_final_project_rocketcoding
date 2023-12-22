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
	private String messageId;
	private String chatRoomId;
	private int empNo;
	private String messageType;
	private String message;
	private Date sendAt;
	private String readCheck;
}
