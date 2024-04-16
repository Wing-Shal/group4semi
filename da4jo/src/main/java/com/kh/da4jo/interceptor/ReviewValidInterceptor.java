package com.kh.da4jo.interceptor;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
public class ReviewValidInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception
	{
		HttpSession session = request.getSession();
		
		String loginLevel = (String)session.getAttribute("loginLevel");
		int hasServiceHistory = (int)session.getAttribute("hasServiceHistory");
		
		//관리자
		if(loginLevel != null && loginLevel.equals("관리자") || loginLevel.equals("총관리자"))  {
			return true;
		}
		//구매한적 있으면 통과
		if(hasServiceHistory != 0) {
			return true;
		} else {
			response.sendRedirect("/da4jo/alert/hasntServiceHistory");
		}
		
		//나머지 차단
		response.sendError(403);
        return false;
	}
	
	
}
