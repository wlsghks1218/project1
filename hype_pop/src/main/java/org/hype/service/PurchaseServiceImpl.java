package org.hype.service;

import java.util.List;

import org.hype.domain.cartVO;
import org.hype.domain.gImgVO;
import org.hype.mapper.PurchaseMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class PurchaseServiceImpl implements PurchaseService {

   @Autowired
   private PurchaseMapper pmapper;

   @Override
   public int addToCart(cartVO cvo) {
      log.info("cartVO cvo:" + cvo);
      return pmapper.addToCart(cvo);
   }

   // 장바구니 페이지에 정보 가져오기
   @Transactional
   @Override
   public List<cartVO> getCartInfo(int userNo) {
       log.info("userNo: " + userNo);

       // 굿즈 정보 가져오기
       List<cartVO> cartInfoList = pmapper.getCartInfo(userNo);

       // 장바구니 정보 출력 및 이미지 설정
       for (cartVO cartInfo : cartInfoList) {
           System.out.println(cartInfo);
           
           // 각 cartInfo에 대해 이미지를 가져오기
           List<gImgVO> imgList = pmapper.getMyCartImg(cartInfo.getGno());
           
           // 가져온 이미지 리스트를 cartVO에 설정
           cartInfo.setGimg(imgList);
       }

       return cartInfoList; // 장바구니 정보 리스트 반환
   }

}
