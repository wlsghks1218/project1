package org.hype.controller;





import java.util.List;

import org.hype.domain.gImgVO;
import org.hype.domain.likedGoodsImgVO;
import org.hype.domain.likedPopImgVO;
import org.hype.domain.mCatVO;
import org.hype.domain.pImgVO;
import org.hype.domain.signInVO;
import org.hype.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/member/*")
public class MemberController {
   
   @Autowired
   private MemberService mservice;
   


   
   //로그인페이지로 이동
   @GetMapping("/login")
   public String login() {
   
      
      
         return "member/login";
      }
   
   
   //로그인 처리
   @PostMapping("/login")
   public String login(signInVO svo, Model model) {
   
   signInVO member = mservice.loginMember(svo);
   
   if (member != null) {       
        return "popUp/popUpMain";
   }else {
   model.addAttribute("error", "로그인을 오류입니다.");
   return "member/login";
   }
}
   
   
   
    //회원가입
      @GetMapping("/join")
      public String joinPage() {
         log.info("join now");
         return "member/joinPage";
      } 

   //회원가입 처리
      @PostMapping("/join")
      public String join(signInVO svo, mCatVO mcvo) {
           
         
         log.warn("mcvo :" + mcvo.getGame());
         log.warn("mcvo :" + mcvo.getCulture());
         log.warn("mcvo :" + mcvo.getShopping());
         // 회원가입 처리
           mservice.joinMember(svo, mcvo);
           
           return "popUp/popUpMain";
   
      }


    // 마이페이지
    @GetMapping("/myPage")
    public String myPage(Model model, @RequestParam("userNo") int userNo) { 
        signInVO userInfo = mservice.selectMyPageInfo(userNo);
        mCatVO userInterests = mservice.selectMyInterest(userNo);
        List<likedPopImgVO> pLikeList = mservice.pLikeList(userNo);
        List<likedGoodsImgVO> gLikeList = mservice.gLikeList(userNo);
        System.out.println("gLikeList :"+ gLikeList);
        
        //회원 정보
        model.addAttribute("userInfo", userInfo);
        //유저의 관심사
        model.addAttribute("userInterests", userInterests);
        //좋아요 한 팝업스토어 
        model.addAttribute("pLikeList",pLikeList);
        //좋아요 한 굿즈 스토어
        model.addAttribute("gLikeList",gLikeList);
        
        for (likedGoodsImgVO goods : gLikeList) {
            System.out.println("gName: " + goods.getGname());
            System.out.println("gNo: " + goods.getGno());
            System.out.println("uploadPath: " + goods.getUploadPath());
            // 추가적으로 필요한 속성 출력
        }
        
        return "member/myPage"; 
    }

    // 비밀번호 변경
    @GetMapping("/passwordChange")
    public String passwordChange(@RequestParam(value = "userNo") int userNo, 
                                 @RequestParam("oldPw") String oldPw, 
                                 @RequestParam("newPw") String newPw) {
        log.info("비밀번호 변경: userNo=" + userNo);
        
        if (mservice.selectOldPw(userNo, oldPw) > 0) {
            mservice.updateNewPw(oldPw, newPw, userNo);
            return "/member/myPage";  // 성공 메시지 추가 필요
        }
        // 실패 시 메시지 추가 필요
        return "member/myPage"; 
    }
    
    
 // 이메일 변경
    @GetMapping("/emailChange")
    public String emailChange(@RequestParam(value = "userNo") int userNo, 
                              @RequestParam("newEmail") String newEmail,
                              Model model) {
        log.info("이메일 변경: userNo=" + userNo);
        log.info("이메일 변경: new Email=" + newEmail);

        // 이메일 변경 성공 시
        int updateCount = mservice.updateNewEmail(newEmail, userNo);
        
        if (updateCount > 0) {
            model.addAttribute("success", "이메일을 변경했습니다."); // 성공 메시지
        } else {
            model.addAttribute("error", "이메일 변경에 실패했습니다."); // 실패 메시지
        }

        return "redirect:/member/myPage?userNo=" + userNo;
    }
    
    
    //전화번호 변경
  
    @GetMapping("/phoneNumberChange")
    public String phoneNumberChange(@RequestParam(value = "userNo") int userNo, 
                                 @RequestParam("oldPhoneNumber") String oldPhoneNumber, 
                                 @RequestParam("newPhoneNumber") String newPhoneNumber,
                                 Model model) {
        log.info("비밀번호 변경: userNo=" + userNo);
        
        if (mservice.selectOldPhoneNum(userNo, oldPhoneNumber) > 0) {
            mservice.updateNewPhoneNum(oldPhoneNumber, newPhoneNumber, userNo);
            model.addAttribute("success", "비밀번호를 변경했습니다.");
            return "redirect:/member/myPage?userNo=" + userNo; // 성공 메시지 추가 필요
        }
        // 실패 시 메시지 추가 필요
        model.addAttribute("error", "비밀번호 변경에 실패했습니다."); 
        return "redirect:/member/myPage?userNo=" + userNo;
    }
    
    
    
    
    
    
    
    
    
    
   @GetMapping("/userReply")
   public String userReply() { 
      System.out.println("userReply..");
   return "/member/userReply"; 
   
   }
   
   @GetMapping("/myCart")
   public String myCart() { 
      
      System.out.println("myCart..");
      
   return "/purchase/myCart"; 
   
   }
   
   @GetMapping("/paymentList")
   public String paymentList() { 
      
      System.out.println("paymentList..");
      
   return "/purchase/paymentList"; 
   
   }


   
   

   
   
   /*---------------------------------------------------------------------------*/

   
    
    // 鍮꾨 踰덊샇 蹂 寃  泥섎━
    //  떎 젣 DB  뿰 룞怨  鍮꾨 踰덊샇  쑀 슚 꽦 寃  궗 뒗  꽌鍮꾩뒪 뿉 꽌 泥섎━ 븯寃   맗 땲 떎!
    // POST  슂泥  쑝濡   궗 슜 옄 쓽  깉濡쒖슫 鍮꾨 踰덊샇瑜  諛쏆븘 泥섎━ 븯寃   맗 땲 떎!
    @PostMapping("/updatePassword")
    public String updatePassword(@RequestParam("userId") String userId, 
                                 @RequestParam("currentPassword") String currentPassword, 
                                 @RequestParam("newPassword") String newPassword, Model model) {
        // 二쇱꽍:  쁽 옱 鍮꾨 踰덊샇媛  留욌뒗吏   솗 씤 븯 뒗 濡쒖쭅 씠  븘 슂
        // boolean isCurrentPasswordValid = memberService.checkPassword(userId, currentPassword);

        // 二쇱꽍:  깉 鍮꾨 踰덊샇濡   뾽 뜲 씠 듃 븯 뒗 濡쒖쭅 씠  븘 슂
        // if (isCurrentPasswordValid) {
        //     memberService.updatePassword(userId, newPassword);
        //     model.addAttribute("message", "鍮꾨 踰덊샇媛   꽦怨듭쟻 쑝濡  蹂 寃쎈릺 뿀 뒿 땲 떎.");
        //     return "/member/updateSuccess"; //  꽦怨   떆 寃곌낵  럹 씠吏 濡   씠 룞 븯寃   맗 땲 떎!
        // } else {
        //     model.addAttribute("error", " 쁽 옱 鍮꾨 踰덊샇媛   삱諛붾Ⅴ吏   븡 뒿 땲 떎.");
             return "/member/changePassword"; //  떎 뙣  떆  떎 떆 鍮꾨 踰덊샇 蹂 寃   럹 씠吏 濡   씠 룞 븯寃   맗 땲 떎!
        // }
    }

   

    //  쟾 솕踰덊샇 蹂 寃  泥섎━
    // POST  슂泥  쑝濡   궗 슜 옄 쓽  깉濡쒖슫  쟾 솕踰덊샇瑜  諛쏆븘 泥섎━
    @PostMapping("/updatePhone")
    public String updatePhone(@RequestParam("userId") String userId, 
                              @RequestParam("newPhone") String newPhone, Model model) {
        // 二쇱꽍:  쟾 솕踰덊샇瑜   뾽 뜲 씠 듃 븯 뒗 濡쒖쭅 씠  븘 슂
        // memberService.updatePhone(userId, newPhone);
        // model.addAttribute("message", " 쟾 솕踰덊샇媛   꽦怨듭쟻 쑝濡  蹂 寃쎈릺 뿀 뒿 땲 떎.");
         return "/member/updateSuccess"; //  꽦怨   떆 寃곌낵  럹 씠吏 濡   씠 룞
    }


    //  씠硫붿씪 蹂 寃  泥섎━
    // POST  슂泥  쑝濡   궗 슜 옄 쓽  깉濡쒖슫  씠硫붿씪 쓣 諛쏆븘 泥섎━
    @PostMapping("/updateEmail")
    public String updateEmail(@RequestParam("userId") String userId, 
                              @RequestParam("newEmail") String newEmail, Model model) {
        // 二쇱꽍:  씠硫붿씪 쓣  뾽 뜲 씠 듃 븯 뒗 濡쒖쭅 씠  븘 슂
        // memberService.updateEmail(userId, newEmail);
        // model.addAttribute("message", " 씠硫붿씪 씠  꽦怨듭쟻 쑝濡  蹂 寃쎈릺 뿀 뒿 땲 떎.");
         return "/member/updateSuccess"; //  꽦怨   떆 寃곌낵  럹 씠吏 濡   씠 룞 븯寃   맗 땲 떎!
    }
    // 醫뗭븘 슂 븳  뙘 뾽 뒪 넗 뼱 紐⑸줉  쓣 썙二쇰뒗 硫붿꽌 뱶
    @GetMapping("/likedPopUpStores")
    public String getLikedPopUpStores(@RequestParam("userId") String userId, Model model) {
        log.info("醫뗭븘 슂 븳  뙘 뾽 뒪 넗 뼱 紐⑸줉 議고쉶: " + userId);
        
        // List<PopUpStore> likedStores = memberService.getLikedPopUpStores(userId);
        // model.addAttribute("likedStores", likedStores);

        return "/member/likedPopUpStores"; // 醫뗭븘 슂 븳  뙘 뾽 뒪 넗 뼱 紐⑸줉 JSP
    }

    // 紐⑸줉 뿉 꽌  궘 젣 븯 뒗 硫붿꽌 뱶
    @PostMapping("/removeLikedPopUpStore")
    public String removeLikedPopUpStore(@RequestParam("userId") String userId, @RequestParam("storeId") Long storeId, Model model) {
        log.info("醫뗭븘 슂 븳  뙘 뾽 뒪 넗 뼱  궘 젣: " + storeId + " by " + userId);
        
        // boolean isRemoved = memberService.removeLikedPopUpStore(userId, storeId);
        // if (isRemoved) {
        //     model.addAttribute("message", " 뙘 뾽 뒪 넗 뼱媛   궘 젣 릺 뿀 뒿 땲 떎.");
        // } else {
        //     model.addAttribute("error", " 뙘 뾽 뒪 넗 뼱  궘 젣 뿉  떎 뙣 뻽 뒿 땲 떎.");
        // }

        return "redirect:/member/likedPopUpStores"; // 醫뗭븘 슂 븳  뙘 뾽 뒪 넗 뼱 紐⑸줉  럹 씠吏 濡  由щ떎 씠 젆 듃 븯寃   맗 땲 떎!
    }

    // 醫뗭븘 슂 븳 援우쫰 紐⑸줉  쓣 썙二쇰뒗 硫붿꽌 뱶
    @GetMapping("/likedGoods")
    public String getLikedGoods(@RequestParam("userId") String userId, Model model) {
        log.info("醫뗭븘 슂 븳 援우쫰 紐⑸줉 議고쉶: " + userId);
        
        // List<Goods> likedGoods = memberService.getLikedGoods(userId);
        // model.addAttribute("likedGoods", likedGoods);

        return "/member/likedGoods"; // 醫뗭븘 슂 븳 援우쫰 紐⑸줉 JSP
    }

    // 醫뗭븘 슂 븳 援우쫰 紐⑸줉 뿉 꽌  궘 젣 븯 뒗 硫붿꽌 뱶
    @PostMapping("/removeLikedGoods")
    public String removeLikedGoods(@RequestParam("userId") String userId, @RequestParam("goodsId") Long goodsId, Model model) {
        log.info("醫뗭븘 슂 븳 援우쫰  궘 젣: " + goodsId + " by " + userId);
        
        // boolean isRemoved = memberService.removeLikedGoods(userId, goodsId);
        // if (isRemoved) {
        //     model.addAttribute("message", "援우쫰媛   궘 젣 릺 뿀 뒿 땲 떎.");
        // } else {
        //     model.addAttribute("error", "援우쫰  궘 젣 뿉  떎 뙣 뻽 뒿 땲 떎.");
        // }

        return "redirect:/member/likedGoods"; // 醫뗭븘 슂 븳 援우쫰 紐⑸줉  럹 씠吏 濡  由щ떎 씠 젆 듃 븯寃   맗 땲 떎!
    }

    // 愿  떖 궗 蹂 寃  硫붿꽌 뱶
    @PostMapping("/updateInterests")
    public String updateInterests(@RequestParam("userId") String userId, @RequestParam("interests") String interests, Model model) {
        log.info("愿  떖 궗 蹂 寃 : " + userId + " -> " + interests);
        
        // memberService.updateInterests(userId, interests);
        // model.addAttribute("message", "愿  떖 궗媛   꽦怨듭쟻 쑝濡  蹂 寃쎈릺 뿀 뒿 땲 떎.");

        return "/member/updateSuccess"; //  꽦怨   떆 寃곌낵  럹 씠吏 濡   씠 룞 븯寃   맗 땲 떎!
    }

    //  쉶 썝  깉 눜 硫붿꽌 뱶
    @PostMapping("/withdraw")
    public String withdraw(@RequestParam("userId") String userId, Model model) {
        log.info(" 쉶 썝  깉 눜  슂泥 : " + userId);
        
        // boolean isWithdrawn = memberService.withdraw(userId);
        // if (isWithdrawn) {
        //     model.addAttribute("message", " 쉶 썝  깉 눜媛   셿猷뚮릺 뿀 뒿 땲 떎.");
        // } else {
        //     model.addAttribute("error", " 쉶 썝  깉 눜 뿉  떎 뙣 뻽 뒿 땲 떎.");
        // }

        return "redirect:/"; // 硫붿씤  럹 씠吏 濡  由щ떎 씠 젆 듃 븯寃   맗 땲 떎!
    }
}