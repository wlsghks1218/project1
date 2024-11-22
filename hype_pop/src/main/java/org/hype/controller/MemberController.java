package org.hype.controller;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.hype.domain.gImgVO;
import org.hype.domain.likedExhViewVO;
import org.hype.domain.likedGoodsImgVO;
import org.hype.domain.likedPopImgVO;

import org.hype.domain.mCatVO;
import org.hype.domain.pImgVO;
import org.hype.domain.signInVO;
import org.hype.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
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

import com.sun.jdi.connect.spi.Connection;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/member/*")
public class MemberController {

   @Autowired
   private MemberService mservice;
   
    @Autowired
    private PasswordEncoder pwencoder;
   



   // 濡쒓렇 씤 럹 씠吏 濡   씠 룞
    @GetMapping("/login")
    @PreAuthorize("permitAll()")  
    public String login() {
        return "member/login";
    }

   
    @GetMapping("/join")
    @PreAuthorize("permitAll()") 
    public String joinPage() {
        log.info("join now");
        return "member/joinPage";
    }
    
    @PostMapping("/join")
    @PreAuthorize("permitAll()") 
    public String join(@ModelAttribute signInVO svo, Model model)
            throws IllegalAccessException, IllegalArgumentException, InvocationTargetException {
        svo.setUserPw(pwencoder.encode(svo.getUserPw()));
        log.warn("join!!!!!!!!!!!!!!!");

        // bean  궡遺  쓽  븘 뱶 媛   솗 씤 肄붾뱶
        Method[] methods = svo.getClass().getDeclaredMethods();
        for (Method method : methods) {
            if (method.getName().startsWith("get")) {
                Object value = method.invoke(svo);
                System.out.println(method.getName().substring(3) + ": " + value);
            }
        }
        System.out.println("---------------------------------");
        methods = svo.getUserInterest().getClass().getDeclaredMethods();
        for (Method method : methods) {
            if (method.getName().startsWith("get")) {
                Object value = method.invoke(svo.getUserInterest());
                System.out.println(method.getName().substring(3) + ": " + value);
            }
        }

        if (mservice.checkDuplicateId(svo.getUserId())) {
            model.addAttribute("errorMessage", " 씠誘  議댁옱 븯 뒗  븘 씠 뵒 엯 땲 떎.");
            return "member/joinForm"; // 以묐났  떆  쉶 썝媛  엯  뤌 쑝濡   룎 븘媛 湲 
        }
        mservice.joinMember(svo);

        return "member/login";
    }

    @GetMapping("/myPage")
    @PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_USER')")
    public String myPage(Model model, @RequestParam("userNo") int userNo) {
        signInVO userInfo = mservice.selectMyPageInfo(userNo);
        mCatVO userInterests = mservice.selectMyInterest(userNo);
        List<likedPopImgVO> pLikeList = mservice.pLikeList(userNo);
        List<likedGoodsImgVO> gLikeList = mservice.gLikeList(userNo);
        List<likedExhViewVO> eLikeList = mservice.eLikeList(userNo);
        System.out.println("gLikeList :" + gLikeList);

        model.addAttribute("userInfo", userInfo);
        model.addAttribute("userInterests", userInterests);
        model.addAttribute("pLikeList", pLikeList);
        model.addAttribute("gLikeList", gLikeList);
        model.addAttribute("eLikeList", eLikeList);

        for (likedGoodsImgVO goods : gLikeList) {
            System.out.println("gName: " + goods.getGname());
            System.out.println("gNo: " + goods.getGno());
            System.out.println("uploadPath: " + goods.getUploadPath());
        }

        return "member/myPage";
    }

    @PostMapping("/passwordChange")
    @PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_USER')")
    public String passwordChange(@RequestParam(value = "userNo") int userNo, @RequestParam("oldPw") String oldPw,
                                  @RequestParam("newPw") String newPw) {
        log.info("鍮꾨 踰덊샇 蹂 寃 : userNo=" + userNo);

        if (mservice.selectOldPw(userNo, oldPw) > 0) {
            mservice.updateNewPw(oldPw, newPw, userNo);
            return "/member/myPage"; //  꽦怨  硫붿떆吏  異붽   븘 슂
        }
        return "member/myPage";
    }

   //  씠硫붿씪 蹂 寃 
    @GetMapping("/emailChange")
    @PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_USER')")
    public String emailChange(@RequestParam(value = "userNo") int userNo, @RequestParam("newEmail") String newEmail,
                              Model model) {
        log.info(" 씠硫붿씪 蹂 寃 : userNo=" + userNo);
        log.info(" 씠硫붿씪 蹂 寃 : new Email=" + newEmail);

        int updateCount = mservice.updateNewEmail(newEmail, userNo);

        if (updateCount > 0) {
            model.addAttribute("success", " 씠硫붿씪 쓣 蹂 寃쏀뻽 뒿 땲 떎.");
        } else {
            model.addAttribute("error", " 씠硫붿씪 蹂 寃쎌뿉  떎 뙣 뻽 뒿 땲 떎.");
        }

        return "redirect:/member/myPage?userNo=" + userNo;
    }

   //  쟾 솕踰덊샇 蹂 寃 
    @GetMapping("/phoneNumberChange")
    @PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_USER')")
    public String phoneNumberChange(@RequestParam(value = "userNo") int userNo,
                                    @RequestParam("oldPhoneNumber") String oldPhoneNumber,
                                    @RequestParam("newPhoneNumber") String newPhoneNumber, Model model) {
        log.info(" 쟾 솕踰덊샇 蹂 寃 : userNo=" + userNo);

        if (mservice.selectOldPhoneNum(userNo, oldPhoneNumber) > 0) {
            mservice.updateNewPhoneNum(oldPhoneNumber, newPhoneNumber, userNo);
            model.addAttribute("success", " 쟾 솕踰덊샇瑜  蹂 寃쏀뻽 뒿 땲 떎.");
            return "redirect:/member/myPage?userNo=" + userNo;
        }
        model.addAttribute("error", " 쟾 솕踰덊샇 蹂 寃쎌뿉  떎 뙣 뻽 뒿 땲 떎.");
        return "redirect:/member/myPage?userNo=" + userNo;
    }
    
    @GetMapping("/userReply")
    @PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_USER')")
    public String userReply() {
        System.out.println("userReply..");
        return "/member/userReply";
    }
    
    
    @GetMapping("/myCart")
    @PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_USER')")
    public String myCart() {
        System.out.println("myCart..");
        return "/purchase/myCart";
    }
    
    
    @GetMapping("/paymentList")
    @PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_USER')")
    public String paymentList() {
        System.out.println("paymentList..");
        return "/purchase/paymentList";
    }
   
   
    @GetMapping("goPwChange")
    public String goPwChange() {
        return "/member/searchPw";
    }

   // 鍮꾨 踰덊샇 蹂 寃 
    @PostMapping("/pwChange")
    @PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_USER')")
    public String pwChange(@RequestParam(value = "userNo") int userNo, 
                           @RequestParam("oldPw") String oldPw,
                           @RequestParam("newPw") String newPw, 
                           Model model) {
        log.info("비밀번호 변경 요청: userNo={}, oldPw={}, newPw={}"+ userNo+oldPw+ newPw);

        boolean isOldPwValid = mservice.selectOldPw(userNo, oldPw) > 0;

        if (isOldPwValid) {
            mservice.updateNewPw(oldPw, newPw, userNo);
            model.addAttribute("msg", "鍮꾨 踰덊샇媛  蹂 寃쎈릺 뿀 뒿 땲 떎.");
            return "member/searchPwSuccess";
        }
        
        model.addAttribute("msg", "鍮꾨 踰덊샇 蹂 寃쎌뿉  떎 뙣 뻽 뒿 땲 떎.");
        return "member/searchPw";
    }

   // 븘 씠 뵒 李얘린  썑  븘 씠 뵒 蹂댁뿬二쇰뒗  솕硫   씠 룞
    @GetMapping("/checkMyId")
    public String checkMyId(@RequestParam("userName") String userName, 
                            @RequestParam("userEmail") String userEmail, 
                            Model model) {
        log.info("Searching for userName: " + userName + " and userEmail: " + userEmail);

        String userId = mservice.checkMyId(userName, userEmail);

        model.addAttribute("userId", userId);

        return "member/searchId";
    }
    
    @PostMapping("/deleteUserData")
    @PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_USER')")
    public boolean deleteUserData(int userNo) {
        try {
            mservice.deleteUserData(userNo);
            return true; //  깉 눜  꽦怨 
        } catch (Exception e) {
            log.error(" 쉶 썝  깉 눜 以   삤瑜  諛쒖깮 - userNo: " + userNo, e);
            return false; //  깉 눜  떎 뙣
        }
    }
   
   
   
    @GetMapping("/goodBye")
    @PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_USER')")
    public String goodBye() {
        return "member/goodBye";
    }
}
   

   


   


    
    