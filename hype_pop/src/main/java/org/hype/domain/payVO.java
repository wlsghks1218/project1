package org.hype.domain;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class payVO {
   
   private  int userNo; // 구매 번호
   private  int gno; // 상품 번호
   private  int camount; // 구매 개수
   private  Timestamp gbuyDate; // 구매일자
   private  String gsituation; // 상품 현황
   private  String gname;
   private  int gprice;
   private  List<gImgVO> gimg; 
}
