package org.hype.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class PartyBoardVO {
	int bno, userNo, currentUser, maxUser;
	String boardTitle, category, targetName;
	Date regDate;
}