package org.hype.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.hype.domain.gImgVO;
import org.hype.domain.goodsVO;
import org.hype.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/goodsStore/*")
public class GoodsController {
	
	@Autowired
	private GoodsService gService;
	
	String open = null;
	
	@GetMapping("/goodsDetails")
	public String goodsDetails(@RequestParam("gno") int gno, Model model, HttpServletRequest request) {
	    goodsVO vo = gService.getOneByGno(gno);
	    HttpSession session = request.getSession();
	    
	    String open = (String) session.getAttribute("open");
	    if (open == null) {
	        session.setAttribute("open", "yes");

	        int hit = vo.getGhit() + 1;
	        vo.setGhit(hit);
	        gService.getUpdatehit(vo);
	    }
        	List<gImgVO> imgVo = new ArrayList<gImgVO>();
        	gImgVO imgVo1 = gService.getImgByGno(vo.getGno());
        	gImgVO imgVo2 = gService.getGoodsDetailImg(vo.getGno());
            imgVo.add(imgVo1);  
            imgVo.add(imgVo2);
        	vo.setAttachList(imgVo);
	    
	    model.addAttribute("goods", vo);
	    
	    return "/goodsStore/goodsDetails";
	}
 
    @GetMapping("/goodsMain")
    public String goodsMain(Model model, HttpServletRequest request) {
        List<goodsVO> vo1 = gService.getListByLikeCount();
        for(goodsVO vo : vo1){
        	List<gImgVO> imgVo = new ArrayList<gImgVO>();
        	gImgVO imgVo1 = gService.getImgByGno(vo.getGno());
            imgVo.add(imgVo1);  
        	vo.setAttachList(imgVo);
        };
        model.addAttribute("likeGoods", vo1);
        
        // 로그인하지 않은 경우 관심사 3개에 대한 goodsVO 가져오기
        Map<String, Object> result1 = gService.getListByInterestOneNotLogin();
        String category1 = (String) result1.get("category");
        List<goodsVO> interestOneNotLogin = (List<goodsVO>) result1.get("goodsList");
        for(goodsVO vo : interestOneNotLogin){
        	List<gImgVO> imgVo = new ArrayList<gImgVO>();
        	gImgVO imgVo1 = gService.getImgByGno(vo.getGno());
            imgVo.add(imgVo1);  
        	vo.setAttachList(imgVo);
        };
        
        Map<String, Object> result2 = gService.getListByInterestTwoNotLogin();
        String category2 = (String) result2.get("category");
        List<goodsVO> interestTwoNotLogin = (List<goodsVO>) result2.get("goodsList");
        for(goodsVO vo : interestTwoNotLogin){
        	List<gImgVO> imgVo = new ArrayList<gImgVO>();
        	gImgVO imgVo1 = gService.getImgByGno(vo.getGno());
            imgVo.add(imgVo1);  
        	vo.setAttachList(imgVo);
        };
        
        Map<String, Object> result3 = gService.getListByInterestThreeNotLogin();
        String category3 = (String) result3.get("category");
        List<goodsVO> interestThreeNotLogin = (List<goodsVO>) result3.get("goodsList");
        for(goodsVO vo : interestThreeNotLogin){
        	List<gImgVO> imgVo = new ArrayList<gImgVO>();
        	gImgVO imgVo1 = gService.getImgByGno(vo.getGno());
            imgVo.add(imgVo1);  
        	vo.setAttachList(imgVo);
        };
        
        HttpSession session = request.getSession();
        session.setAttribute("open", "null");
        
        model.addAttribute("categoryOne", category1);
        model.addAttribute("categoryTwo", category2);
        model.addAttribute("categoryThree", category3);
        model.addAttribute("interestOneNotLogin", interestOneNotLogin);
        model.addAttribute("interestTwoNotLogin", interestTwoNotLogin);
        model.addAttribute("interestThreeNotLogin", interestThreeNotLogin);
        
//        @AuthenticationPrincipal CustomUser customUser
//        customUser.userNo로 가져오던가 해야함
        
        int userNo = 2;
        //로그인한 경우 관심사 3개에 대한 goodVO 가져오기
        List<String> mcat = gService.getUserInfo(userNo);
        List<goodsVO> interestOneLogined = gService.getListByInterestOneLogined(mcat.get(0));
        for(goodsVO vo : interestOneLogined){
        	List<gImgVO> imgVo = new ArrayList<gImgVO>();
        	gImgVO imgVo1 = gService.getImgByGno(vo.getGno());
            imgVo.add(imgVo1);  
        	vo.setAttachList(imgVo);
        };
        
        List<goodsVO> interestTwoLogined = gService.getListByInterestOneLogined(mcat.get(1));
        for(goodsVO vo : interestTwoLogined){
        	List<gImgVO> imgVo = new ArrayList<gImgVO>();
        	gImgVO imgVo1 = gService.getImgByGno(vo.getGno());
            imgVo.add(imgVo1);  
        	vo.setAttachList(imgVo);
        };
        
        List<goodsVO> interestThreeLogined = gService.getListByInterestOneLogined(mcat.get(2));
        for(goodsVO vo : interestThreeLogined){
        	List<gImgVO> imgVo = new ArrayList<gImgVO>();
        	gImgVO imgVo1 = gService.getImgByGno(vo.getGno());
            imgVo.add(imgVo1);  
        	vo.setAttachList(imgVo);
        };
        
        model.addAttribute("categoryFour", mcat.get(0));
        model.addAttribute("categoryFive", mcat.get(1));
        model.addAttribute("categorySix", mcat.get(2));
        model.addAttribute("interstOneLogined", interestOneLogined);
        model.addAttribute("interestTwoLogined", interestTwoLogined);
        model.addAttribute("interestThreeLogined", interestThreeLogined);
        return "/goodsStore/goodsMain";
    }

    @GetMapping("/goodsSearch")
    public String goodsSearch() {
        return "/goodsStore/goodsSearch";
    }
    
    @GetMapping("/goodsToPopup")
    public String goodsToPopup(@RequestParam("gno") int gno) throws UnsupportedEncodingException {
        String storeName = gService.goodsToPopup(gno);
        String encodedStoreName = URLEncoder.encode(storeName, "UTF-8");
        return "redirect:/hypePop/popUpDetails?storeName=" + encodedStoreName;
    }
    
    @GetMapping("/boardList")
    public String goBoardList() {
    	return "/goodsStore/boardList";
    }
}