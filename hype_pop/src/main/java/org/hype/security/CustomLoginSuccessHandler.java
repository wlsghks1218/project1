package org.hype.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hype.security.domain.CustomUser;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler{
   
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {
        // 로그인 후 리다이렉트 URL
        String redirectUrl = request.getParameter("redirect");
        
        // 현재 사용자의 권한 확인
        List<String> roleNames = new ArrayList<>();
        authentication.getAuthorities().forEach(auth -> roleNames.add(auth.getAuthority()));
        log.warn("ROLE NAME : " + roleNames);

        // 현재 사용자 정보(CustomUser)를 가져옴
        CustomUser customUser = (CustomUser) authentication.getPrincipal();
        Integer userNo = customUser.getMember().getUserNo();
        log.warn("Logged in userNo: " + userNo);
        
        HttpSession session = request.getSession();
        session.setMaxInactiveInterval(10800);

        // 관리자 권한일 경우
        if (roleNames.contains("ROLE_ADMIN")) {
            response.sendRedirect("/admin/adminPage");
            return;
        }

        if (roleNames.contains("ROLE_USER")) {
            // goodsMain 경로 처리
            if (redirectUrl != null && "http://localhost:9010/goodsStore/goodsMain".equals(redirectUrl) && userNo != null) {
                redirectUrl += "?userNo=" + userNo; // userNo 추가
            } else if (redirectUrl == null || "http://localhost:9010/member/login".equals(redirectUrl) || "http://localhost:9010/member/join".equals(redirectUrl)) {
                redirectUrl = "/"; // 기본 경로
            }
            log.warn("Redirecting to: " + redirectUrl);
            response.sendRedirect(redirectUrl);
        }
    }
}