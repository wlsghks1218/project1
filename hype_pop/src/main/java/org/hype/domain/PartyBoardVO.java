package org.hype.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class PartyBoardVO {
	int bno, userNo;
	String boardTitle, category, targetName;
	Date regDate;
}
