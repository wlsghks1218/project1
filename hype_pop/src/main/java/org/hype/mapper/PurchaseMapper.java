package org.hype.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.hype.domain.cartVO;
import org.hype.domain.gImgVO;
import org.hype.domain.payVO;
import org.hype.domain.signInVO;

public interface PurchaseMapper {
   
   //�옣諛붽뎄�땲�뿉 異붽��븯湲�
   public int addToCart(cartVO cvo);

   //�옣諛붽뎄�땲 �궗�슜�옄 �젙蹂� 媛��졇�삤湲�
   public  List<cartVO> getCartInfo(int userNo);
   
   //�옣諛붽뎄�땲 �궗吏� 媛��졇�삤湲�
   public List<gImgVO> getMyCartImg(int gno);
   
   //�옣諛붽뎄�땲�뿉 �씠誘� �엳�뒗 �긽�뭹�씤吏� �솗�씤
   public  int alreadyInCart(@Param("userNo") int userNo, @Param("gno") int gno);
   
   //�긽�뭹 �궘�젣 
   public int deleteItem(@Param("userNo") int userNo, @Param("gno") int gno);
   
   //�궗�슜�옄 寃곗젣 �젙蹂� 媛��졇�삤湲�
   public signInVO getPayInfo(@Param("userNo") int userNo);
   
   //�궗�슜�옄 寃곗젣 媛�寃� 遺덈윭�삤湲�
   public int getPrice(@Param("userNo") int userNo);
   
   //援щℓ�븳 �긽�뭹�뱾 pay_list_tbl�뿉 �꽔湲�
   //public int addToPayList(List<payVO> pvoList);
   public int addToPayList(payVO pvo);
   
   //援щℓ 紐⑸줉 遺덈윭�삤湲� 
   //public List<payVO> getPayList(@Param("userNo") int userNo);
   
   //援щℓ 紐⑸줉 �궗吏� 媛��졇�삤湲�
   public List<gImgVO> getPayListImg(int gno);
   
   //1�씪 吏��궃 �긽�뭹
   public int oneDayGsituation();
   
   //3�씪 吏��궃 �긽�뭹
   public int threeDayGsituation();
   
   public int updateCartAmount(cartVO cvo);
   
   public List<payVO> getPayList(@Param("userNo") int userNo, @Param("offset") int offset, @Param("pageSize") int pageSize);

   public int getTotalItems(int userNo);
   
   public int deleteCartItems(@Param("gno") int gno, @Param("userNo") int userNo);

}
