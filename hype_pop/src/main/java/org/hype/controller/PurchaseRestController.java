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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.hype.domain.cartVO;
import org.hype.domain.gImgVO;
import org.hype.domain.payVO;
import org.hype.service.PurchaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
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

    // 아이템 삭제
    @DeleteMapping("deleteItem/{gno}")
    public ResponseEntity<String> deleteItem(@PathVariable int gno, @RequestParam int userNo) {
        log.info("Deleting item for userNo: " + userNo + ", gno: " + gno);

        purchaseService.deleteItem(userNo, gno);

        try {
            return ResponseEntity.ok("아이템이 성공적으로 삭제되었습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("아이템 삭제 중 오류가 발생했습니다.");
        }
    }

    // 장바구니에 추가
    @RequestMapping(value = "/addCart", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public ResponseEntity<String> addToCart(@RequestBody cartVO cvo) {

        int userNo = cvo.getUserNo();
        int gno = cvo.getGno();

        // 장바구니에 이미 추가된 상품인지 확인
        int alreadyInCart = purchaseService.alreadyInCart(userNo, gno);

        log.info("Adding to cart for userNo: " + userNo + ", gno: " + gno);

        if (alreadyInCart > 0) {
            return new ResponseEntity<>("이미 장바구니에 있는 상품입니다.", HttpStatus.OK);
        }
        purchaseService.addToCart(cvo);
        return new ResponseEntity<>("상품이 장바구니에 추가되었습니다.", HttpStatus.OK);
    }

    @PostMapping("/addToPayList")
    public ResponseEntity<String> addToPayList(@RequestBody List<payVO> pvoList) {
        log.info("addToPayList.. " + pvoList);

        try {
            // orderId를 UUID로 생성
            String orderId = UUID.randomUUID().toString();  // UUID로 고유한 orderId 생성
            for (payVO pvo : pvoList) {
                pvo.setOrderId(orderId);  // 생성된 orderId 설정
            }

            // 데이터베이스 저장
            purchaseService.addToPayList(pvoList);

            // 성공 메시지 반환
            String response = "{\"status\":\"success\", \"message\":\"결제 리스트에 추가되었습니다.\"}";
            return ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(response);

        } catch (Exception e) {
            log.error("서버 오류:", e);
            // 서버 오류 메시지 반환
            String errorResponse = "{\"status\":\"error\", \"message\":\"서버 오류 발생\"}";
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).contentType(MediaType.APPLICATION_JSON).body(errorResponse);
        }
    }

    // 장바구니 아이템 조회
    @GetMapping("/getCartItems")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getCartItems(@RequestParam int userNo) {
        try {
            // userNo로 장바구니 아이템 가져오기
            List<cartVO> cartItems = purchaseService.getCartInfo(userNo);
            log.info("Get cart info: " + cartItems);

            // JSON 형식으로 반환
            Map<String, Object> response = new HashMap<>();
            response.put("cartItems", cartItems);

            return ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON)
                    .body(response);
        } catch (Exception e) {
            log.error("장바구니 아이템 조회 중 오류 발생", e);
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("status", "error");
            errorResponse.put("message", "장바구니 아이템 조회 중 오류 발생");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(errorResponse);
        }
    }

    @PostMapping("/updateCartAmount")
    public ResponseEntity<String> updateCartAmount(@RequestBody List<cartVO> cartVOList) {
        try {
            // 각 cartVO 객체에 대해 수량 업데이트
            for (cartVO cvo : cartVOList) {
                purchaseService.updateCartAmount(cvo);
                log.info("cvo:" + cvo);
            }

            // 성공 응답 반환
            return ResponseEntity.status(HttpStatus.OK).body("수량이 성공적으로 업데이트되었습니다.");
        } catch (Exception e) {
            // 실패 응답 반환
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("수량 업데이트 실패: " + e.getMessage());
        }
    }

    @GetMapping("/loadMoreItems")
    public ResponseEntity<List<payVO>> loadMoreItems(@RequestParam("userNo") int userNo, @RequestParam("page") int page) {
        log.info("loadMoreItems...: " + userNo);
        
        int pageSize = 5; // 한 페이지 당 항목 수
        int offset = (page - 1) * pageSize; // 페이지에 대한 오프셋 계산

        // 데이터 가져오기
        List<payVO> getPayList = purchaseService.getPayList(userNo, offset, pageSize);
        
        for (payVO pay : getPayList) {
            int gno = pay.getGno();
            log.info("gnognogno..." + gno);    
            List<gImgVO> imgList = purchaseService.getPayListImg(gno);
            log.info("imgList..." + imgList);
            pay.setGimg(imgList);
        }

        return ResponseEntity.ok()
                .contentType(MediaType.APPLICATION_JSON)
                .body(getPayList);
    }

    @DeleteMapping("/deleteCartItems/{gno}/{userNo}")
    public ResponseEntity<?> deleteCartItems(@PathVariable int gno, @PathVariable int userNo) {
        log.info("deletecartItems...:" + gno + userNo);

        try {
            // 장바구니에서 상품 삭제
            purchaseService.deleteCartItems(gno, userNo);
            return ResponseEntity.status(HttpStatus.OK).body("장바구니 아이템이 성공적으로 삭제되었습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("장바구니 아이템 삭제 실패");
        }
    }
}
