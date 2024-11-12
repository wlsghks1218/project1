package org.hype.controller;

import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.apache.ibatis.annotations.Param;
import org.hype.domain.likeVO;
import org.hype.domain.mCatVO;
import org.hype.domain.signInVO;
import org.hype.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.web.bind.annotation.*;

import lombok.extern.log4j.Log4j;

@Log4j
@RestController
@RequestMapping("/member/api")
public class MemberRestController {

   @Autowired
   private MemberService memberService;

   @Autowired
   private JavaMailSenderImpl mailSender;

   private static String authCode;

   @GetMapping("/checkUserId")
   public ResponseEntity<String> checkUserId(String userId) {
      log.info("userId : " + userId);
      boolean isDuplicate = memberService.checkDuplicateId(userId);
      log.info("isDuplicate : " + isDuplicate);

      if (isDuplicate) {
         return new ResponseEntity<>("no", HttpStatus.ACCEPTED);
      } else {
         return new ResponseEntity<>("ok", HttpStatus.OK);
      }
   }


    @GetMapping("/getPolicyContent")
    public ResponseEntity<String> getPolicyContent(@RequestParam String type) {
        String content = ""; // Initialize content

        switch (type) {
            case "privacy":
                content += "<h2>개인정보 처리방침</h2>"
                        + "<p>본 개인정보 처리방침은 귀하의 개인정보가 어떻게 수집, 사용, 저장 및 보호되는지를 설명합니다.</p>"
                        + "<h3>1. 개인정보의 수집</h3>"
                        + "<p>우리는 회원가입 및 서비스 이용 과정에서 다음과 같은 개인정보를 수집합니다:</p>"
                        + "<ul>"
                        + "<li>이름</li>"
                        + "<li>이메일 주소</li>"
                        + "<li>전화번호</li>"
                        + "<li>사용자 ID 및 비밀번호</li>"
                        + "</ul>"
                        + "<h3>2. 개인정보의 사용</h3>"
                        + "<p>우리는 수집된 개인정보를 다음과 같은 목적으로 사용합니다:</p>"
                        + "<ul>"
                        + "<li>회원 관리 및 서비스 제공</li>"
                        + "<li>이벤트 및 프로모션 정보 제공</li>"
                        + "<li>고객 상담 및 민원 처리</li>"
                        + "</ul>"
                        + "<h3>3. 개인정보의 보관 및 보호</h3>"
                        + "<p>우리는 귀하의 개인정보를 안전하게 보호하며, 정해진 기간 동안만 보관합니다.</p>"
                        + "<h3>4. 개인정보의 제3자 제공</h3>"
                        + "<p>우리는 귀하의 동의 없이 개인정보를 제3자에게 제공하지 않습니다.</p>"
                        + "<h3>5. 개인정보 보호 책임자</h3>"
                        + "<p>개인정보 보호와 관련하여 궁금한 사항은 다음의 담당자에게 문의해 주시기 바랍니다:</p>"
                        + "<p>담당자: hypepop</p>"
                        + "<p>연락처: hypepop@hypepop.com</p>"
                        + "<h3>6. 본 방침의 변경</h3>"
                        + "<p>본 개인정보 처리방침은 변경될 수 있으며, 변경 사항은 즉시 공지합니다.</p>"
                        + "<p>마지막 업데이트: 2024년 10월 18일</p>";
                break;
            case "location":
                content += "<div id='locationModal' class='modal'>" +
                        "<div class='modal-content'>" +
                        "<span class='close' onclick=\"closeModal('locationModal')\">&times;</span>" +
                        "<div id='modalContent'>" +
                        "<h1>위치기반 서비스 이용약관</h1>" +
                        "<h2>제 1 조 (목적)</h2>" +
                        "<p>이 약관은 hypepop(이하 “회사”)가 제공하는 위치기반서비스와 관련하여 회사와 개인위치정보주체와의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.</p>" +
                        // ... (Add remaining content here)
                        "</div></div></div>";
                break;
            case "notification":
                content += "<h2>마케팅 알림 동의</h2>"
                        + "<p>회사는 귀하에게 마케팅 관련 알림을 보내기 위해 사전에 귀하의 동의를 받습니다. 법률에 따라 동의가 필요한 경우, 우리는 귀하의 개인 정보를 보호하고 안전하게 처리합니다.</p>"
                        + "<h3>1. 마케팅 알림의 수신 동의</h3>"
                        + "<p>마케팅 알림은 이메일, SMS, 앱 알림 등의 방법으로 전송될 수 있습니다. 귀하의 동의가 없이는 마케팅 알림을 전송하지 않습니다.</p>"
                        + "<h3>2. 동의 철회</h3>"
                        + "<p>귀하는 언제든지 마케팅 알림 수신에 대한 동의를 철회할 수 있으며, 이 경우 더 이상 마케팅 알림을 받지 않게 됩니다.</p>"
                        + "<h3>3. 문의</h3>"
                        + "<p>마케팅 알림과 관련하여 문의사항이 있을 경우, 아래의 연락처로 문의해 주시기 바랍니다:</p>";
                break;
            default:
                content = "유효하지 않은 요청입니다.";
                break;
        }

        return ResponseEntity.ok()
                .contentType(MediaType.valueOf("text/html; charset=UTF-8")) // 적절한 미디어 타입 설정
                .body(content);
    }
    
    

    

   // 이메일로 인증코드 전송
   @RequestMapping(value = "/sendMail/{userEmail}", method = RequestMethod.GET)
   public ResponseEntity<String> sendMailTest(@PathVariable String userEmail) {
      System.out.println("이메일 전송 요청 수신: " + userEmail); // 요청 로그
      authCode = String.valueOf((int) (Math.random() * 900000) + 100000); // 랜덤 인증 코드 생성
      String subject = "test 인증 코드";
      String content = authCode;
      String from = mailSender.getUsername(); // 보내는 이메일
      //String to = userEmail;
      String to = userEmail+ ".com"; // 받는 이메일 (수정: .com 제거)
      System.out.println(to);
      
      try {
         MimeMessage mail = mailSender.createMimeMessage();
         MimeMessageHelper mailHelper = new MimeMessageHelper(mail, "UTF-8");

         mailHelper.setFrom(from);
         mailHelper.setTo(to);
         mailHelper.setSubject(subject);
         mailHelper.setText(content, false);

         mailSender.send(mail);
         return ResponseEntity.ok("ok");
      } catch (MessagingException e) {
         e.printStackTrace();
         return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("fail");
      } catch (Exception e) {
         e.printStackTrace();
         return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("fail");
      }
   }

   // 인증코드 확인
   @GetMapping("/verifyCode")
   public ResponseEntity<String> verifyEmailCode(@RequestParam String code) {
      if (authCode != null && authCode.equals(code)) {
         return ResponseEntity.ok("ok");
      } else {
         return ResponseEntity.ok("fail");
      }
   }

   // 마이페이지 관심사 변경
   @PostMapping(value = "/updateUserInterests", produces = "application/json; charset=UTF-8")
   public ResponseEntity<Map<String, Object>> updateUserInterests(@RequestParam("userNo") int userNo, @ModelAttribute mCatVO mcvo) {
       log.warn("mcvo : " + mcvo.getGame());
       log.warn("mcvo : " + mcvo.getCulture());
       log.warn("mcvo : " + mcvo.getShopping());

       Map<String, Object> response = new HashMap<>();
       try {
           // 서비스 메소드 호출로 관심사 변경
           memberService.changeUserInterest(userNo, mcvo);
           
           // 변경된 관심사 조회
           mCatVO updatedInterests = memberService.selectMyInterest(userNo);

           // 응답에 메시지와 함께 변경된 관심사 반환
           response.put("message", "관심사가 성공적으로 업데이트되었습니다.");
           response.put("updatedInterests", updatedInterests);  // 변경된 관심사를 응답에 추가
           return ResponseEntity.ok(response);
       } catch (Exception e) {
           log.error("Error updating interests", e);
           response.put("error", "업데이트 중 문제가 발생했습니다.");
           return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
       }
   }



   // 메소드 레벨에서 @DeleteMapping 사용
   @DeleteMapping(value = "/removePopup/{psNo}", produces = MediaType.TEXT_PLAIN_VALUE)
   public ResponseEntity<String> removePopup(@PathVariable("psNo") int psNo, @RequestParam(value = "userNo") int userNo) {
      log.info("psno,usno:" + userNo + psNo);
      int deleted = memberService.pLikeListDelete(userNo,psNo);

      if (deleted > 0) { // deleted가 0보다 크면 성공
         return ResponseEntity.ok("ok");
      } else {
         return ResponseEntity.status(HttpStatus.NOT_FOUND).body("fail"); // 삭제할 데이터가 없는 경우
      }
   }
   
   
   @DeleteMapping(value = "/removeGoods/{gno}", produces = MediaType.TEXT_PLAIN_VALUE)
   public ResponseEntity<String> removeGoods(@PathVariable("gno") int gno, @RequestParam(value = "userNo") int userNo) {
      int deleted = memberService.gLikeListDelete(userNo,gno);

      if (deleted > 0) { // deleted가 0보다 크면 성공
         return ResponseEntity.ok("ok");
      } else {
         return ResponseEntity.status(HttpStatus.NOT_FOUND).body("fail"); // 삭제할 데이터가 없는 경우
      }
   }

   
   //로그인 아이디 찾기 이메일 일치 여부
   @PostMapping("/checkEmail")
   public ResponseEntity<String> checkEmail(@RequestBody signInVO svo) {
      
      log.info("signInVO svo : " + svo);
      
      if (svo == null || svo.getUserEmail() == null || svo.getUserName() == null) {
         return ResponseEntity.badRequest().body("Invalid input");
      }
      boolean exists = memberService.checkEmail(svo);
      
      if (exists) {
         return ResponseEntity.ok("exists");
      } else {
         return ResponseEntity.ok("not_exists");
      }
   }
   
   
   
   
   @GetMapping("/confirmId")
   public ResponseEntity<String> confirmId(@RequestParam String userId) {
      
      log.info("Searching for userId: " + userId); // 
      
      int result = memberService.searchId(userId);
      
      if(result>0) {
         return ResponseEntity.ok()
         .contentType(MediaType.APPLICATION_JSON_UTF8) // UTF-8로 설정
            .body("아이디가 존재합니다");
      } else {
         return ResponseEntity.status(HttpStatus.NOT_FOUND).body("fail");
      }
      
      
   }
   
   //로그인 비밀번호  찾기 이메일 일치 여부
   @PostMapping("/checkEmailSeachPw")
   public ResponseEntity<String> checkEmailPw(@RequestBody signInVO svo) {
      
      log.info("signInVO svo : " + svo);
      log.info("Received request: userEmail = " + svo.getUserEmail() + ", userId = " + svo.getUserId());

      if (svo == null || svo.getUserEmail() == null || svo.getUserId() == null) {
         return ResponseEntity.badRequest().body("Invalid input");
      }
      
      
      boolean exists = memberService.checkEmailPw(svo);
      log.info("exists:" + exists);
      
      if (exists) {
         return ResponseEntity.ok("exists");
      } else {
         return ResponseEntity.ok("not_exists");
      }
   }
   
   //로그인
   @PostMapping(value = "/login", produces = MediaType.APPLICATION_JSON_VALUE)
   @ResponseBody
   public ResponseEntity<Map<String, Object>> login(@RequestBody signInVO svo) {
       signInVO member = memberService.loginMember(svo);

       Map<String, Object> response = new HashMap<>();
       if (member != null) {
           response.put("status", "success");
           response.put("userNo", member.getUserNo()); // userNo를 응답에 포함
           return ResponseEntity.ok(response);
       } else {
           response.put("status", "error");
           response.put("message", "로그인 오류입니다.");
           return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
       }
   }
   
   //마이페이지 좋아요한 팝업스토어 이미지 가져오기
    @GetMapping("/images/{fileName:.+}")
    @ResponseBody
    public ResponseEntity<Resource> serveImage(@PathVariable String fileName) throws MalformedURLException {
       log.info(fileName);
       
       
   
       String imagePath = "\\\\192.168.0.129\\storeGoodsImg\\" + fileName;
      
        Path path = Paths.get(imagePath);  // Convert the image path to a Path object
        
        if (!Files.exists(path)) {
            throw new RuntimeException("파일이 없어여: " + fileName);  // Handle case when file does not exist
        }
        if (!Files.isReadable(path)) {
            throw new RuntimeException("파일을 읽을 수 없어요: " + fileName);  // Handle case when file is not readable
        }
        Resource file = new FileSystemResource(path.toFile());
        return ResponseEntity.ok()
            .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + fileName + "\"")
            .body(file);
    }
   

}
