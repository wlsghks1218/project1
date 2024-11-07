package org.hype.domain;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class signInVO {
   
   private String userId; //  븘 씠 뵒
   private String userPw; // 鍮꾨 踰덊샇
   private String userEmail; //  씠硫붿씪
   private String userName; //  씠由 
   private String userNumber; //  쟾 솕踰덊샇
   private mCatVO userInterest; // 愿  떖 궗
   
   private int userNo; //  쉶 썝 踰덊샇
   private Date regDate; // 媛  엯 씪
   private Date lastLoginDate; // 留덉 留  濡쒓렇 씤  궇吏 
   private boolean enabled; // 怨꾩젙  솢 꽦 솕  뿬遺 
   private int auth; // 沅뚰븳
   private List<popStoreVO> gLikeList; // 援우쫰 醫뗭븘 슂 紐⑸줉
   private List<goodsVO> pLikeList; //  뒪 넗 뼱 醫뗭븘 슂 紐⑸줉
   private String snsToken; // Access Token
   private String snsType; // sns 醫낅쪟
}