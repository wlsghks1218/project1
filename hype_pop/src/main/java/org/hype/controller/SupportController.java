package org.hype.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hype.domain.noticeVO;
import org.hype.domain.qnaVO;
import org.hype.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/support")
public class SupportController {
	
	@Autowired
	private NoticeService noticeService;
	
	@GetMapping(value = "/notices", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> getNoticeList(
	    @RequestParam(defaultValue = "1") int pageNum,
	    @RequestParam(defaultValue = "5") int amount) {
	    List<noticeVO> notices = noticeService.getNoticesWithPaging(pageNum, amount);
	    int totalCount = noticeService.getTotalNoticeCount(); 

	    Map<String, Object> response = new HashMap<>();
	    response.put("notices", notices);// 총 개수 포함
	    response.put("totalCount", totalCount); 
	    
	    return new ResponseEntity<>(response, HttpStatus.OK);
	}

	@GetMapping(value = "/inquiry", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> getInquiryList(
	    @RequestParam(defaultValue = "1") int pageNum,
	    @RequestParam(defaultValue = "5") int amount,
	    @RequestParam int userNo) {
	    List<qnaVO> inquiries = noticeService.getInquiriesWithPaging(pageNum, amount, userNo);
	    int totalCount = noticeService.getTotalInquiryCount(userNo); // 총 문의 개수 가져오기

	    Map<String, Object> response = new HashMap<>();
	    response.put("inquiries", inquiries);
	    response.put("totalCount", totalCount); 

	    return new ResponseEntity<>(response, HttpStatus.OK);
	}



	// 공지사항 작성 페이지로 이동
	@GetMapping("/createNotice")
	public String createNotice() {
		
		return "/customerService/createNotice";
	}	
	
	@PostMapping("/createNotice") // 공지 생성
    public String createNotice(@RequestParam String title, 
                                @RequestParam String content, 
                                Model model) {
        noticeVO notice = new noticeVO();
        notice.setNoticeTitle(title);
        notice.setNoticeContent(content);

        boolean isSaved = noticeService.createNotice(notice); // 공지사항 저장

        if (isSaved) {
            model.addAttribute("message", "공지사항이 성공적으로 저장되었습니다.");
        } else {
            model.addAttribute("message", "공지사항 저장에 실패하였습니다.");
        }

        return "redirect:/hypePop/customerMain"; // 공지사항 리스트로 리다이렉트
    }
	
	// 문의 작성 페이지로 이동
	@GetMapping("/createInquiry")
	public String createInquiry() {
		
		return "/customerService/createInquiry";
	}
	
	@PostMapping("/createInquiry") // 공지 생성
	public String createInquiry(@RequestParam String title, @RequestParam String qnaType, 
	                            @RequestParam String content, /*HttpSession session,*/ Model model) {
	    // 세션에서 userNo 가져오기
//	    Integer userNo = (Integer) session.getAttribute("userNo");
	    
	    // qnaVO 객체 생성 및 필드 설정
	    qnaVO qna = new qnaVO();
	    qna.setQnaTitle(title);
	    qna.setQnaType(qnaType);
	    qna.setQnaContext(content);
	    qna.setQnaAnswer("답변없음");
	    qna.setUserNo(1);
	    
	    // userNo 설정
//	    qna.setUserNo(userNo); // userNo를 qnaVO에 설정해야 하는 메서드 추가 필요

	    // 문의 저장
	    boolean isSaved = noticeService.createInquiry(qna); 

	    if (isSaved) {
	        model.addAttribute("message", "문의가 성공적으로 저장되었습니다.");
	    } else {
	        model.addAttribute("message", "문의 저장에 실패하였습니다.");
	    }

	    return "redirect:/hypePop/customerMain?tab=inquiry"; // 문의사항 리스트로 리다이렉트
	}


	@GetMapping("/noticeInfo") // 공지 상세 정보
	public String noticeInfoList(@RequestParam("noticeNo") int noticeNo, Model model) {
		 noticeVO noticeInfo = noticeService.getNoticeInfo(noticeNo);
	     model.addAttribute("noticeInfo", noticeInfo);
	     return "/customerService/noticeInfo";  
	}
	
	@GetMapping("/inquiryInfo") // 문의 상세 정보
	public String inquiryInfoList(@RequestParam("qnaNo") int qnaNo, Model model) {
		qnaVO inquiryInfo = noticeService.getInquiryInfo(qnaNo);
		model.addAttribute("inquiryInfo", inquiryInfo);
		return "/customerService/inquiryInfo";
	}
	
	@PostMapping("/updateNotice")
	public String updateNotice(@ModelAttribute("noticeInfo") noticeVO nvo) {
		
	    noticeService.updateNotice(nvo);
	  
	    return "redirect:/hypePop/customerMain"; 
	}
	
	@PostMapping("/deleteNotice")
	public String deleteNotice(@RequestParam("noticeNo") int noticeNo, RedirectAttributes redirectAttributes) {
		try {
	        // 서비스 호출하여 noticeNo에 해당하는 공지 삭제
	        noticeService.deleteNotice(noticeNo);

	        // 성공 메시지 
	        redirectAttributes.addFlashAttribute("message", "공지 삭제가 성공적으로 완료되었습니다.");
	    } catch (Exception e) {
	    	// 오류 메세지
	        log.error("공지 삭제 중 오류 발생", e);
	        redirectAttributes.addFlashAttribute("message", "공지 삭제 중 오류가 발생했습니다.");
	    }
		
	    return "redirect:/hypePop/customerMain";
	}
	
	@PostMapping("/updateAnswer")
	@ResponseBody
	public ResponseEntity<String> updateAnswer(@RequestBody qnaVO qna) {
	    try {
	        noticeService.updateAnswer(qna);
	        return ResponseEntity.ok("답변이 성공적으로 업데이트되었습니다.");
	    } catch (Exception e) {
	        log.error("답변 업데이트 중 오류 발생", e);
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("답변 업데이트 중 오류가 발생했습니다.");
	    }
	}

	@PostMapping("deleteInquiry")
	public String deleteInquiry(@RequestParam("qnaNo") int qnaNo, Model model) {
	    try {
	        noticeService.deleteInquiry(qnaNo); 
	        return "redirect:/hypePop/customerMain?tab=inquiry"; 
	    } catch (Exception e) {
	        model.addAttribute("errorMessage", "문의 삭제 중 오류가 발생했습니다.");
	        return "errorPage"; 
	    }
	}
	   //특정 유저 1:1 문의글 가져오기(윤)
    @GetMapping(value = "/userInquiry", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getUserInquiryList(
            @RequestParam int userNo, // 요청 파라미터로 userNo를 받음
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "5") int amount) {

        List<qnaVO> inquiries = noticeService.getUserInquiriesWithPaging(userNo, pageNum, amount);

        if (inquiries == null || inquiries.isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        }

       int totalCount = noticeService.getTotalInquiryCountByUser(userNo); // 총 문의 개수 가져오기


        Map<String, Object> response = new HashMap<>();
        response.put("inquiries", inquiries);
        response.put("totalCount", totalCount);

        return new ResponseEntity<>(response, HttpStatus.OK);
    }

}