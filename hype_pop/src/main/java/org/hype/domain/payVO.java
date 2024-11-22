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
	   private  int userNo; // 援щℓ 踰덊샇
	   private  int gno; //  긽 뭹 踰덊샇
	   private  int camount; // 援щℓ 媛쒖닔
	   private  Timestamp gbuyDate; // 援щℓ 씪 옄
	   private  String gsituation; //  긽 뭹  쁽 솴
	   private  String gname;
	   private  int gprice;
	   private  List<gImgVO> gimg; 
	   public String iamUid;
	   public String orderId;

	   
	   
}
