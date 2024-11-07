package org.hype.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class exhReplyVO {
	private int exhNo, userNo, exhScore, exhReplyNo;
	private String exhComment;
	private Date exhRegDate, exhUpdateDate;
}