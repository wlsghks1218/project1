package org.hype.controller;

import java.io.File;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.hype.domain.Criteria;
import org.hype.domain.PageDTO;
import org.hype.domain.exhImgVO;
import org.hype.domain.exhVO;
import org.hype.domain.gImgVO;
import org.hype.domain.goodsVO;
import org.hype.domain.pImgVO;
import org.hype.domain.payVO;
import org.hype.domain.popStoreVO;
import org.hype.domain.qnaVO;
import org.hype.domain.signInVO;
import org.hype.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private AdminService aservice;	
	
	@GetMapping("/adminPage")
	public String adminPopUp() {		
		
		System.out.println("관리자 페이지 이동");
		
		return "/admin/adminMain";
	}
	
	@GetMapping("/askList")
	public String askList() {		
		
		System.out.println("문의 리스트 페이지 이동");
		
		return "/admin/askListCheck";
	}
	
	//*** 관리자 페이지 ***
	// *** header 공통
	// 팝업스토어 리스트 출력
	// 페이징 처리 O
	@ResponseBody
	@GetMapping(value = "/psList", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Map<String, Object>> getList(Criteria cri, @RequestParam(required = false) String searchPs) {
	    log.warn(cri.getAmount());
	    log.warn(cri.getPageNum());
	    log.warn(searchPs);
	    
	    if (cri.getPageNum() == 0 || cri.getAmount() == 0) {
	        cri.setPageNum(1);
	        cri.setAmount(10);
	    }
	    
	    log.info(cri.getPageNum() + "/" + cri.getAmount());

	    int total = aservice.getPTotal(searchPs);  // 전체 스토어 수 
	    List<popStoreVO> list = aservice.getPList(cri, searchPs);  // 검색 결과
	    PageDTO pageMaker = new PageDTO(cri, total);  // 페이지 메이커
	    
	    
	    log.info("list : " + list);
	    log.info("total : " + total);
	    log.info("pageMaker : " + pageMaker);
	    
	    Map<String, Object> response = new HashMap<>();	
	    
	    response.put("list", list);
		response.put("total", total);
	    response.put("pageMaker", pageMaker);
	    
	    return ResponseEntity.ok(response);
	}
	
	
	// 상품 리스트 출력 (header - 공통)
	// 페이징 O
	@ResponseBody
	@GetMapping(value ="/gList",
			produces = {MediaType.APPLICATION_JSON_UTF8_VALUE,
					   MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<Map<String, Object>> getGList(Criteria cri, @RequestParam(required = false) String searchGs) {
		log.warn(cri.getAmount());
		log.warn(cri.getPageNum());
		log.warn(searchGs);
		
		if (cri.getPageNum() == 0 || cri.getAmount() == 0) {
			cri.setPageNum(1);
			cri.setAmount(10);
		}
		
		log.info(cri.getPageNum() + "/" + cri.getAmount());
		
		int total = aservice.getGTotal(searchGs);  // 전체 스토어 수 
		List<goodsVO> list = aservice.getGList(cri, searchGs);  // 검색 결과
		PageDTO pageMaker = new PageDTO(cri, total);  // 페이지 메이커
		
		
		log.info("list : " + list);
		log.info("total : " + total);
		log.info("pageMaker : " + pageMaker);
		
		Map<String, Object> response = new HashMap<>();	
		
		response.put("list", list);
		response.put("total", total);
		response.put("pageMaker", pageMaker);
		
		return ResponseEntity.ok(response);
	}
		
	// 회원 리스트 출력 (header - 공통)
	// 페이징 O
	@ResponseBody
	@GetMapping(value ="/mList",
			produces = {MediaType.APPLICATION_JSON_UTF8_VALUE,
					   MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<Map<String, Object>> getMList(Criteria cri, @RequestParam(required = false) String searchMs) {
		log.warn(cri.getAmount());
		log.warn(cri.getPageNum());
		log.warn(searchMs);
		
		if (cri.getPageNum() == 0 || cri.getAmount() == 0) {
			cri.setPageNum(1);
			cri.setAmount(10);
		}
		
		log.info(cri.getPageNum() + "/" + cri.getAmount());
		
		int total = aservice.getMTotal(searchMs);  // 전체 회원 수 
		List<signInVO> list = aservice.getMList(cri, searchMs);  // 검색 결과
		PageDTO pageMaker = new PageDTO(cri, total);  // 페이지 메이커
		
		
		log.info("list : " + list);
		log.info("total : " + total);
		log.info("pageMaker : " + pageMaker);
		
		Map<String, Object> response = new HashMap<>();	
		
		response.put("list", list);
		response.put("total", total);
		response.put("pageMaker", pageMaker);
		
		return ResponseEntity.ok(response);
	}
	
	// 팝업스토어 이름 클릭 시 팝업스토어 수정/삭제 페이지로 이동
	@GetMapping("/popUpUpdate")
	public String updatePopUp(@RequestParam("psNo") int psNo, Model model) {
		log.info("팝업스토어 수정 페이지로 이동: psNo = " + psNo);
		
		// 해당 psNo에 대한 팝업스토어 정보 조회
		popStoreVO popStore = aservice.getPopStoreById(psNo);
		if (popStore != null) {
			model.addAttribute("popStore", popStore); // JSP에서 사용하기 위해 모델에 추가
			return "admin/psUpdateDelete"; // JSP 파일 경로
		} else {
			// 해당 ID의 팝업스토어가 없는 경우 처리
			return "redirect:/admin/psList";
		}
	}
	
	// 굿즈 이름 클릭 시 굿즈 정보 수정/삭제 페이지로 이동
	@GetMapping("/goodsUpdate")
	public String updateGoods(@RequestParam("gNo") int gNo, Model model) {
	    log.info("굿즈 정보 수정 페이지로 이동: gNo = " + gNo);
	    
	    // 해당 psNo에 대한 팝업스토어 정보 조회
	    goodsVO goods = aservice.getGoodsById(gNo);
	    if (goods != null) {
	        model.addAttribute("goods", goods); // JSP에서 사용하기 위해 모델에 추가
	        return "admin/gUpdateDelete"; // JSP 파일 경로
	    } else {
	        // 해당 ID의 굿즈가 없는 경우 처리
	        return "redirect:/admin/gList";
	    }
	}
	
	// 회원 아이디 클릭 시 회원 정보 수정 페이지로 이동
	@GetMapping("/memberUpdate")
	public String updateMembers(@RequestParam("userNo") String userNo, Model model) {
	    
	    // 해당 userNo 에 대한 회원 정보 조회
	    signInVO svo = aservice.getMembersById(userNo);	    
	    log.info("member의 userNo 찾기 : " + svo.getUserNo());	  
	    log.info("회원 번호: " + svo.getUserNo());
	    log.info("회원 아이디: " + svo.getUserId());
	    log.info("회원 이름: " + svo.getUserName());
	    log.info("회원 이메일: " + svo.getUserEmail());
	    log.info("회원 전화번호: " + svo.getUserNumber());
	    log.info("권한: " + svo.getAuth());
	    log.info("회원 가입일: " + svo.getRegDate());
	    log.info("마지막 로그인 날짜: " + svo.getLastLoginDate());
	    
	    if (svo != null) {
	        model.addAttribute("svo", svo); // JSP에서 사용하기 위해 모델에 추가
	        return "admin/memberUpdate"; // JSP 파일 경로
	    } else {
	        // 해당 ID의 회원이 없는 경우 처리
	        return "redirect:/admin/mList";
	    }
	}
	
	// 문의 리스트 확인 버튼 클릭 시 문의 리스트 확인 페이지로 이동
	@GetMapping("/askListCheck")
	public String checkAskList() {
		return "admin/askListCheck"; // JSP 파일 경로
	}
				
	// 상품 상태 조회 버튼 클릭 시 상품 상태 조회 페이지로 이동
	@GetMapping("/goodsState")
	public String checkGoods() {
		return "admin/goodsState"; // JSP 파일 경로
	}
	
	
	// 등록하기 버튼 클릭 시 이동
	@GetMapping("/popUpRegister")
    public String popUpRegister() {
        return "admin/popUpRegister"; 
    }
	
	// 전시회 등록하기 버튼 클릭 시 이동
	@GetMapping("/exhRegister")
	public String exhRegister() {
		return "admin/exhRegister"; 
	}

	// 상품(굿즈) 등록 페이지에서
	// 셀렉트 박스 팝업스토어 리스트 출력
    @GetMapping("/goodsRegister")
    public String goodsRegister(Model model) {
    	List<popStoreVO> popStores = aservice.getAllPopStores(); // 서비스에서 모든 팝업스토어를 가져옴
    	model.addAttribute("popStores", popStores); // 모델에 추가
//    	log.warn("모든 팝업스토어 전부 다 가져오나요?? " + model);
    	return "admin/goodsRegister"; // JSP 페이지로 이동
    }    
    
    // *** 팝업스토어 등록 페이지 ***
    // yyyy-MM--dd 형식으로 들어오는 데이터들을
 	// java.sql.Date.class로 바꿔서
 	// popStoreVO에 있는 date 타입들이랑 매칭해주겠다는 뜻
    @InitBinder("popStoreVO")
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        
        // java.sql.Date 변환을 위해 CustomDateEditor 사용
        binder.registerCustomEditor(java.sql.Date.class, new CustomDateEditor(dateFormat, true));
    }
      	
    @PostMapping("/psRegister")
    public String registerPopUpStore(@ModelAttribute popStoreVO vo) throws IllegalAccessException, IllegalArgumentException, InvocationTargetException {
    	log.warn("registerPopUpStore......");
    	
    	log.warn("이미지 파일 정보: " + vo.getImageFile().getName());
    	// 이 코드는 vo를 get, set하지 않고 쓸 수 있는 코드이기 때문에
    	// 확인용이라고 생각하면 됨 확인이 완료되면 for문까지 다 지워도 되고
 		// throws IllegalAccessException, IllegalArgumentException, InvocationTargetException 도 같이 지우면 됨
    	Method[] methods = vo.getClass().getDeclaredMethods();
    	
    	for (Method method : methods) {
            // 메서드 이름이 'get'으로 시작하는지 확인
            if (method.getName().startsWith("get")) {
                // 메서드를 호출하여 값을 가져옴
                Object value = method.invoke(vo);
                System.out.println(method.getName().substring(3) + ": " + value);
            }
         }
    	
    	// 컨트롤러에서 전달받는 것까지만 한 거고 이제 insert 하면 됨 
    	// 유효 아이디랑 업로드 과정
        // 이미지 등록 처리 로직 추가
        if (vo.getImageFile() != null && !vo.getImageFile().isEmpty()) {
            log.info("Image file upload process started...");

            String uploadPath = "\\\\192.168.0.129\\storeGoodsImg\\팝업스토어 사진";
            
            // 이미지 파일 정보 설정
            MultipartFile multipartFile = vo.getImageFile();
            String originalFileName = multipartFile.getOriginalFilename();
            String uploadFileName = originalFileName.substring(originalFileName.lastIndexOf("\\") + 1);

            UUID uuid = UUID.randomUUID();
            uploadFileName = uuid.toString() + "_" + uploadFileName;

            try {
                // 이미지 파일을 지정된 경로에 저장
                File saveFile = new File(uploadPath, uploadFileName);
                multipartFile.transferTo(saveFile);

                // pImgVO 객체 생성하여 DB에 저장
                pImgVO imgVo = new pImgVO();
                imgVo.setUuid(uuid.toString());
                imgVo.setUploadPath(uploadPath);
                imgVo.setFileName(originalFileName);
                
                vo.setPsImg(imgVo);

                // 이미지 정보를 DB에 저장하는 서비스 호출 (예: pService.insertImage(imageVo))
                int result = aservice.insertPopStore(vo);
                log.info("Image file registered with result: " + result);

            } catch (Exception e) {
                log.error("Image upload failed: " + e.getMessage());
            }
        }
    	
    	return "redirect:/admin/adminPage";
    }
    
    // *** 팝업스토어 수정/삭제 페이지 ***
    // 진행 중
//    @PostMapping("/psUpdate")
//    public void updatePopUpStore(@ModelAttribute popStoreVO vo) {
//    	
//    }
    
    // *** 상품(굿즈) 등록 페이지 ***
    @InitBinder("goodsVO")
    public void initBinder2 (WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        
        // java.sql.Date 변환을 위해 CustomDateEditor 사용
        binder.registerCustomEditor(java.sql.Date.class, new CustomDateEditor(dateFormat, true));
    }      	
    
    @PostMapping("/gRegister")
    public String registerGoodsStore(@ModelAttribute goodsVO gvo) {
    	
    	log.info(gvo.getGname());
    	log.info(gvo.getGexp());
    	log.info(gvo.getPsno());
    	log.info(gvo.getGprice());
    	log.info(gvo.getImageFiles().get(0).getOriginalFilename());
    	log.info(gvo.getImageFiles().get(1).getOriginalFilename());
        
        // 이미지 등록 처리 로직
        if (gvo.getImageFiles() != null && !gvo.getImageFiles().isEmpty()) {
            log.info("Image file upload process started...");

            // 배너와 상세 이미지 경로
            String bannerUploadPath = "\\\\192.168.0.129\\storeGoodsImg\\굿즈 배너 사진";
            String detailUploadPath = "\\\\192.168.0.129\\storeGoodsImg\\굿즈 상세 사진";

            List<gImgVO> attachList = new ArrayList<gImgVO>();
            // 이미지 파일을 순회하며 처리
            for (int i = 0; i < gvo.getImageFiles().size(); i++) {
                MultipartFile multipartFile = gvo.getImageFiles().get(i);
                if (!multipartFile.isEmpty()) {
                    try {
                        String originalFileName = multipartFile.getOriginalFilename();
                        String uploadFileName = originalFileName.substring(originalFileName.lastIndexOf("\\") + 1);
                        
                        UUID uuid = UUID.randomUUID();
                        uploadFileName = uuid.toString() + "_" + uploadFileName;

                        // 배너/상세 이미지 선택: 첫 번째는 배너, 두 번째는 상세
                        String uploadPath = (i == 0) ? bannerUploadPath : detailUploadPath;

                        // 이미지 파일을 지정된 경로에 저장
                        File saveFile = new File(uploadPath, uploadFileName);
                        multipartFile.transferTo(saveFile);
                        
                        
                        // gImgVO 생성 후 attachList에 추가
                        gImgVO gImgVo = new gImgVO();
                        gImgVo.setUuid(uuid.toString());
                        gImgVo.setUploadPath(uploadPath);
                        gImgVo.setFileName(originalFileName);                 
                        
                        attachList.add(gImgVo);

                    } catch (Exception e) {
                        log.error("Image upload failed for file: " + multipartFile.getOriginalFilename());
                    }
                }
            }
            
            gvo.setAttachList(attachList);
                        
            int result = aservice.insertGoodsStore(gvo);
            log.info("Goods registered with result: " + result);
        }

        return "redirect:/admin/adminPage"; // 등록 후 페이지 리다이렉션
    }
    
	// *** 전시회 등록 페이지 ***
    @InitBinder("exhVO")
    public void initBinder3 (WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        
        // java.sql.Date 변환을 위해 CustomDateEditor 사용
        binder.registerCustomEditor(java.sql.Date.class, new CustomDateEditor(dateFormat, true));
    }      	
    
    @PostMapping("/eRegister")
    public String registerExhibition (@ModelAttribute exhVO evo) {

    	log.info("전시회 배너 이미지 : " + evo.getImageExhFiles().get(0).getOriginalFilename());
    	log.info(evo.getImageExhFiles().get(1).getOriginalFilename());
    	log.info("전시회 이름 : " + evo.getExhName());
    	log.info(evo.getExhLocation());
    	log.info(evo.getExhStartDate());
    	log.info(evo.getExhEndDate());
    	log.info(evo.getExhWatchTime());
    	log.info(evo.getExhPrice());
    	log.info(evo.getExhInfo());
    	log.info(evo.getExhNo());    	
        
        // 이미지 등록 처리 로직
        if (evo.getImageExhFiles() != null && !evo.getImageExhFiles().isEmpty()) {
            log.info("Image file upload process started...");

            // 배너와 상세 이미지 경로
            String exhBannerUploadPath = "\\\\192.168.0.129\\storeGoodsImg\\전시회 배너 사진";
            String exhDetailUploadPath = "\\\\192.168.0.129\\storeGoodsImg\\전시회 상세 사진";

            List<exhImgVO> attachExhList = new ArrayList<exhImgVO>();
            
            // 이미지 파일을 순회하며 처리
            for (int i = 0; i < evo.getImageExhFiles().size(); i++) {
                MultipartFile multipartFile = evo.getImageExhFiles().get(i);
                if (!multipartFile.isEmpty()) {
                    try {
                        String originalFileName = multipartFile.getOriginalFilename();
                        String uploadFileName = originalFileName.substring(originalFileName.lastIndexOf("\\") + 1);
                        
                        UUID uuid = UUID.randomUUID();
                        uploadFileName = uuid.toString() + "_" + uploadFileName;

                        // 배너/상세 이미지 선택: 첫 번째는 배너, 두 번째는 상세
                        String uploadPath = (i == 0) ? exhBannerUploadPath : exhDetailUploadPath;

                        // 이미지 파일을 지정된 경로에 저장
                        File saveFile = new File(uploadPath, uploadFileName);
                        multipartFile.transferTo(saveFile);                        
                        
                        // exhImgVO 생성 후 attachExhList에 추가
                        exhImgVO exhImgVo = new exhImgVO();
                        exhImgVo.setUuid(uuid.toString());
                        exhImgVo.setUploadPath(uploadPath);
                        exhImgVo.setFileName(originalFileName);                 
                        
                        attachExhList.add(exhImgVo);

                    } catch (Exception e) {
                        log.error("Image upload failed for file: " + multipartFile.getOriginalFilename());
                    }
                }
            }
            
            evo.setAttachExhList(attachExhList);
            
            int result = aservice.insertExhibition(evo);
        }

        return "redirect:/admin/adminPage"; // 등록 후 페이지 리다이렉션
    }
    
    // *** 문의 리스트 확인 페이지 ***
	// 문의 리스트 출력
	// 페이징 미적용
	@GetMapping(value = "/qnaList", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<qnaVO>> getQnaList(@RequestParam("qnaType") String qnaType, @RequestParam("qnaAnswer") String qnaAnswer) {
		log.info("문의 유형 : " + qnaType);
		log.info("답변 여부 : " + qnaAnswer);
        List<qnaVO> qnaList = aservice.getQnaListByType(qnaType, qnaAnswer);
        log.info("문의 리스트: " + qnaList);
        return ResponseEntity.ok(qnaList);
    }
	
	
	// *** 상품 상태 조회 페이지 ***
//	@GetMapping(value ="/getPurchaseList", produces = MediaType.APPLICATION_JSON_VALUE)
//	public ResponseEntity<List<payVO>> getPurchaseList() {
//	    List<payVO> purchaseList = aservice.getPurchaseList();
//	    if (purchaseList != null) {
//	        return ResponseEntity.ok(purchaseList); // 정상적으로 응답 반환
//	    } else {
//	        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null); // 데이터가 없을 경우 404 반환
//	    }
//	}
	
    //*** 회원 정보 수정 페이지 ***
    @PostMapping(value = "/mUpdate", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateMember(@RequestBody signInVO svo) {
       System.out.println("Received data: " + svo.getAuth());  // 로그 추가
       System.out.println("Received data: " + svo.getUserEmail());  // 로그 추가
       System.out.println("Received data: " + svo.getUserId());  // 로그 추가
       System.out.println("Received data: " + svo.getUserNo());  // 로그 추가
       System.out.println("Received data: " + svo.getUserName());  // 로그 추가
       System.out.println("Received data: " + svo.getUserNumber());  // 로그 추가
       System.out.println("Received data: " + svo.getRegDate());  // 로그 추가
       System.out.println("Received data: " + svo.getLastLoginDate());  // 로그 추가
       
	   Map<String, Object> response = new HashMap<>();
	    
	   try {
	       int result = aservice.updateMem(svo);
	       
	       
	       if (result == 1) {
	           response.put("status", "success");
	           response.put("message", "회원 정보가 성공적으로 수정되었습니다.");
	           return ResponseEntity.ok(response);  // 200 OK
	       } else {
	           response.put("status", "failure");
	           response.put("message", "회원 정보 수정에 실패했습니다.");
	           return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);  // 400 Bad Request
	       }
	   } catch (Exception e) {
		   e.printStackTrace();
		   
	       response.put("status", "error");
	       response.put("message", "서버 오류가 발생했습니다: " + e.getMessage());
	       return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);  // 500 Internal Server Error
	   }
    }
    
}