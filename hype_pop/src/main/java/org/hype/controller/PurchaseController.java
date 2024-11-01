
package org.hype.controller;

import java.util.List;
import java.util.Map;

import org.hype.domain.cartVO;
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
   
   //장바구니에 아이템 추가
    @RequestMapping(value ="/addCart", produces = "application/json; charset=UTF-8")
   @ResponseBody
   public ResponseEntity<String> addToCart(@RequestBody cartVO cvo) {
       
       
              pservice.addToCart(cvo);
              return new ResponseEntity<>("상품이 장바구니에 추가되었습니다.", HttpStatus.OK);
          }
    

      
   
    // 장바구니 페이지로 이동
    @GetMapping("/goCart")
    public String goCart(int userNo,  Model model) {
        log.info("장바구니로 이동,userNo :" + userNo);
   
        
       
        List<cartVO> cartInfo = pservice.getCartInfo(userNo); 
        
        //장바구니 굿즈 정보
        model.addAttribute("cartInfo", cartInfo);
      
        
        
        return "/purchase/myCart"; 
    }

    // 결제 정보 입력 페이지로 이동
    @GetMapping("/goPurchase")
    public String goPurchase(@RequestParam("orderId") String orderId, Model model) {
        log.info("결제 정보 입력창으로 이동");

        // 주석: orderId에 해당하는 주문 정보 가져오기
        // Order order = purchaseService.getOrderDetails(orderId);
        // model.addAttribute("order", order);
        
        return "/purchase/goodsPurchase"; 
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

    // 구매한 목록 가져오기
    @GetMapping("/purchaseHistory")
    public String getPurchaseHistory(Model model) {
        log.info("구매한 목록을 가져옵니다.");

        // 주석: 사용자의 구매 내역을 DB에서 가져오는 로직 필요
        // List<Purchase> purchaseHistory = purchaseService.getPurchaseHistory(userId);
        // model.addAttribute("purchaseHistory", purchaseHistory);

        return "/purchase/purchaseHistory"; // 구매 내역을 보여줄 JSP 페이지
    }
}
