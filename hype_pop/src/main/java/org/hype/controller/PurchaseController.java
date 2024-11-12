package org.hype.controller;

import java.net.URL;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.hype.domain.cartVO;
import org.hype.domain.gImgVO;
import org.hype.domain.payVO;
import org.hype.domain.signInVO;
import org.hype.service.MemberService;
import org.hype.service.PurchaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {

   

      
   @Autowired
   private PurchaseService pservice;
   


      
   
    // 장바구니 페이지로 이동
    @GetMapping("/goCart")
    public String goCart(int userNo,  Model model) {
        log.info("장바구니로 이동,userNo :" + userNo);
   
        
       
        List<cartVO> cartInfo = pservice.getCartInfo(userNo); 
        
        //장바구니 굿즈 정보
        model.addAttribute("cartInfo", cartInfo);
      
        
        
        return "/purchase/myCart"; 
    }
    

    
    //결제자 정보 가져오기
    @GetMapping("/getPayInfo")
    public String getPayInfo(@RequestParam("userNo") int userNo, Model model) {
       log.info("결제 정보 불러오기.." + userNo);
       
       signInVO payInfo = pservice.getPayInfo(userNo);
       //int price = pservice.getPrice(userNo);
       //log.info("price...: " + price );
       
       model.addAttribute("getPayInfo", payInfo);
       //model.addAttribute("price", price);
       
       return "/purchase/payInfoPage"; 
       
       
    }
    
    
    
    //결제한 상품 목록 pay_list_tbl에 넣기
    @GetMapping("/addToPayList")
    public String addToPayList(cartVO cvo, Model model) {
       
       log.info("addToPayList.." + cvo);
       
       int addToPayList = pservice.addToPayList(cvo);
   
       
       model.addAttribute("addToPayList", addToPayList);
    
       
       return "/purchase/purchaseComplete"; 
       
       
    }
    
   
 
    
    
    // 내가 결제한 상품 목록 가기
    @GetMapping("/getPayList")
    public String getPaymentList(@RequestParam("userNo") int userNo, Model model) {
        log.info("getPaymentList...: " + userNo); 
        
        pservice.oneDayGbuyDate();
        
        pservice.threeDayGbuyDate();
        
        // 사용자 번호로 결제 목록 가져오기
        List<payVO> getPayList = pservice.getPayList(userNo);
        
        
        for(payVO pay:  getPayList) {
           int gno = pay.getGno();
           log.info("gnognogno..." + gno);      
           List<gImgVO> imgList = pservice.getPayListImg(gno);
           log.info("imgList..." + imgList);
           pay.setGimg(imgList);
        }
        
      
         model.addAttribute("getPayList", getPayList);

        return "/purchase/paymentList"; 
    }
    
    
    //결제 성공 축하 짝짝짝
    @GetMapping("/purchaseComplete")
    public String purchaseComplete() {
       return "/purchase/purchaseComplete";
    }
    
    
    
    
    
    
    // 결제 정보 입력 및 결제 처리
    @PostMapping("/processPurchase")
    public String processPurchase(@RequestParam("orderId") String orderId, 
                                  @RequestParam("paymentMethod") String paymentMethod, 
                                  @RequestParam("shippingAddress") String shippingAddress, 
                                  Model model) {
        log.info("결제 정보 처리 중: 주문 ID = " + orderId);

        // 주석: 결제 처리 로직 필요
        // boolean paymentSuccess = purchaseService.processPayment(orderId, paymentMethod, shippingAddress);
        
        // 주석: 결제 성공 여부에 따른 결과 페이지 반환
        // if (paymentSuccess) {   
        //     model.addAttribute("message", "결제가 성공적으로 완료되었습니다.");
        //     return "/purchase/purchaseSuccess"; // 결제 성공 페이지로 이동
        // } else {
        //     model.addAttribute("error", "결제 처리에 실패했습니다.");
           return "/purchase/goodsPurchase"; // 결제 실패 시 다시 결제 페이지로 이동
        // }
    }
}


    
