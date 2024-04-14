package com.kh.da4jo.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.da4jo.dao.MemberDao;
import com.kh.da4jo.dto.MemberDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@Service
public class BlockInterceptor implements HandlerInterceptor{
	
	@Autowired
	private MemberDao memberDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		String loginId = (String)session.getAttribute("loginId");
		MemberDto findDto =  memberDao.selectOne(loginId);
		String memberBlock = findDto.getMemberBlock();
		
	    if ("N".equals(memberBlock)) { // 일반 회원
	        return true;
		}
		else {//블락회원
			
			response.sendRedirect("/da4jo/alert/isBlock");//어디로 보낼지?
		}
		return false;
	}
	
}
