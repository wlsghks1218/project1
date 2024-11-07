package org.hype.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hype.domain.gReplyVO;
import org.hype.service.GReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.log4j.Log4j;

@Log4j
@RestController
@RequestMapping("/gReply/")
public class GReplyController {
    
    @Autowired
    private GReplyService gService;
    
    @PostMapping(value = "/new", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
    public ResponseEntity<String> replyInsert(@RequestBody gReplyVO vo) {
        int resultInsert = gService.insertGReply(vo);
		return resultInsert == 1 ?
				new ResponseEntity<String>("success", HttpStatus.OK) : 
				new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @GetMapping(value = "/{gno}/{userNo}/{page}/{size}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String, Object>> getReplyListWithPaging(
            @PathVariable("gno") int gno, 
            @PathVariable("userNo") int userNo,
            @PathVariable("page") int page, 
            @PathVariable("size") int size) {
        
        Map<String, Object> response = new HashMap<>();
        Object myReply = gService.getMyReply(gno, userNo);
        int offset = (page - 1) * size;
        
        List<gReplyVO> replyList = gService.getAllReplyListWithPaging(gno, userNo, offset, size);
        
        int totalReplies = gService.getReplyCount(gno, userNo);
        
        for (gReplyVO vo : replyList) {
            int greplyNo = vo.getGreplyNo();
        }
        
        response.put("myReply", myReply);
        response.put("replyList", replyList);
        response.put("totalReplies", totalReplies);
        
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
    
    @GetMapping(value = "/avgStars/{gno}", produces = MediaType.TEXT_PLAIN_VALUE)
    public ResponseEntity<String> goodsAvgStars(@PathVariable("gno") int gno) {
        double avgStars = gService.getAvgStars(gno);
        String avgStarsString = String.valueOf(avgStars);
        return new ResponseEntity<>(avgStarsString, HttpStatus.OK);
    }
    
    @GetMapping(value = "/chkReplied/{userNo}/{gno}", produces = MediaType.TEXT_PLAIN_VALUE)
    public ResponseEntity<String> chkReplied(@PathVariable("userNo") int userNo, @PathVariable("gno") int gno){
    	log.warn("aaaaaaaaaaaa" + userNo + gno);
    	String result = gService.chkReplied(userNo, gno);
    	log.warn("result가 여기 표시됨 : " + result );
    	return new ResponseEntity<>(result, HttpStatus.OK);
    }
    
    @DeleteMapping(value = "/deleteReply/{gno}/{userNo}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Integer> deleteReply(@PathVariable("gno") int gno, @PathVariable("userNo") int userNo){
    	int result = gService.deleteReply(gno, userNo);
    	return new ResponseEntity<>(result, HttpStatus.OK);
    }
    
    @PutMapping(value = "/updateReply", produces = MediaType.TEXT_PLAIN_VALUE)
    public ResponseEntity<String> updateReply(@RequestBody gReplyVO vo) {
        try {
            int result = gService.updateReply(vo);
            if (result == 1) {
                return ResponseEntity.ok("success");
            } else {
                return ResponseEntity.status(500).body("failure");
            }
        } catch (Exception e) {
            return ResponseEntity.status(500).body("error");
        }
    }
    @GetMapping(value = "/getGreplyReviews", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody // JSON으로 응답하기 위해 추가
    public ResponseEntity<Map<String, Object>> getGreplyReviews(@RequestParam int userNo) {
        Map<String, Object> response = new HashMap<>();
        try {
            Map<String, Object> result = gService.getGreplyReviews(userNo);

            if (result == null) {
                throw new NullPointerException("Service returned null result");
            }

            List<gReplyVO> greplies = (List<gReplyVO>) result.get("greplies");
            List<String> gnames = (List<String>) result.get("gnames");

            if (greplies == null || gnames == null) {
                throw new NullPointerException("No greplies or gnames found");
            }
            if (greplies.size() != gnames.size()) {
                throw new IllegalArgumentException("Mismatch in size between greplies and gnames");
            }

            List<Map<String, Object>> greplyList = new ArrayList<>();
            for (int i = 0; i < greplies.size(); i++) {
                gReplyVO greply = greplies.get(i);
                Map<String, Object> greplyData = new HashMap<>();
                greplyData.put("gno", greply.getGno());
                greplyData.put("gname", gnames.get(i));
                greplyData.put("gcomment", greply.getGcomment());
                greplyData.put("gregDate", greply.getGregDate());
                greplyList.add(greplyData);
            }

            response.put("greplies", greplyList);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            log.error("Error retrieving popup reviews", e);
            response.put("error", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }

    
}
}