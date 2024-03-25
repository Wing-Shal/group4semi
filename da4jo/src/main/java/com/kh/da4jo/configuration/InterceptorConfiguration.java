package com.kh.da4jo.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.da4jo.interceptor.AdminInterceptor;
import com.kh.da4jo.interceptor.BlockInterceptor;
import com.kh.da4jo.interceptor.MemberInterceptor;
import com.kh.da4jo.interceptor.NoticeVcountInterceptor;
import com.kh.da4jo.interceptor.QnaOwnerInterceptor;
import com.kh.da4jo.interceptor.QnaVcountInterceptor;
import com.kh.da4jo.interceptor.ReviewOwnerInterceptor;
import com.kh.da4jo.interceptor.ReviewValidInterceptor;
import com.kh.da4jo.interceptor.ReviewVcountInterceptor;

@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer{

	@Autowired
	private MemberInterceptor memberInterceptor;
	@Autowired
	private AdminInterceptor adminInterceptor;
	@Autowired
	private BlockInterceptor blockInterceptor;
	@Autowired
	private QnaOwnerInterceptor QnaOwnerInterceptor;
	@Autowired
	private ReviewOwnerInterceptor reviewOwnerInterceptor;
	@Autowired
	private NoticeVcountInterceptor noticeVcountInterceptor;
	@Autowired
	private ReviewVcountInterceptor reviewVcountInterceptor;
	@Autowired
	private QnaVcountInterceptor qnaVcountInterceptor;
	@Autowired
	private ReviewValidInterceptor reviewValidInterceptor;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		//비회원 접근 금지
		registry.addInterceptor(memberInterceptor)
						.addPathPatterns(//인터셉터 적용할 페이지
						"/member/mypage",
						"/board/review/list",
						"/board/qna/**",
						"/board/notice/**",
						"/member/ship/request"
						)
					.excludePathPatterns(//인터셉터에서 제외할 페이지
						"/board/notice/list",
						"/board/notice/detail"
					);
		//관리자 외 접근 불가
		registry.addInterceptor(adminInterceptor)
						.addPathPatterns(	
						"/admin/**",
						"/board/notice/write"
						);
		//블락회원 접근 불가
		registry.addInterceptor(blockInterceptor)
						.addPathPatterns(
						"/board/qna/write",
						"/board/review/write",
						"/member/po/request"
						);
		//구매이력 중 배송완료 가 없으면(서비스를 이용한 적 없으면) 리뷰 금지
		registry.addInterceptor(reviewValidInterceptor)
						.addPathPatterns(
						"/board/review/write"
						);
		//QnA 본인 글만 수정, 삭제
		registry.addInterceptor(QnaOwnerInterceptor)
						.addPathPatterns( 
								"/board/qna/detail"
						);
		//Review 본인 글만 수정, 삭제
		registry.addInterceptor(reviewOwnerInterceptor)
						.addPathPatterns( 
								"/board/review/edit"
						);
		//공지글 조회수 중복방지
		registry.addInterceptor(noticeVcountInterceptor)
						.addPathPatterns(
								"/board/notice/detail"
						);
		//리뷰글 조회수 중복방지
				registry.addInterceptor(reviewVcountInterceptor)
								.addPathPatterns(
								"/board/review/detail"
						);
		//문의글 조회수 중복방지
		registry.addInterceptor(qnaVcountInterceptor)
						.addPathPatterns(
								"/board/qna/detail"
				);
	}
	
}

