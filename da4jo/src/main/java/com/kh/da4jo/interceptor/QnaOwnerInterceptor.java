package com.kh.da4jo.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.da4jo.dao.MemberDao;
import com.kh.da4jo.dao.QnaDao;
import com.kh.da4jo.dto.MemberDto;
import com.kh.da4jo.dto.QnaDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;



@Service
public class QnaOwnerInterceptor implements HandlerInterceptor{

	@Autowired
	private QnaDao qnaDao;
	@Autowired
	private MemberDao memberDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
			
			int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
			QnaDto qnaDto = qnaDao.selectOne(qnaNo);
			
			String loginId = (String)session.getAttribute("loginId");
			String loginLevel = (String)session.getAttribute("loginLevel");
			
			MemberDto memberDto = memberDao.selectOne(loginId);
						
			if(loginLevel != null)  {
				if(loginLevel.equals("관리자") || loginLevel.equals("총관리자")) {
					return true;
				}
			}

			//비밀글인데, 내가 쓴 글이면 통과 아니면 리스트로
			boolean isSecret = qnaDto.getQnaSecret().equals("Y");
			if(isSecret) {
				if(qnaDto.getQnaWriter().equals(loginId)) {
					return true;
				} else {
					response.sendRedirect("/da4jo/board/qna/list");
				}
			} else { //비밀글이 아닐때
				return true;
			}
			
			//나머지 차단
			response.sendError(403);
			return false;
	}
	
	
}
