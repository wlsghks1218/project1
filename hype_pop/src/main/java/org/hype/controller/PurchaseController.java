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
   


      
   
    // �옣諛붽뎄�땲 �럹�씠吏�濡� �씠�룞
    @GetMapping("/goCart")
    public String goCart(int userNo,  Model model) {
        log.info("�옣諛붽뎄�땲濡� �씠�룞,userNo :" + userNo);
   
        
       
        List<cartVO> cartInfo = pservice.getCartInfo(userNo); 
        
        //�옣諛붽뎄�땲 援우쫰 �젙蹂�
        model.addAttribute("cartInfo", cartInfo);
      
        
        
        return "/purchase/myCart"; 
    }
    

    
    //寃곗젣�옄 �젙蹂� 媛��졇�삤湲�
    @GetMapping("/getPayInfo")
    public String getPayInfo(@RequestParam("userNo") int userNo, Model model) {
       log.info("寃곗젣 �젙蹂� 遺덈윭�삤湲�.." + userNo);
       
       signInVO payInfo = pservice.getPayInfo(userNo);
       //int price = pservice.getPrice(userNo);
       //log.info("price...: " + price );
       
       model.addAttribute("getPayInfo", payInfo);
       //model.addAttribute("price", price);
       
       return "/purchase/payInfoPage"; 
       
       
    }
    
    
    
//    //寃곗젣�븳 �긽�뭹 紐⑸줉 pay_list_tbl�뿉 �꽔湲�
//    @GetMapping("/addToPayList")
//    public String addToPayList(cartVO cvo, Model model) {
//       
//       log.info("addToPayList.." + cvo);
//       
//       int addToPayList = pservice.addToPayList(cvo);
//   
//       
//       model.addAttribute("addToPayList", addToPayList);
//    
//       
//       return "/purchase/purchaseComplete"; 
//       
//       
//    }
    
   
 
    
    
    // �궡媛� 寃곗젣�븳 �긽�뭹 紐⑸줉 媛�湲�
    @GetMapping("/getPayList")
    public String getPaymentList(@RequestParam("userNo") int userNo, @RequestParam(value = "page", defaultValue = "1") int page, Model model) {
        log.info("getPaymentList...: " + userNo); 
        
        pservice.oneDayGbuyDate();
        pservice.threeDayGbuyDate();
        
        int pageSize = 5; // 한 번에 불러올 항목 수
        int offset = (page - 1) * pageSize; // 페이지 시작 위치
        
        // 페이지네이션을 위한 데이터 가져오기
        List<payVO> getPayList = pservice.getPayList(userNo, offset, pageSize);
        
        for(payVO pay : getPayList) {
            int gno = pay.getGno();
            log.info("gnognogno..." + gno);    
            List<gImgVO> imgList = pservice.getPayListImg(gno);
            log.info("imgList..." + imgList);
            pay.setGimg(imgList);
            String orderId = pay.getOrderId();
            log.info(orderId);
        }

        model.addAttribute("getPayList", getPayList);
        model.addAttribute("currentPage", page); // 현재 페이지 정보
        model.addAttribute("totalPages", pservice.getTotalPages(userNo, pageSize)); // 전체 페이지 수 계산

        return "/purchase/paymentList"; 
    }

    
    
    //寃곗젣 �꽦怨� 異뺥븯 吏앹쭩吏�
    @GetMapping("/purchaseComplete")
    public String purchaseComplete() {
       return "/purchase/purchaseComplete";
    }
    
    
    
    
    
    
    // 寃곗젣 �젙蹂� �엯�젰 諛� 寃곗젣 泥섎━
    @PostMapping("/processPurchase")
    public String processPurchase(@RequestParam("orderId") String orderId, 
                                  @RequestParam("paymentMethod") String paymentMethod, 
                                  @RequestParam("shippingAddress") String shippingAddress, 
                                  Model model) {
        log.info("寃곗젣 �젙蹂� 泥섎━ 以�: 二쇰Ц ID = " + orderId);

        // 二쇱꽍: 寃곗젣 泥섎━ 濡쒖쭅 �븘�슂
        // boolean paymentSuccess = purchaseService.processPayment(orderId, paymentMethod, shippingAddress);
        
        // 二쇱꽍: 寃곗젣 �꽦怨� �뿬遺��뿉 �뵲瑜� 寃곌낵 �럹�씠吏� 諛섑솚
        // if (paymentSuccess) {   
        //     model.addAttribute("message", "寃곗젣媛� �꽦怨듭쟻�쑝濡� �셿猷뚮릺�뿀�뒿�땲�떎.");
        //     return "/purchase/purchaseSuccess"; // 寃곗젣 �꽦怨� �럹�씠吏�濡� �씠�룞
        // } else {
        //     model.addAttribute("error", "寃곗젣 泥섎━�뿉 �떎�뙣�뻽�뒿�땲�떎.");
           return "/purchase/goodsPurchase"; // 寃곗젣 �떎�뙣 �떆 �떎�떆 寃곗젣 �럹�씠吏�濡� �씠�룞
        // }
    }
    
    @GetMapping("/payInfoPage")
    public String payInfoPage(@RequestParam("grandTotal") int grandTotal, @RequestParam("userNo") int userNo, Model model) {
        // 전달받은 grandTotal 값을 모델에 추가
        model.addAttribute("grandTotal", grandTotal);
        signInVO payInfo = pservice.getPayInfo(userNo);
        model.addAttribute("getPayInfo", payInfo);

        // 결제 정보 페이지로 이동
        return "/purchase/payInfoPage";
    }
}


    
