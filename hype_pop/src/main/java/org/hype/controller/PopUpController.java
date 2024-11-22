package org.hype.controller;


import java.io.File;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.hype.domain.gImgVO;
import org.hype.domain.goodsVO;
import org.hype.domain.likeVO;
import org.hype.domain.mCatVO;
import org.hype.domain.pCatVO;
import org.hype.domain.pImgVO;
import org.hype.domain.popStoreVO;
import org.hype.domain.psReplyVO;
import org.hype.security.domain.CustomUser;
import org.hype.service.GoodsService;
import org.hype.service.PopUpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/hypePop/*")
public class PopUpController {
	@Autowired
	PopUpService service;
	@Autowired
	GoodsService gService;
	
	@RequestMapping(value = "/popUpMain", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
	    // 현재 인증된 사용자 정보 가져오기
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    int userNo = 0;

	    // 인기 팝업 스토어 목록 가져오기
	    List<popStoreVO> popularPopUps = service.getPopularPopUps();
	   
	    // 팝업 스토어 이미지 처리
	    for (popStoreVO popUp : popularPopUps) {
	    	pImgVO imgVo = service.getImageByStoreId(popUp.getPsNo());
	    	if (imgVo != null) {
	    		popUp.setPsImg(imgVo); // 이미지 설정
	    	}
	    }
	    model.addAttribute("popularPopUps", popularPopUps); // 인기 팝업 스토어 리스트 모델에 추가
	
	    if (authentication != null && authentication.getPrincipal() instanceof CustomUser) {
	        CustomUser userDetails = (CustomUser) authentication.getPrincipal();
	        userNo = userDetails.getUserNo(); // userNo 가져오기
	        Map<String, List<popStoreVO>> topStoresByInterest = service.getTopStoresByInterests(userNo);
	        System.out.println("유저 넘버 제발 제대로 좀 주세요 .... : " + userNo);
	        for (List<popStoreVO> storeList : topStoresByInterest.values()) {
	        	for (popStoreVO popUp2 : storeList) {
	        		pImgVO imgVo = service.getImageByStoreId(popUp2.getPsNo());
	        		if (imgVo != null) {
	        			popUp2.setPsImg(imgVo); // 이미지 설정
	        		}
	        	}
	        }
	        model.addAttribute("topStoresByInterestMap", topStoresByInterest); // 관심사 기반 팝업 스토어 리스트 모델에 추가
	    }
	    

	    // 좋아요 수로 분류한 상위 카테고리 팝업 스토어
	    Map<String, List<popStoreVO>> topCategoriesByLikes = service.getTopCategoriesByLikes();
	    for (List<popStoreVO> storeList : topCategoriesByLikes.values()) {
	        for (popStoreVO popUp3 : storeList) {
	            pImgVO imgVo = service.getImageByStoreId(popUp3.getPsNo());
	            if (imgVo != null) {
	                popUp3.setPsImg(imgVo); // 이미지 설정
	            }
	        }
	    }
	    model.addAttribute("topCategoriesByLikesMap", topCategoriesByLikes); // 카테고리 기반 팝업 스토어 리스트 모델에 추가

	    return "popUp/popUpMainPage"; // JSP 페이지 반환
	}


	
	@GetMapping("/search") // URL 留ㅽ���� �대�뱁���� 硫�����
	public String search(@RequestParam("searchData") String searchData, Model model) {
	    // searchData瑜� 諛��� 寃��� 寃곌낵瑜� 泥�由�

	    
	    // DB���� 寃��� 寃곌낵瑜� 媛��몄�ㅻ�� 濡�吏� ����
	    List<popStoreVO> vo = service.popUpSearchByData(searchData);
	   
	    for (popStoreVO store : vo) {
	     
	        
	        // 媛� �ㅽ���댁�� 愿��ъ�� 議고��
	        List<Map<String, Object>> interestsList = service.getInterestsByPsNo(store.getPsNo());

	        // 愿��ъ�щ�� 臾몄���대� 蹂���
	        StringBuilder interestsBuilder = new StringBuilder();
	        for (Map<String, Object> interest : interestsList) {
	            if (interestsBuilder.length() > 0) {
	                interestsBuilder.append(", "); // 肄ㅻ�濡� 援щ�
	            }
	            log.info("愿��ъ�� : " + interestsBuilder);
	            interestsBuilder.append(interest.get("INTERESTS"));
	        }
	        store.setInterest(interestsBuilder.toString());
	        
	        //��洹� 蹂��� 怨���
	        double averageRating = service.calculateAverageRating(store.getPsNo());
	        store.setAvgRating(averageRating); // ��洹� ���� �ㅼ��

	   

	    }
	    
	    // searchData瑜� JSP�� ����
	    model.addAttribute("searchData", vo);	
	    
	    return "/popUp/searchResultPage"; // 寃��� 寃곌낵瑜� 蹂댁�ъ＜�� JSP 寃쎈�
	}
    // 寃��� 寃곌낵媛� ���� 寃쎌�곕�� 泥�由ы���� 硫�����
    @GetMapping("/search/noData") // �뱀�� URL 留ㅽ��
    public String searchWithoutData(Model model) {
    	
    	 List<popStoreVO> vo = service.getAllPopUpData();
    	
    	  for (popStoreVO store : vo) {

  	        // 媛� �ㅽ���댁�� 愿��ъ�� 議고��
  	        List<Map<String, Object>> interestsList = service.getInterestsByPsNo(store.getPsNo());

  	        // 愿��ъ�щ�� 臾몄���대� 蹂���
  	        StringBuilder interestsBuilder = new StringBuilder();
  	        for (Map<String, Object> interest : interestsList) {
  	            // 愿��ъ�� 臾몄���� 異�媛�
  	            if (interestsBuilder.length() > 0) {
  	                interestsBuilder.append(", "); // �쇳��濡� 援щ�
  	            }
  	            interestsBuilder.append(interest.get("INTERESTS")); // INTERESTS �ㅼ���� 媛� 媛��몄�ㅺ린
  	        }

  	        // 愿��ъ�� �ㅼ��
  	        store.setInterest(interestsBuilder.toString());
  	        //��洹� 蹂��� 怨���
  	        double averageRating = service.calculateAverageRating(store.getPsNo());
  	        store.setAvgRating(averageRating); // ��洹� ���� �ㅼ��

  	    }
  	    
  	    // searchData瑜� JSP�� ����
  	    model.addAttribute("searchData", vo);
  	    
  	    return "/popUp/searchResultPage"; // 寃��� 寃곌낵瑜� 蹂댁�ъ＜�� JSP 寃쎈�
    }
    

    @GetMapping("/popUpDetails")
    public String popUpDetails(@RequestParam("storeName") String storeName, Model model) {
        // storeName�� 諛��� ���� ��蹂대�� 泥�由�
        
        // DB���� ���� ��蹂대�� 媛��몄�ㅻ�� 濡�吏� ����
        popStoreVO vo = service.getStoreInfoByName(storeName);
        
        System.out.println("���� �ㅽ���� 踰��몃�� : " + vo.getPsNo());
        
        pImgVO imgVo = service.getImageByStoreId(vo.getPsNo());
        vo.setPsImg(imgVo);
        
        List<goodsVO> gvo = service.getGoodsInfoByName(storeName);
        for (goodsVO goodsVo : gvo) {
            List<gImgVO> gImgVo = new ArrayList<>();
            gImgVO imgVo1 = gService.getImgByGno(goodsVo.getGno());
            gImgVo.add(imgVo1);
            goodsVo.setAttachList(gImgVo);
        }
        
     
        
        // ��洹� 蹂��� 怨���
        double avgRating = service.getAvgRating(vo.getPsNo());
        
        // popStoreVO 媛�泥댁�� ��洹� 蹂��� 異�媛�
        vo.setAvgRating(avgRating);  // popStoreVO�� avgRating ����瑜� 異�媛��� 寃쎌��
        
        // storeName怨� 愿��⑤�� �곗�댄�� ����
        model.addAttribute("storeInfo", vo);
        model.addAttribute("goodsInfo", gvo);
        
        return "/popUp/popUpDetailsPage"; // ���� ��蹂대�� 蹂댁�ъ＜�� JSP 寃쎈�
    }

    // 罹�由곕��瑜� 蹂댁�ъ＜�� 硫�����
    @RequestMapping("/calendar")
    public String showCalendarPage() {
        return "/popUpCalendar/calendarMain";  
    }
    @PostMapping(value = "/likeCount", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<Map<String, Object>> LikeCount(@RequestBody likeVO likeVO) {
        int psNo = likeVO.getPsNo();
        int userNo = likeVO.getUserNo();

        
        // ��鍮��� �몄����� 醫����� ���� ���곗�댄��
        likeVO result = service.likeCount(psNo, userNo);

        // 寃곌낵 泥�由�
        Map<String, Object> response = new HashMap<>();
        if (result != null) {
            response.put("status", "liked"); // 醫�����媛� 異�媛��� 寃쎌��
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


        // ��鍮��� �몄����� 醫����� �� 媛��몄�ㅺ린
        Integer likeCount = service.getLikeCount(psNo);

        // 寃곌낵 泥�由�
        Map<String, Object> response = new HashMap<>();
        if (likeCount != null) {
            response.put("status", "success");
            response.put("likeCount", likeCount); // likeCount 異�媛�
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

        // ����媛� �대�� �����ㅽ���댁�� 醫�����瑜� ������吏� ����
        boolean hasLiked = service.checkUserLike(psNo, userNo);

        Map<String, Object> response = new HashMap<>();
        response.put("hasLiked", hasLiked);  // 醫����� ���� 諛���
        return ResponseEntity.ok(response);
    }
    // ������ 嫄� 蹂��� 遺�遺� 
    @GetMapping(value = "/calendarData", produces = MediaType.APPLICATION_JSON_VALUE) 
    @ResponseBody
    public List<popStoreVO> calendarData() {
        List<popStoreVO> cData = service.showCalendar();
        log.info("Calendar Data: " + cData); // �곗�댄�� ���몄�� ���� 濡�洹�
        return cData;
    }
    
    @GetMapping(value = "categoryData", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<pCatVO> getCategoryData() {
        return service.getCategoryData();
    }
    
    @GetMapping("/customerMain") // 怨�媛� �쇳�곕� �대������ 硫�����
	public String customerMain() {
		
		return "/customerService/customerServiceMain";
	}
    @GetMapping(value = "userInterest", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<mCatVO> getUserInterest(@RequestParam("userNo") int userNo) {
        return service.getUserInterest(userNo);
    }
    
    // ���� 醫����� 媛��몄�ㅺ린
    @GetMapping(value = "userLike", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<likeVO> getUserLike(@RequestParam("userNo") int userNo) {
    	return service.getUserLike(userNo);
    }
    
    
    // �ㅼ�� 痍⑦�⑸�遺�!
    
    @GetMapping("/myDetail")
    public String myDetail(@RequestParam("storeName") String storeName, Model model) {
        // storeName�� 諛��� ���� ��蹂대�� 泥�由�
        
        // DB���� ���� ��蹂대�� 媛��몄�ㅻ�� 濡�吏� ����
        popStoreVO vo = service.getStoreInfoByName(storeName);
       
         List<goodsVO> gvo = service.getGoodsInfoByName(storeName);
        
        
    
        // storeName�� JSP�� ����
        model.addAttribute("storeInfo", vo);
        model.addAttribute("goodsInfo", gvo);
        
        return "/popUp/popUpDetailsPage"; // ���� ��蹂대�� 蹂댁�ъ＜�� JSP 寃쎈�
    }
 // 캘린더에 쓸 팝업이미지 가져오기
    @GetMapping(value = "/getPopUpImage", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public List<pImgVO> getPopUpImage(@RequestParam("psNo") int psNo) {

	    List<pImgVO> popUpStore = service.getPopImg(psNo);
	    return popUpStore;
	}
	
	@GetMapping("/popUpStoreImages/{fileName:.+}")
    @ResponseBody
    public ResponseEntity<Resource> serveImage(@PathVariable String fileName) throws MalformedURLException {
    	String[] parts = fileName.split("_", 2);
	    if (parts.length != 2) {
	        throw new RuntimeException("파일 이름 형식이 잘못되었습니다. 형식: uuid_fileName");
	    }
	    String uuid = parts[0];  
	    String originalFileName = parts[1];  

	    // 파일이 저장된 경로
	    String uploadFolder = "\\\\192.168.0.129\\storeGoodsImg\\팝업스토어 사진";
	    String imagePath = uploadFolder + File.separator + uuid + "_" + originalFileName;
	    Path path = Paths.get(imagePath);


	    // 파일이 존재하지 않으면 예외 처리
	    if (!Files.exists(path)) {
	        throw new RuntimeException("파일이 존재하지 않습니다: " + fileName);
	    }

	    // 파일이 읽을 수 없으면 예외 처리
	    if (!Files.isReadable(path)) {
	        throw new RuntimeException("파일을 읽을 수 없습니다: " + fileName);
	    }

	    // 파일을 리소스로 읽어 반환
	    Resource file = new FileSystemResource(path.toFile());
	    return ResponseEntity.ok()
	        .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + originalFileName + "\"")
	        .body(file);
    }
	
}
  