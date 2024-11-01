package org.hype.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hype.domain.goodsVO;
import org.hype.domain.likeVO;
import org.hype.domain.mCatVO;
import org.hype.domain.pCatVO;
import org.hype.domain.popStoreVO;
import org.hype.domain.psReplyVO;
import org.hype.service.PopUpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
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
@RequestMapping("/hypePop")
public class PopUpController {
	@Autowired
	PopUpService service;
	

	@GetMapping("/search") // URL 매핑에 해당하는 메서드
	public String search(@RequestParam("searchData") String searchData, Model model) {
	    // searchData를 받아 검색 결과를 처리
	    System.out.println("검색 데이터: " + searchData);
	    
	    // DB에서 검색 결과를 가져오는 로직 작성
	    List<popStoreVO> vo = service.popUpSearchByData(searchData);
	   
	    for (popStoreVO store : vo) {
	     
	        
	        // 각 스토어의 관심사 조회
	        List<Map<String, Object>> interestsList = service.getInterestsByPsNo(store.getPsNo());

	        // 관심사를 문자열로 변환
	        StringBuilder interestsBuilder = new StringBuilder();
	        for (Map<String, Object> interest : interestsList) {
	            if (interestsBuilder.length() > 0) {
	                interestsBuilder.append(", "); // 콤마로 구분
	            }
	            log.info("관심사 : " + interestsBuilder);
	            interestsBuilder.append(interest.get("INTERESTS"));
	        }
	        store.setInterest(interestsBuilder.toString());
	        
	        //평균 별점 계산
	        double averageRating = service.calculateAverageRating(store.getPsNo());
	        store.setAvgRating(averageRating); // 평균 평점 설정

	        System.out.println("관심사: " + store.getInterest());
	        System.out.println("------------------------------");
	    }
	    
	    // searchData를 JSP에 전달
	    model.addAttribute("searchData", vo);	
	    
	    return "/popUp/searchResultPage"; // 검색 결과를 보여주는 JSP 경로
	}
    // 검색 결과가 없는 경우를 처리하는 메서드
    @GetMapping("/search/noData") // 특정 URL 매핑
    public String searchWithoutData(Model model) {
    	
    	 List<popStoreVO> vo = service.getAllPopUpData();
    	
    	  for (popStoreVO store : vo) {
  	        System.out.println("스토어 번호: " + store.getPsNo());
  	        System.out.println("스토어 이름: " + store.getPsName());
  	        System.out.println("주소: " + store.getPsAddress());
  	        System.out.println("설명: " + store.getPsExp());
  	        System.out.println("좋아요 수: " + store.getLikeCount());
  	        System.out.println("평균 별점: " + store.getAvgRating());
  	        
  	        // 각 스토어의 관심사 조회
  	        List<Map<String, Object>> interestsList = service.getInterestsByPsNo(store.getPsNo());

  	        // 관심사를 문자열로 변환
  	        StringBuilder interestsBuilder = new StringBuilder();
  	        for (Map<String, Object> interest : interestsList) {
  	            // 관심사 문자열 추가
  	            if (interestsBuilder.length() > 0) {
  	                interestsBuilder.append(", "); // 쉼표로 구분
  	            }
  	            interestsBuilder.append(interest.get("INTERESTS")); // INTERESTS 키에서 값 가져오기
  	        }

  	        // 관심사 설정
  	        store.setInterest(interestsBuilder.toString());
  	        //평균 별점 계산
  	        double averageRating = service.calculateAverageRating(store.getPsNo());
  	        store.setAvgRating(averageRating); // 평균 평점 설정

  	        System.out.println("관심사: " + store.getInterest());
  	        System.out.println("------------------------------");
  	    }
  	    
  	    // searchData를 JSP에 전달
  	    model.addAttribute("searchData", vo);
  	    
  	    return "/popUp/searchResultPage"; // 검색 결과를 보여주는 JSP 경로
    }

    @GetMapping("/popUpDetails")
    public String popUpDetails(@RequestParam("storeName") String storeName, Model model) {
        // storeName을 받아 상세 정보를 처리
        System.out.println("스토어 이름: " + storeName);
        
        // DB에서 상세 정보를 가져오는 로직 작성
        popStoreVO vo = service.getStoreInfoByName(storeName);
       
         List<goodsVO> gvo = service.getGoodsInfoByName(storeName);
         
         for (goodsVO goods : gvo) {
        	    System.out.println("상품명: " + goods.getGname() + ", 가격: " + goods.getGprice() + "원");
        	}
        
    
        // storeName을 JSP에 전달
        model.addAttribute("storeInfo", vo);
        model.addAttribute("goodsInfo", gvo);
        
        return "/popUp/popUpDetailsPage"; // 상세 정보를 보여주는 JSP 경로
    }

    // 캘린더를 보여주는 메서드
    @RequestMapping("/calendar")
    public String showCalendarPage() {
        return "/popUpCalendar/calendarMain";  
    }
    @PostMapping(value = "/likeCount", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<Map<String, Object>> LikeCount(@RequestBody likeVO likeVO) {
        int psNo = likeVO.getPsNo();
        int userNo = likeVO.getUserNo();

        System.out.println("Received psNo: " + psNo + ", userNo: " + userNo);
        
        // 서비스 호출하여 좋아요 상태 업데이트
        likeVO result = service.likeCount(psNo, userNo);

        // 결과 처리
        Map<String, Object> response = new HashMap<>();
        if (result != null) {
            response.put("status", "liked"); // 좋아요가 추가된 경우
            response.put("psNo", psNo);
            response.put("userNo", userNo);
            response.put("message", "Like added successfully");
        } else {
            response.put("status", "unliked"); 
            response.put("psNo", psNo);
            response.put("userNo", userNo);
            response.put("message", "Like removed successfully");
        }

        return ResponseEntity.ok(response); 
    }
    
    

    @PostMapping(value = "/getLikeCount", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateLikeCount(@RequestBody likeVO likeVO) {
        int psNo = likeVO.getPsNo();

        System.out.println("Received psNo: " + psNo);

        // 서비스 호출하여 좋아요 수 가져오기
        Integer likeCount = service.getLikeCount(psNo);

        // 결과 처리
        Map<String, Object> response = new HashMap<>();
        if (likeCount != null) {
            response.put("status", "success");
            response.put("likeCount", likeCount); // likeCount 추가
        } else {
            response.put("status", "failure");
        }

        return ResponseEntity.ok(response);
    }
    @PostMapping(value = "/checkLikeStatus", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<Map<String, Object>> checkLikeStatus(@RequestBody likeVO likeVO) {
        int psNo = likeVO.getPsNo();
        int userNo = likeVO.getUserNo();

        // 유저가 해당 팝업스토어에 좋아요를 눌렀는지 확인
        boolean hasLiked = service.checkUserLike(psNo, userNo);

        Map<String, Object> response = new HashMap<>();
        response.put("hasLiked", hasLiked);  // 좋아요 상태 반환
        return ResponseEntity.ok(response);
    }
    // 요셉이 거 병합 부분 
    @GetMapping(value = "/calendarData", produces = MediaType.APPLICATION_JSON_VALUE) 
    @ResponseBody
    public List<popStoreVO> calendarData() {
        List<popStoreVO> cData = service.showCalendar();
        log.info("Calendar Data: " + cData); // 데이터 확인을 위한 로그
        return cData;
    }
    
    @GetMapping(value = "categoryData", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<pCatVO> getCategoryData() {
        return service.getCategoryData();
    }
    
    @GetMapping("/customerMain") // 고객 센터로 이동하는 메서드
	public String customerMain() {
		
		return "/customerService/customerServiceMain";
	}
    @GetMapping(value = "userInterest", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<mCatVO> getUserInterest(@RequestParam("userNo") int userNo) {
        return service.getUserInterest(userNo);
    }
    
    // 유저 좋아요 가져오기
    @GetMapping(value = "userLike", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<likeVO> getUserLike(@RequestParam("userNo") int userNo) {
    	return service.getUserLike(userNo);
    }
    
    
    // 윤씨 취합부분!
    
    @GetMapping("/myDetail")
    public String myDetail(@RequestParam("storeName") String storeName, Model model) {
        // storeName을 받아 상세 정보를 처리
        System.out.println("스토어 이름: " + storeName);
        
        // DB에서 상세 정보를 가져오는 로직 작성
        popStoreVO vo = service.getStoreInfoByName(storeName);
       
         List<goodsVO> gvo = service.getGoodsInfoByName(storeName);
         
         for (goodsVO goods : gvo) {
        	    System.out.println("상품명: " + goods.getGname() + ", 가격: " + goods.getGprice() + "원");
        	}
        
    
        // storeName을 JSP에 전달
        model.addAttribute("storeInfo", vo);
        model.addAttribute("goodsInfo", gvo);
        
        return "/popUp/popUpDetailsPage"; // 상세 정보를 보여주는 JSP 경로
    }
}
  