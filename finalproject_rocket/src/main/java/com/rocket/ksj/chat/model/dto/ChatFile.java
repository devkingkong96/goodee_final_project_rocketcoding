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
	private int messageId;
	private String originFileName;
	private String renamedFileName;
	private Date uploadAt;
}
