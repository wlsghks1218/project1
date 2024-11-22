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
public class gReplyVO {
	private int greplyNo, gno, userNo, gscore;
	private Date gregDate, gupdateDate;
	private String gcomment, userId, gname;;
}
	