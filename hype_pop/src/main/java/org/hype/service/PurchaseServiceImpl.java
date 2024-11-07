package org.hype.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.hype.domain.cartVO;
import org.hype.domain.gImgVO;
import org.hype.domain.payVO;
import org.hype.domain.signInVO;
import org.hype.mapper.GoodsMapper;
import org.hype.mapper.PurchaseMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
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
   
   //장바구니에 이미 있는 상품인지 확인
   @Override
   public int alreadyInCart(int userNo, int gno) {
      
       log.info("Adding to cart for userNo: " + userNo + ", gno: " + gno);

      return pmapper.alreadyInCart(userNo, gno);
   }
   
   @Override
   public int deleteItem(int userNo, int gno) {
       log.info("Adding to cart for userNo: " + userNo + ", gno: " + gno);
       
       return pmapper.deleteItem(userNo, gno);
   }
   
   
    //사용자 결제 정보 가져오기(상품 가격 가져오기)
    @Override
    public signInVO getPayInfo(int userNo) {
       System.out.println("userNo: " + userNo); 
    
       
       //결제자 정보 불러오기
       return pmapper.getPayInfo(userNo);
             
    }
    
    
   @Override
   public int getPrice(int userNo) {
       
      System.out.println("userNo: " + userNo); 
   
       
       return pmapper.getPrice(userNo);
   }
   
   @Override
   public int addToPayList(cartVO cvo) {
      System.out.println("cartVO: " + cvo); 
   
      return pmapper.addToPayList(cvo);
   }
   
   

   @Override
   @Scheduled(cron = "0 0 * * * ?") 
   public int oneDayGbuyDate() {
      
      System.out.println("oneDayGsituation..service");
      
      pmapper.oneDayGsituation();
      
      return pmapper.threeDayGsituation();

   }
   
   @Override
   @Scheduled(cron = "0 0 * * * ?") 
   public int threeDayGbuyDate() {
      
      System.out.println("threeDayGsituation..service");
       
       return pmapper.threeDayGsituation();

   }
   
   
   

   @Override
   public List<payVO> getPayList(@Param("userNo") int userNo) {
       System.out.println("userNo: " + userNo);
      

       return pmapper.getPayList(userNo); 

       }
      
      
   @Override
   public List<gImgVO> getPayListImg(int gno){
      
      System.out.println("getPayList..gno : " + gno);
   
      return pmapper.getPayListImg(gno);
   }
    
          
          
       
         


}
