package org.hype.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class cartVO {
	   public int gno; // 상품 번호
	   public int userNo; // 회원 번호
	   public int camount; // 개수
	   public int cprice; // 총가격
	   public int gprice; // 상품 가격
	   public String gname; // 상품명
	   public List<gImgVO> gimg; // 상품 사진 
	   public String iamUid;
	
}
