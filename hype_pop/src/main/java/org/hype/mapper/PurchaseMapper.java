package org.hype.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.hype.domain.cartVO;
import org.hype.domain.gImgVO;
import org.hype.domain.payVO;
import org.hype.domain.signInVO;

public interface PurchaseMapper {
   
   //장바구니에 추가하기
   public int addToCart(cartVO cvo);

   //장바구니 사용자 정보 가져오기
   public  List<cartVO> getCartInfo(int userNo);
   
   //장바구니 사진 가져오기
   public List<gImgVO> getMyCartImg(int gno);
   
   //장바구니에 이미 있는 상품인지 확인
   public  int alreadyInCart(@Param("userNo") int userNo, @Param("gno") int gno);
   
   //상품 삭제 
   public int deleteItem(@Param("userNo") int userNo, @Param("gno") int gno);
   
   //사용자 결제 정보 가져오기
   public signInVO getPayInfo(@Param("userNo") int userNo);
   
   //사용자 결제 가격 불러오기
   public int getPrice(@Param("userNo") int userNo);
   
   //구매한 상품들 pay_list_tbl에 넣기
   public int addToPayList(cartVO cvo);
   
   //구매 목록 불러오기 
   public List<payVO> getPayList(@Param("userNo") int userNo);
   
   //구매 목록 사진 가져오기
   public List<gImgVO> getPayListImg(int gno);
   
   //1일 지난 상품
   public int oneDayGsituation();
   
   //3일 지난 상품
   public int threeDayGsituation();
}
