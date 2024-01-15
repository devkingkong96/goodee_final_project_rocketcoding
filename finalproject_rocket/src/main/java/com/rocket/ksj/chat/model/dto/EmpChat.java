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
	
	private int empChatNo; //중간테이블 pk값
	private int emChEmpNo; //직원테이블 fk값
	private int emChRoomNo;//채팅방 fk값
	private String chBookMark;//북마크 Y/N
	private String emChDelChck;//삭제여부
}
