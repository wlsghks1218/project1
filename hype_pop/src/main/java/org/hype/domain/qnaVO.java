package org.hype.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class qnaVO {
   
   private int qnaNo; // 문의 번호
   private int userNo; // 회원 번호
   private String qnaType; // 문의 유형
   private String qnaTitle; //  문의 제목
   private String qnaContext; //  문의 내용
   private Date qnaRegDate; //  문의 날짜
   private String qnaAnswer; //  문의 답변
   
   private Boolean answerStatus; // 답변 상태 추가
}