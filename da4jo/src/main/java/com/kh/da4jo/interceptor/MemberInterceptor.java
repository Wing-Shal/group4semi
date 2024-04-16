package com.kh.da4jo.interceptor;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
public class MemberInterceptor implements HandlerInterceptor{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		String loginId = (String)session.getAttribute("loginId");
		
		if(loginId != null){ //회원
			return true;
		}
		else {//회원 아님
			response.sendRedirect("/da4jo/member/login");//로그인 페이지로 이동
		}
		return false;
	}


}
