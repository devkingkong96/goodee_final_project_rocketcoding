package com.rocket.ksj.chat.model.dto;

import com.rocket.jsy.employee.model.dto.Employee;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class EmpChat {
	private Employee empNo;
	private ChatRoom chatRoomId;
}
