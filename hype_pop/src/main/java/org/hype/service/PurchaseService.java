package org.hype.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.hype.domain.cartVO;
import org.hype.domain.gImgVO;
import org.hype.domain.payVO;
import org.hype.domain.signInVO;
import org.springframework.stereotype.Service;

@Service
public interface PurchaseService {

   
   //�옣諛붽뎄�땲�뿉 �떞湲�
   public int addToCart(cartVO cvo);
   
   //�옣諛붽뎄�땲 �럹�씠吏��뿉 �젙蹂� 遺덈윭�삤湲�
   public List<cartVO> getCartInfo(int userNo); 
   
   //�옣諛붽뎄�땲�뿉 �씠誘� �엳�뒗 �긽�뭹�씤吏� �솗�씤
   public int alreadyInCart(@Param("userNo") int userNo, @Param("gno") int gno);
   
   //�긽�뭹 �궘�젣
   public int deleteItem(@Param("userNo") int userNo, @Param("gno") int gno);
   
   //�궗�슜�옄 寃곗젣 �젙蹂� 媛��졇�삤湲�
   public signInVO getPayInfo(@Param("userNo") int userNo);
   
   // 寃곗젣 媛�寃� 遺덈윭�삤湲�
   public int getPrice(@Param("userNo") int userNo);
      
   //援щℓ�븳 �긽�뭹�뱾 pay_list_tbl�뿉 �꽔湲�
   public int addToPayList(List<payVO> pvoList);
   
   //援щℓ 紐⑸줉 遺덈윭�삤湲� 
   public List<payVO> getPayList(int userNo, int offset, int pageSize);
   
   //援щℓ �씠誘몄� 紐⑸줉 遺덈윭�삤湲�
   public List<gImgVO> getPayListImg(int gno);
   
   //�궇吏� �뒪耳�伊대윭
   public int oneDayGbuyDate();

   public int threeDayGbuyDate(); 
   
   public int updateCartAmount(cartVO cvo);
   
   public int getTotalPages(int userNo, int pageSize);

   public int deleteCartItems(int gno, int userNo);
   

}
