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
public class likedExhViewVO {

   
   
    private int userNo; // 회원번호
    private int exhNo; // 전시회번호
    private Date likeDate; // 좋아요 날짜
    private String uuid; // uuid
    private String uploadPath; // 업로드 경로
    private String fileName; // 파일 이름
    private String exhName;   // 전시회 이름
}
