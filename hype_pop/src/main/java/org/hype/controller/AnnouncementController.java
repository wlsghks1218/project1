//package org.hype.controller;
//
//import java.util.List;
//
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.*;
//
//import lombok.extern.log4j.Log4j;
//
//@Log4j
//@RestController
//@RequestMapping("/announcement")
//public class AnnouncementController {
//
//
//
//    // 1. 공지사항 목록 조회
//    @GetMapping(value = "/list", produces = "application/json")
//    public ResponseEntity<List<AnnouncementVO>> getAnnouncements() {
//        log.info("공지사항 목록 조회");
//        List<AnnouncementVO> announcements = announcementService.getAllAnnouncements();
//        return new ResponseEntity<>(announcements, HttpStatus.OK);
//    }
//
//    // 2. 공지사항 내용 조회
//    @GetMapping(value = "/{id}", produces = "application/json")
//    public ResponseEntity<AnnouncementVO> getAnnouncement(@PathVariable("id") Long id) {
//        log.info("공지사항 내용 조회: " + id);
//        AnnouncementVO announcement = announcementService.getAnnouncementById(id);
//        return new ResponseEntity<>(announcement, HttpStatus.OK);
//    }
//
//    // 3. 제목으로 공지사항 검색
//    @GetMapping(value = "/search", produces = "application/json")
//    public ResponseEntity<List<AnnouncementVO>> searchAnnouncements(@RequestParam("title") String title) {
//        log.info("제목으로 공지사항 검색: " + title);
//        List<AnnouncementVO> announcements = announcementService.searchByTitle(title);
//        return new ResponseEntity<>(announcements, HttpStatus.OK);
//    }
//
//    // 4. 문의 작성 페이지로 이동
//    @GetMapping("/inquiry/write")
//    public String writeInquiryPage() {
//        log.info("문의 작성 페이지로 이동");
//        return "/inquiry/write"; 
//    }
//
//    // 5. 문의 등록 처리
//    @PostMapping("/inquiry/submit")
//    public ResponseEntity<String> submitInquiry(@RequestBody InquiryVO inquiry) {
//        log.info("문의 등록 처리: " + inquiry);
//        int insertCount = inquiryService.registerInquiry(inquiry);
//        return insertCount == 1 ? 
//            new ResponseEntity<>("success", HttpStatus.OK) :
//            new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//    }
//
//    // 6. 내 문의 제목 조회
//    @GetMapping("/inquiry/myTitles/{userNo}")
//    public ResponseEntity<List<String>> getMyInquiryTitles(@PathVariable("userId") Long userId) {
//        log.info("내 문의 제목 조회: " + userId);
//        List<String> titles = inquiryService.getMyInquiryTitles(userId);
//        return new ResponseEntity<>(titles, HttpStatus.OK);
//    }
//
//    // 7. 내 문의 내용 전부 조회
//    @GetMapping("/inquiry/myAll/{userNo}")
//    public ResponseEntity<List<InquiryVO>> getMyInquiries(@PathVariable("userId") Long userId) {
//        log.info("내 문의 내용 전부 조회: " + userId);
//        List<InquiryVO> inquiries = inquiryService.getMyInquiries(userId);
//        return new ResponseEntity<>(inquiries, HttpStatus.OK);
//    }
//}
