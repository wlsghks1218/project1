package org.hype.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
        String redirectUrl = request.getParameter("redirect");
        List<String> roleNames = new ArrayList<>();
        authentication.getAuthorities().forEach(auth -> roleNames.add(auth.getAuthority()));
        log.warn("ROLE NAME : " + roleNames);

        CustomUser customUser = (CustomUser) authentication.getPrincipal();
        Integer userNo = customUser.getMember().getUserNo();

        if (roleNames.contains("ROLE_ADMIN")) {
            response.sendRedirect("/admin/adminPage");
        } else if (roleNames.contains("ROLE_USER")) {
            if (redirectUrl != null && userNo != null) {
                redirectUrl = redirectUrl.contains("?") ? 
                              redirectUrl + "&userNo=" + userNo : 
                              redirectUrl + "?userNo=" + userNo;
            }
            response.sendRedirect(redirectUrl);
        }
    }
}
