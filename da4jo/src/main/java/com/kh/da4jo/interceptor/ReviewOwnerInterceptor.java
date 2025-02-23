package com.kh.da4jo.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.da4jo.dao.ReviewDao;
import com.kh.da4jo.dto.ReviewDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;



@Service
public class ReviewOwnerInterceptor implements HandlerInterceptor{

	@Autowired
	private ReviewDao reviewDao;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
			
			int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
			ReviewDto reviewDto = reviewDao.selectOne(reviewNo);
			
			String loginId = (String)session.getAttribute("loginId");
			String loginLevel = (String)session.getAttribute("loginLevel");
			
			//관리자
			if(loginLevel != null && loginLevel.equals("관리자") || loginLevel.equals("총관리자"))  {
				return true;
			}
			//내글이면 통과
			if(loginId != null && loginId.equals(reviewDto.getReviewWriter())) {
				return true;
			}
			//나머지 차단
			response.sendError(403);
			return false;
	}
	
	
}
