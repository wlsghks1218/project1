package org.hype.controller;

import org.hype.domain.exhImgVO;
import org.hype.domain.exhLikeVO;
import org.hype.domain.exhReplyVO;
import org.hype.domain.exhVO;
import org.hype.service.ExhibitionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.log4j.Log4j;

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
import java.util.stream.Collectors;

@Log4j
@Controller
@RequestMapping("/exhibition")
public class ExhibitionController {

	@Autowired
	private ExhibitionService exhibitionService;

	// 초기 페이지 요청 시 첫 번째 페이지 데이터만 가져오기
	@GetMapping("/exhibitionMain")
	public String exhibitionMain(Model model, @RequestParam(value = "filter", defaultValue = "latest") String filter,
			String query) {

		int pageSize = 5; // 한 페이지에 표시할 전시 개수
		List<exhVO> exhibitions = exhibitionService.getExhibitionsByPage(1, pageSize, filter, query);
		log.info("Exhibitions retrieved for page 1 with filter '" + filter + "': " + exhibitions.size());
		model.addAttribute("exhibitions", exhibitions);
		model.addAttribute("selectedFilter", filter);
		model.addAttribute("sentQuery", query);
		return "/exhibition/exhibitionMainPage";
	}

	// "더보기" 요청 시 추가 페이지 데이터 가져오기
	@GetMapping(value = "/exhibitionPage", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public List<exhVO> getExhibitionPage(@RequestParam("page") int page,
			@RequestParam(value = "filter", defaultValue = "latest") String filter,
			@RequestParam(value = "query", required = false) String query) {

		int pageSize = 5; // 한 페이지에 표시할 전시회 수
		List<exhVO> exhibitions = exhibitionService.getExhibitionsByPage(page, pageSize, filter, query);

		log.info("Exhibitions retrieved for page " + page + " with filter '" + filter + "' and query '" + query + "': "
				+ exhibitions.size());
		return exhibitions;
	}
	
	@GetMapping(value = "/popularExhs", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public List<exhImgVO> getPopularExhs() {
	   
	    List<exhImgVO> exhibitions = exhibitionService.getPopularExhs();
	    return exhibitions;
	}
	
	@GetMapping(value = "/exhbannerImg", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public List<exhImgVO> getExhbannerImg() {
	   
	    List<exhImgVO> exhibitions = exhibitionService.getExhBannerImg();
	    return exhibitions;
	}
	
	@GetMapping(value = "/exhImg", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public List<exhImgVO> getExhImg(@RequestParam("exhNo") int exhNo) {

	    List<exhImgVO> exhibitions = exhibitionService.getExhImg(exhNo);
	    return exhibitions;
	}
	
	@GetMapping(value = "/exhDetailImg", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public List<exhImgVO> getExhDetailImg(@RequestParam("exhNo") int exhNo) {
		
		List<exhImgVO> exhibitions = exhibitionService.getExhDetailImg(exhNo);
		return exhibitions;
	}
	
	@GetMapping("/popularExhs/{fileName:.+}")
	@ResponseBody
	public ResponseEntity<Resource> popularExhImage(@PathVariable String fileName) throws MalformedURLException {
	    
	    String[] parts = fileName.split("_", 2);
	    if (parts.length != 2) {
	        throw new RuntimeException("파일 이름 형식이 잘못되었습니다. 형식: uuid_fileName");
	    }
	    String uuid = parts[0];  
	    String originalFileName = parts[1];  

	    // 파일이 저장된 경로
	    String uploadFolder = "\\\\192.168.0.129\\storeGoodsImg\\전시회 배너 사진";
	    String imagePath = uploadFolder + File.separator + uuid + "_" + originalFileName;
	    Path path = Paths.get(imagePath);

	    // 경로 로그로 출력 (디버깅용)
	    System.out.println("이미지 경로: " + path.toString());

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
	
	
	@GetMapping("/exhibitionsBannerImages/{fileName:.+}")
	@ResponseBody
	public ResponseEntity<Resource> serveBannerImage(@PathVariable String fileName) throws MalformedURLException {
		String[] parts = fileName.split("_", 2);
	    if (parts.length != 2) {
	        throw new RuntimeException("파일 이름 형식이 잘못되었습니다. 형식: uuid_fileName");
	    }
	    String uuid = parts[0];  
	    String originalFileName = parts[1];  

	    // 파일이 저장된 경로
	    String uploadFolder = "\\\\192.168.0.129\\storeGoodsImg\\전시회 배너 사진";
	    String imagePath = uploadFolder + File.separator + uuid + "_" + originalFileName;
	    Path path = Paths.get(imagePath);

	    // 경로 로그로 출력 (디버깅용)
	    System.out.println("이미지 경로: " + path.toString());

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
    
    @GetMapping("/exhibitionImages/{fileName:.+}")
    @ResponseBody
    public ResponseEntity<Resource> serveImage(@PathVariable String fileName) throws MalformedURLException {
    	String[] parts = fileName.split("_", 2);
	    if (parts.length != 2) {
	        throw new RuntimeException("파일 이름 형식이 잘못되었습니다. 형식: uuid_fileName");
	    }
	    String uuid = parts[0];  
	    String originalFileName = parts[1];  

	    // 파일이 저장된 경로
	    String uploadFolder = "\\\\192.168.0.129\\storeGoodsImg\\전시회 배너 사진";
	    String imagePath = uploadFolder + File.separator + uuid + "_" + originalFileName;
	    Path path = Paths.get(imagePath);

	    // 경로 로그로 출력 (디버깅용)
	    System.out.println("이미지 경로: " + path.toString());

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
    
    @GetMapping("/exhibitionDetailImages/{fileName:.+}")
    @ResponseBody
    public ResponseEntity<Resource> serveDetailImage(@PathVariable String fileName) throws MalformedURLException {
    	String[] parts = fileName.split("_", 2);
    	if (parts.length != 2) {
    		throw new RuntimeException("파일 이름 형식이 잘못되었습니다. 형식: uuid_fileName");
    	}
    	String uuid = parts[0];  
    	String originalFileName = parts[1];  
    	
    	// 파일이 저장된 경로
    	String uploadFolder = "\\\\192.168.0.129\\storeGoodsImg\\전시회 상세 사진";
    	String imagePath = uploadFolder + File.separator + uuid + "_" + originalFileName;
    	Path path = Paths.get(imagePath);
    	
    	// 경로 로그로 출력 (디버깅용)
    	System.out.println("이미지 경로: " + path.toString());
    	
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
		return "/exhibition/exhibitionDetailPage";
	}

	@ResponseBody
	@PostMapping("/addLike")
	public ResponseEntity<String> addLike(@RequestBody exhLikeVO exhLikeVO) {
		try {
			exhibitionService.insertLike(exhLikeVO);
			return ResponseEntity.ok("좋아요가 등록되었습니다.");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("좋아요 등록 실패: " + e.getMessage());
		}
	}

	@ResponseBody
	@PostMapping("/removeLike")
	public ResponseEntity<String> removeLike(@RequestBody exhLikeVO exhLikeVO) {
		try {
			exhibitionService.removeExhLike(exhLikeVO);
			return ResponseEntity.ok("좋아요가 삭제되었습니다.");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("좋아요 삭제 실패: " + e.getMessage());
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

	@GetMapping(value = "/checkUserReview", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> checkUserReview(@RequestParam int exhNo, @RequestParam int userNo) {
		boolean hasReview = exhibitionService.hasUserReviewed(exhNo, userNo);
		Map<String, Object> response = new HashMap<>();
		response.put("hasReview", hasReview);

		return ResponseEntity.ok(response);
	}

	@ResponseBody
	@PostMapping("/addReview")
	public ResponseEntity<String> addReview(@RequestBody exhReplyVO exhReplyVO) {

		boolean success = exhibitionService.saveReview(exhReplyVO);
		if (success) {
			return ResponseEntity.ok("댓글이 등록되었습니다.");
		} else {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("댓글 등록에 실패했습니다.");
		}

	}

	@GetMapping(value = "/userReviews", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Map<String, Object> getUserReviews(@RequestParam("exhNo") int exhNo,
			@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "pageSize", defaultValue = "5") int pageSize) {
		int startRow = (page - 1) * pageSize;
		int endRow = page * pageSize;

		List<exhReplyVO> reviews = exhibitionService.getUserReviews(exhNo, startRow, endRow);
		int totalReviews = exhibitionService.getTotalReviewCount(exhNo); // 총 리뷰 개수 (페이징을 위한)

		Map<String, Object> response = new HashMap<>();
		response.put("reviews", reviews);
		response.put("totalPages", (int) Math.ceil(totalReviews / (double) pageSize)); // 페이지 계산
		return response;
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
	public ResponseEntity<Void> deleteComment(@RequestParam("userNo") int userNo,
			@RequestParam("exhReplyNo") int exhReplyNo) {
		boolean isDeleted = exhibitionService.deleteComment(userNo, exhReplyNo);
		return isDeleted ? ResponseEntity.ok().build() : ResponseEntity.notFound().build();
	}

	@ResponseBody
	@GetMapping(value = "/getAverageRating", produces = MediaType.APPLICATION_JSON_VALUE)
	public Double getAverageRating(@RequestParam Integer exhNo) {
		return exhibitionService.getAverageRating(exhNo);
	}
}