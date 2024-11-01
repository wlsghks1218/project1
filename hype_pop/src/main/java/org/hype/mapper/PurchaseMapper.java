package org.hype.mapper;

import java.util.List;

import org.hype.domain.cartVO;
import org.hype.domain.gImgVO;

public interface PurchaseMapper {
   
   public int addToCart(cartVO cvo);

   public  List<cartVO> getCartInfo(int userNo);
   
   public List<gImgVO> getMyCartImg(int gno);

   
   
   
}
