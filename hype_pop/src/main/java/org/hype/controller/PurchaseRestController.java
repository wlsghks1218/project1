package org.hype.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import org.hype.domain.cartVO;
import org.hype.service.PurchaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.log4j.Log4j;

@Log4j
@RestController
@RequestMapping("/purchase/api")
public class PurchaseRestController {
      
   @Autowired
   private PurchaseService purchaseService;
   
    //상품 삭제
    @DeleteMapping("deleteItem/{gno}")
    public ResponseEntity<String> deleteItem(@PathVariable int gno, @RequestParam int userNo) {
        log.info("Deleting item for userNo: " + userNo + ", gno: " + gno);
        
        purchaseService.deleteItem(userNo, gno);

       try {
            return ResponseEntity.ok("상품이 성공적으로 삭제되었습니다.");
        }catch (Exception e) {
            return ResponseEntity.status(500).body("상품 삭제에 실패하였습니다."); // 오류 발생 시 메시지 반환
        }
   
    
    }
    //장바구니에 아이템 추가
    @RequestMapping(value ="/addCart", produces = "application/json; charset=UTF-8")
   @ResponseBody
   public ResponseEntity<String> addToCart(@RequestBody cartVO cvo ) {
       
       int userNo = cvo.getUserNo();
       int gno = cvo.getGno();

        //이미 장바구니에 있는 경우
       int alreadyInCart = purchaseService.alreadyInCart(userNo, gno);
       
       
        log.info("Adding to cart for userNo: " + userNo + ", gno: " + gno);

   
      if (alreadyInCart > 0) {
           return new ResponseEntity<>("이 상품은 이미 장바구니에 담겨 있습니다.", HttpStatus.OK); // 또는 HttpStatus.INTERNAL_SERVER_ERROR 등을 사용할 수 있음
       }
      purchaseService.addToCart(cvo);
        return new ResponseEntity<>("	상품이 장바구니에 추가되었습니다.", HttpStatus.OK);
    }
    
    
    
  
    
    
//카카오페이 테스트 결제
   
//    @RequestMapping("/kakaopay.cls")
//    @ResponseBody
//    public String kakaopay() {
//        try {
//           URL kakaourl = new URL("https://kapi.kakao.com/v1/payment/ready");
//            HttpURLConnection serverConnection = (HttpURLConnection) kakaourl.openConnection();
//            serverConnection.setRequestMethod("POST");
//            
//            // Authorization 헤더 설정
//           // String secretKey = "DEV9B22ACB3F992D27DBDEAB6CCD5D7083971533"; 
//            serverConnection.setRequestProperty("Authorization", "SECRET_KEY DEV9B22ACB3F992D27DBDEAB6CCD5D7083971533" ); // "SECRET_KEY" 수정
//            serverConnection.setRequestProperty("Content-Type", "application/json");
//            serverConnection.setDoOutput(true);
//
//            // JSON 형식의 요청 본문
//            //String jsonRequest = "{\"cid\":\"TC0ONETIME\",\"partner_order_id\":\"partner_order_id\",\"partner_user_id\":\"partner_user_id\",\"item_name\":\"초코파이\",\"quantity\":1,\"total_amount\":2200,\"tax_free_amount\":0,\"approval_url\":\"https://developers.kakao.com/success\",\"cancel_url\":\"https://developers.kakao.com/cancel\",\"fail_url\":\"https://developers.kakao.com/fail\"}";
//
//           String parameter = 
//               "cid=TC0ONETIME&"
//               + "partner_order_id=partner_order_id&"
//               + "partner_user_id=partner_user_id&"
//               + "item_name=초코파이&"
//               + "quantity=1&"
//               + "total_amount=2200&"
//               + "tax_free_amount=0&"
//               + "approval_url=http://localhost:8181/kakaopayTest/success.cls&"
//               + "fail_url=http://localhost:8181/kakaopayTest/fail.cls&"
//               + "cancel_url=http://localhost:8181/kakaopayTest/cancel.cls";
//            
//            
//               // 요청 본문 작성
//              OutputStream os = serverConnection.getOutputStream();
//                DataOutputStream givedata = new DataOutputStream(os);
//                givedata.writeBytes(parameter);
//                givedata.flush();
//                givedata.close();
//            
//
//            int result = serverConnection.getResponseCode();
//            
//            InputStream getdata;
//            if(result == 200) {
//               getdata =serverConnection.getInputStream();
//         }else {
//            getdata = serverConnection.getErrorStream();
//         }
//
//            InputStreamReader inputStreamReader = new InputStreamReader(getdata);
//         BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
//         return bufferedReader.readLine();
//      } catch (MalformedURLException e) {
//         e.printStackTrace();
//      } catch (IOException e) {
//         e.printStackTrace();
//      }
//       return "[\result\":\" NO\"]";
//    }
    
    

}
