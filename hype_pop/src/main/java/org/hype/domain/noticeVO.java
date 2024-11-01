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
public class noticeVO {

   private int noticeNo; // 공지사항 번호
   private String noticeTitle; // 공지사항 제목
   private Date noticeRegDate; // 공지 사항 작성 일자
   private String noticeContent; // 공지 내용
}