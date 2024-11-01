package org.hype.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class psReplyVO {

	 public int psNo; // 팝업스토어 번호
	 public int userNo; // 회원번호
	 public String psComment; // 후기글
	 public int psScore; // 별점
	 public int psReplyNo; // 댓글 번호
	 public Date psRegDate; // 댓글 작성일
	 public Date psUpdateDate; // 댓글 수정일
	 public String userId;
}
