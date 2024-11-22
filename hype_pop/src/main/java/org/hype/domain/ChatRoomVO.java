package org.hype.domain;

import java.sql.Timestamp;

import lombok.Data;
@Data
public class ChatRoomVO {
   int bno, userNo;
   Timestamp joinTime, lastJoinTime, lastLeftTime;
}