package org.hype.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.web.authentication.AuthenticationFailureHandler;

public class CustomLoginFailedHandler implements AuthenticationFailureHandler {

   @Override
   public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
         org.springframework.security.core.AuthenticationException exception) throws IOException, ServletException {
        request.setAttribute("errorMessage", "아이디 또는 비밀번호가 잘못되었습니다.");
        response.sendRedirect("/member/login?error=true");
   }
}
