package com.rocket.ksj.chat.model.dto;

import java.util.Date;

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
	private int msgEmpNo; //회원테이블 fk키
	private int msgRoomNo; //채팅방 fk키
	private String msgEmpName; //회원테이블 직원이름
	private String msgFiOriName; //수정 전 파일명
	private String msgFiReName; //수정 전 파일명
	private String msgDelChck; //삭제여부
	private String type; // ENTER,UPFILE,TALK
}
