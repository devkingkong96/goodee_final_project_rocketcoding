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
public class ChatRoom {
	
	private int chatRoomNo;
	private int empCount;
	private Date createdAt;
	private String chatRoomName;
	private String chDelChck;
	
}
