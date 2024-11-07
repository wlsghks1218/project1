package org.hype.controller;

import org.hype.domain.exhLikeVO;
import org.hype.domain.exhReplyVO;
import org.hype.domain.exhVO;
import org.hype.service.ExhibitionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.log4j.Log4j;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Log4j
@Controller
@RequestMapping("/exhibition")
public class ExhibitionController {
    
    @Autowired
    private ExhibitionService exhibitionService;

    // 초기 페이지 요청 시 첫 번째 페이지 데이터만 가져오기
    @GetMapping("/exhibitionMain")
    public String exhibitionMain(Model model) {
        int pageSize = 5; // 한 페이지에 표시할 전시 개수
        List<exhVO> exhibitions = exhibitionService.getExhibitionsByPage(1, pageSize); // 첫 페이지만 가져오기
        log.info("Exhibitions retrieved for page 1: " + exhibitions.size());
        model.addAttribute("exhibitions", exhibitions);
        return "/popUpExhibition/exhibitionMainPage";
    }

    // "더보기" 요청 시 추가 페이지 데이터 가져오기
    @GetMapping(value = "/exhibitionPage", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<exhVO> getExhibitionPage(@RequestParam("page") int page) {
        int pageSize = 5;
        List<exhVO> exhibitions = exhibitionService.getExhibitionsByPage(page, pageSize);
        log.info("Exhibitions retrieved for page " + page + ": " + exhibitions.size());
        return exhibitions;
    }
    
    @GetMapping("/exhibitionDetail")
    public String exhibitionDetail(@RequestParam("exhNo") int exhNo, Model model) {

        exhVO exhibition = exhibitionService.getExhibitionByNo(exhNo);
        if (exhibition != null) {
            model.addAttribute("exhibition", exhibition);
            log.info("Exhibition details retrieved for exhNo: " + exhNo);
        } else {
            log.warn("No exhibition found with exhNo: " + exhNo);
            model.addAttribute("errorMessage", "전시회를 찾을 수 없습니다.");
        }
        return "/popUpExhibition/exhibitionDetailPage"; 
    }

    @ResponseBody
    @PostMapping("/addLike")
    public ResponseEntity<String> addLike(@RequestBody exhLikeVO exhLikeVO) {
        try {
        	exhibitionService.insertLike(exhLikeVO);
            return ResponseEntity.ok("좋아요가 등록되었습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                 .body("좋아요 등록 실패: " + e.getMessage());
        }
    }
    
    @ResponseBody
    @PostMapping("/removeLike")
    public ResponseEntity<String> removeLike(@RequestBody exhLikeVO exhLikeVO) {
        try {
        	exhibitionService.removeExhLike(exhLikeVO);
            return ResponseEntity.ok("좋아요가 삭제되었습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                 .body("좋아요 삭제 실패: " + e.getMessage());
        }
    }
    
    @ResponseBody
    @GetMapping(value = "/likeStatus", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Boolean> getLikeStatus(@RequestParam("exhNo") int exhNo, @RequestParam("userNo") int userNo) {
        boolean isLiked = exhibitionService.isLiked(exhNo, userNo);
        return ResponseEntity.ok(isLiked);
    }
    
    @ResponseBody
    @GetMapping(value = "/likeCount", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Integer> getLikeCount(@RequestParam("exhNo") int exhNo) {
        int count = exhibitionService.getLikeCount(exhNo);
        return ResponseEntity.ok(count);
    }
    
    
    @ResponseBody
    @PostMapping("/addReview")
    public ResponseEntity<String> addReview(@RequestBody exhReplyVO exhReplyVO) {
        try {

            exhibitionService.saveReview(exhReplyVO);
            return ResponseEntity.ok("후기가 등록되었습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("후기 등록 실패: " + e.getMessage());
        }
    }
    @ResponseBody
    @GetMapping(value = "/userReviews", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<exhReplyVO> getUserReviews() {
        return exhibitionService.getAllReplies(); 
    }
    
    @PutMapping("/updateReview")
    public ResponseEntity<?> updateReview(@RequestBody exhReplyVO exhReplyVO) {
        boolean isUpdated = exhibitionService.updateReview(exhReplyVO);

        if (isUpdated) {
            return ResponseEntity.ok("후기가 성공적으로 수정되었습니다.");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("후기 수정에 실패했습니다.");
        }
    }
    
    @GetMapping("/deleteComment")
    public ResponseEntity<Void> deleteComment(@RequestParam("userNo") int userNo, @RequestParam("exhReplyNo") int exhReplyNo) {
        boolean isDeleted = exhibitionService.deleteComment(userNo, exhReplyNo);
        return isDeleted ? ResponseEntity.ok().build() : ResponseEntity.notFound().build();
    }
}