package org.hype.controller;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hype.domain.gCatVO;
import org.hype.domain.gImgVO;
import org.hype.domain.goodsVO;
import org.hype.domain.likedPopImgVO;
import org.hype.domain.pImgVO;
import org.hype.service.GoodsService;
import org.hype.service.PopUpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
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
@RequestMapping("/hypePop")
public class PopUpRestController {
	
	@Autowired private PopUpService service;
			
	 // 파일을 반환하는 API
    @GetMapping("/images/{fileName:.+}")
    public ResponseEntity<Resource> servePopUpImage(@PathVariable String fileName) throws IOException {
        // 실제 파일 경로 설정
    	System.out.println("파일 이름은 : " + fileName);
        String uploadFolder = "\\\\192.168.0.129\\storeGoodsImg\\팝업스토어 사진";
        String imagePath = uploadFolder + "\\" + fileName;
        Path path = Paths.get(imagePath);

        // 파일이 존재하지 않으면 404 반환
        if (!Files.exists(path)) {
            return ResponseEntity.notFound().build();
        }

        // 파일을 읽을 수 없으면 403 반환
        if (!Files.isReadable(path)) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }

        // 파일 시스템에서 이미지를 읽어서 Resource 객체로 변환
        Resource file = new FileSystemResource(path.toFile());

        // MIME 타입 자동 추출
        String contentType = Files.probeContentType(path);

        // Content-Type을 설정하여 적절한 형식으로 이미지 제공
        return ResponseEntity.ok()
            .contentType(MediaType.parseMediaType(contentType != null ? contentType : "application/octet-stream"))
            .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + fileName + "\"")
            .body(file);
    }
    // psNo를 기반으로 이미지 데이터(uuid, filename)를 반환하는 API
    @GetMapping("/getImageData")
    @ResponseBody
    public ResponseEntity<pImgVO> getImageData(@RequestParam int psNo) {
        System.out.println("이미지를 위해 받아온 psNo는? : " + psNo);
        try {
            pImgVO imageInfo = service.getImageByStoreId(psNo);  // 서비스에서 psNo에 맞는 이미지 정보 조회

            if (imageInfo == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);  // 이미지 정보가 없으면 404 반환
            }

            // 이미지 UUID와 파일명 반환 (JSON 형식으로 반환)
            return ResponseEntity.ok(imageInfo);
        } catch (Exception e) {
            log.error("이미지 정보 가져오기 실패: ", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);  // 오류 발생 시 500 반환
        }
    }
    @PostMapping(value = "/checkUserLiked", produces = "application/json")
    @ResponseBody
    public ResponseEntity<Map<String, Boolean>> checkUserLiked(@RequestBody likedPopImgVO likeRequest) {
        try {
        	
        	System.out.println("서버에서 받은 PSNO USERNO : " +likeRequest.getPsNo() );
        	System.out.println("서버에서 받은 PSNO USERNO : " +likeRequest.getUserNo() );
        	
            boolean isLiked = service.checkUserLiked(likeRequest.getPsNo(), likeRequest.getUserNo());
            
            // 'liked'라는 이름의 boolean 값을 반환
            Map<String, Boolean> response = new HashMap<>();
            response.put("liked", isLiked);
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            // 오류 발생 시 'liked' 값을 false로 반환
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("liked", false));
        }
    }
   
    @GetMapping(value = "/getStoreAvg", produces = "application/json")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getStoreAverageRating(@RequestParam int psNo) {
        System.out.println("별점 평균을 요청받은 PSNO : " + psNo);
        try {
            // 서비스에서 해당 psNo의 평균 별점 가져오기
            Double averageRating = service.getAvgRating(psNo);

            // 성공 시 평균 별점 데이터를 반환
            return ResponseEntity.ok(Map.of(
                "status", "success",
                "averageRating", averageRating
            ));
        } catch (Exception e) {
            log.error("평균 별점 가져오기 실패: ", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of(
                "status", "error",
                "message", "서버 오류로 데이터를 가져오지 못했습니다."
            ));
        }
    }
}
