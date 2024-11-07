package org.hype.controller;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.hype.domain.popStoreVO; // popStoreVO 클래스 import
import org.hype.domain.pImgVO; // pImgVO 클래스 import
import org.hype.service.PopUpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {


    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String home() {
    	
        return "hypeMainPage/mainPage"; // JSP 페이지 이름 반환
    }
}
