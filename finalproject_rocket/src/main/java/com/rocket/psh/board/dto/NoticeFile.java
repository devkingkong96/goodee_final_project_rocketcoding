package com.rocket.psh.board.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class NoticeFile {
	private int noticeFileNo;
	private Notice noticeNo;
	private String noticeFileOri;
	private String noticeFileRe;
}
