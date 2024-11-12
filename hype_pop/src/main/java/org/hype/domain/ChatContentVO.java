package org.hype.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ChatContentVO {
	private String code;		//상태코드
	private String bno;
	private String userNo;
	private String userId;		//보내는 사람
	private String content;		//대화 내용
	private Timestamp chatDate;		//날짜
	
	@Override
	public String toString() {
		return "Message [code=" + code + ", bno=" + bno + ", userNo" + userNo + ", userName=" + userId + ", content=" + content
				+ ", chatDate=" + chatDate + "]";
	}
}