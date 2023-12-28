package com.rocket.ksj.chat.model.dto;

import java.sql.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ChatRoom {
	private int chatRoomId;
	private String chatRoomName;
	private int empCount;
	private Date createdAt;
	private String status;
	
	List<EmpChat> empChat;
}
