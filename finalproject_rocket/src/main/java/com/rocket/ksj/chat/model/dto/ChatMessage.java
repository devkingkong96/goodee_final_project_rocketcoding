package com.rocket.ksj.chat.model.dto;

import java.sql.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import com.rocket.jsy.employee.model.dto.Employee;

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
	private ChatRoom chatRoomId;
	private Employee empNo;
	private String messageType;
	private String message;
	private Date sendAt;
	private String readCheck;
	
	private List<ChatFile> files;
}
