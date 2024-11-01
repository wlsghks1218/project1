package org.hype.service;

import java.util.List;

import org.hype.domain.cartVO;
import org.hype.domain.gImgVO;
import org.springframework.stereotype.Service;

@Service
public interface PurchaseService {

   
   //장바구니에 담기
   public int addToCart(cartVO cvo);
   
   //장바구니 페이지에 정보 불러오기
   public List<cartVO> getCartInfo(int userNo); 
}
