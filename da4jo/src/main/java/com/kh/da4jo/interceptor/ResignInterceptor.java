package com.kh.da4jo.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.da4jo.dao.MemberBlockDao;
import com.kh.da4jo.dto.MemberBlockDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@Service
public class ResignInterceptor implements HandlerInterceptor{
	
	@Autowired
	private MemberBlockDao memberBlockDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		String loginId = (String)session.getAttribute("loginId");
		
		MemberBlockDto memberBlockDto = memberBlockDao.selectOne(loginId);
		if(memberBlockDto==null) return true;
		
		String memberStatus = memberBlockDto.getBlockStatus();
		
	    if ("탈퇴회원".equals(memberStatus)) {
	    	session.removeAttribute("loginId"); // 세션 값 삭제
			session.removeAttribute("loginLevel");
			session.removeAttribute("hasServiceHistory");
	    	response.sendRedirect("/da4jo/alert/resignMember");
		}
		return true;
	}
	
}
