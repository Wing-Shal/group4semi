package com.kh.da4jo.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.da4jo.dao.CreditDao;
import com.kh.da4jo.dao.ImgDao;
import com.kh.da4jo.dao.MemberDao;
import com.kh.da4jo.dao.PoDao;
import com.kh.da4jo.dao.QnaDao;
import com.kh.da4jo.dao.ReviewDao;
import com.kh.da4jo.dao.ShipSvcDao;
import com.kh.da4jo.dto.MemberDto;
import com.kh.da4jo.dto.QnaDto;
import com.kh.da4jo.dto.ReviewDto;
import com.kh.da4jo.service.EmailService;
import com.kh.da4jo.service.ImgService;
import com.kh.da4jo.vo.PageVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private EmailService emailService;
	@Autowired
	private ImgService imgService;
	@Autowired
	private ImgDao imgDao;
	@Autowired
	private CreditDao creditDao;
	@Autowired
	private ReviewDao reviewDao;
	@Autowired
	private PoDao poDao;
	@Autowired
	private QnaDao qnaDao;
	@Autowired
	private ShipSvcDao shipSvcDao;
	
	
	//회원가입
	@GetMapping("/join")
	public String join() {
		return "/WEB-INF/views/member/join.jsp";
	}
	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto memberDto,
									@RequestParam MultipartFile img) throws IllegalStateException, IOException {
		//회원 정보 등록
		memberDao.insert(memberDto);
		
		//첨부파일 등록
		if(!img.isEmpty()) {
			int imgNo = imgService.save(img);//파일저장 + DB저장
			
			memberDao.connect(memberDto.getMemberId(), imgNo);//연결
		}
		
		//가입 환영 메일 발송
		emailService.welcomSendMail(memberDto.getMemberEmail());
		
		//return "redirect:login";
		return "/WEB-INF/views/member/joinFinish.jsp";
	}
	
	@RequestMapping("/joinFinish")
	public String joinFinish() {
		return "/WEB-INF/views/member/joinFinish.jsp";
	}
	
	//로그인
	@GetMapping("/login")
	public String login() {
		return "/WEB-INF/views/member/login.jsp";
	}
	@PostMapping("/login")
	public String login(@ModelAttribute MemberDto inputDto,
										HttpSession session) {
		//아이디 조회
		MemberDto findDto = memberDao.selectOne(inputDto.getMemberId());
		//로그인 가능 여부 판정
		boolean isValid = findDto != null 
				&& inputDto.getMemberPw().equals(findDto.getMemberPw());
		//결과 처리
		if(isValid) {
			session.setAttribute("loginId",	findDto.getMemberId());
			session.setAttribute("loginLevel",findDto.getMemberLevel());
			session.setAttribute("hasServiceHistory", memberDao.hasServiceHistory(findDto.getMemberId()));
			
			//최종 로그인 시각 갱신
			memberDao.updateMemberLoginDate(findDto.getMemberId());
			
			return "redirect:/";
		}
		else {//로그인 실패
			return "redirect:login?error";
		}
	}
	//로그아웃
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("loginId"); // 세션 값 삭제
		session.removeAttribute("loginLevel");
		return "redirect:/";
	}
	
	//마이페이지
	@RequestMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		//로그인 아이디 추출
		String loginId = (String) session.getAttribute("loginId");
		//아이디로 정보 조회
		MemberDto memberDto = memberDao.selectOne(loginId);
		//화면으로 전달
		model.addAttribute("memberDto", memberDto);
		
		//로그인한 사용자의 캐시 내역을 첨부
		model.addAttribute("creditList", creditDao.selectList(loginId));
		//로그인한 사용자의 총 구매대행 구매서 작성 개수를 첨부
		model.addAttribute("countPo", poDao.countEachMember(loginId));
		//로그인한 사용자의 리뷰 글 개수 첨부
		model.addAttribute("countReview", reviewDao.countEachMember(loginId));
		//로그인한 사용자의 QNA 글 개수 첨부
		model.addAttribute("countQna", qnaDao.countEachMember(loginId));
		//로그인한 사용자의 총 배송대행 구매서 작성 개수를 첨부
		model.addAttribute("countShip", shipSvcDao.countEachMember(loginId));
		
		return "/WEB-INF/views/member/mypage.jsp";
	}
	
	//회원 정보 수정 페이지
	@GetMapping("/mypage/change")
	public String change(Model model, HttpSession session) {
		//로그인 아이디 추출
		String loginId = (String)session.getAttribute("loginId");
		//아이디로 정보 조회
		MemberDto memberDto = memberDao.selectOne(loginId);
		//모델에 정보 추가
		model.addAttribute("memberDto", memberDto);
		
		return"/WEB-INF/views/member/mypage/change.jsp"; 
	}
	@PostMapping("/mypage/change")
	public String change(@ModelAttribute MemberDto memberDto, HttpSession session,
					@RequestParam MultipartFile img) throws IllegalStateException, IOException {
		//로그인 아이디 추출
		String loginId = (String)session.getAttribute("loginId");
		//memberDto에 아이디 설정
		memberDto.setMemberId(loginId);
		//DB정보 조회
		MemberDto findDto = memberDao.selectOne(loginId);
		//판정
		boolean isValid = memberDto.getMemberPw().equals(findDto.getMemberPw());
		System.out.println("isValid = " + isValid);
		//변경 (판정문이 맞다면 == 현재 입력된 비밀번호와 원래 비밀번호 일치 여부 확인)
		if(isValid) {
			memberDao.updateMember(memberDto);
			
			//첨부파일 등록
			if(!img.isEmpty()) {
				int imgNo = imgService.save(img);//파일저장 + DB저장
				
				memberDao.connect(memberDto.getMemberId(), imgNo);//연결
			}
			
			return "redirect:/member/mypage";
		} else {
			return "redirect:/member/mypage/change?error";
		}
	}
	
	//회원 비밀번호 변경 페이지
	@GetMapping("/mypage/password")
	public String password() {
		return "/WEB-INF/views/member/mypage/password.jsp";
	}
	@PostMapping("/mypage/password")
	public String password(@RequestParam String originPw,
						@RequestParam String changePw,
						HttpSession session) {
		//로그인 아이디 추출
		String loginId = (String) session.getAttribute("loginId");
		
		//비밀번호 검사
		MemberDto findDto = memberDao.selectOne(loginId);
		boolean isValid = findDto.getMemberPw().equals(originPw);
		
		if(isValid) {
			MemberDto memberDto = new MemberDto();
			memberDto.setMemberId(loginId);
			memberDto.setMemberPw(changePw);
			memberDao.updateMemberPw(memberDto);
			
			return "redirect:/member/mypage";
		}
		else {
			return "redirect:/member/mypage/password?error";
		}
	}
	
	//회원 탈퇴 페이지
	@GetMapping("/mypage/exit")
	public String exit() {
		return "/WEB-INF/views/member/mypage/exit.jsp";
	}	
	@PostMapping("/mypage/exit")
	public String exit(@RequestParam String memberPw,
					@ModelAttribute MemberDto memberDto,
					HttpSession session) {
		String loginId = (String)session.getAttribute("loginId");
		
		MemberDto findDto = memberDao.selectOne(loginId);
		boolean isValid = findDto.getMemberPw().equals(memberPw);
		
		if(isValid) {
			try {
				//프로필 삭제
				int imgNo = memberDao.findImgNo(loginId);
				imgService.removeFile(imgNo);
			} 
			catch(Exception e) {
				//e.printStackTrace();
			}
			finally {
				//회원 블락
				memberDao.deleteMember(loginId);
				//block 테이블에 탈퇴회원으로 추가
				memberDao.addDeleteMember(loginId);
				//로그아웃
				session.removeAttribute("loginId");
			}
			return "redirect:/";
		}
		else {
			return "redirect:exit?error";
		}
	}
	
	//프로필 다운로드
	@RequestMapping("/img")
	public String img(HttpSession session) {
		try {
			String loginId = (String)session.getAttribute("loginId");
			int imgNo = memberDao.findImgNo(loginId);
			return "redirect:/download?imgNo=" + imgNo;
		}
		catch(Exception e) {
			return "redirect:/image/logotemplate.png";
		}
	}
			
	//구매 신청서 리스트 페이지
//	@RequestMapping("/mypage/list")
//	public String list(@ModelAttribute(value = "pageVO") PageVO pageVO, Model model) {
//		
//	}

	//아이디 찾기
	@GetMapping("/findId")
	public String findId() {
		return "/WEB-INF/views/member/findId.jsp";
	}
	@PostMapping("/findId")
	public String findId(@ModelAttribute MemberDto memberDto) {
		MemberDto findDto = memberDao.selectEmail(memberDto.getMemberEmail());
		
		boolean isValid = findDto != null && findDto.getMemberEmail().equals(memberDto.getMemberEmail());
		if(isValid) {//이메일 존재
			emailService.sendMemberId(findDto.getMemberEmail());
			return "redirect:findIdSuccess";
		}
		else {//이메일 없음
			//return "redirect:findIdFail";
			return "redirect:findId?error";
		}
	}
	@RequestMapping("/findIdSuccess")
	public String findIdSuccess() {
		return "/WEB-INF/views/member/findIdSuccess.jsp";
	}
//	@RequestMapping("/findIdFail")
//	public String findIdFail() {
//		return "/WEB-INF/views/member/findIdFail.jsp";
//	}
	
	//비밀번호 찾기
	@GetMapping("/findPw")
	public String findPw() {
		return "/WEB-INF/views/member/findPw.jsp";
	}	
	@PostMapping("/findPw")
	public String findPw(
			@ModelAttribute MemberDto memberDto) {
		MemberDto findDto = memberDao.selectOne(memberDto.getMemberId());
		
		boolean isValid = findDto != null && findDto.getMemberEmail().equals(memberDto.getMemberEmail());
		if(isValid) {
			emailService.sendTempPassword(findDto);
			return "redirect:findPwSuccess";
		}
	
	    else {
	    	return "redirect:findPw?error";
	    	//return "redirect:findPwFail";
	    }
	}	
	@RequestMapping("/findPwSuccess")
	public String findPwSuccess() {
		return "/WEB-INF/views/member/findPwSuccess.jsp";
	}
	@RequestMapping("/findPwFail")
	public String findPwFail() {
		return "/WEB-INF/views/member/findPwFail.jsp";
	}
	
	
	//내가 쓴 리뷰글 페이지
	@RequestMapping("/board/review")
	public String review(@ModelAttribute ReviewDto reviewDto, HttpSession session,
						Model model) {
		//로그인 아이디 추출
		String loginId = (String) session.getAttribute("loginId");
		//아이디로 정보 조회
		MemberDto memberDto = memberDao.selectOne(loginId);
		//화면으로 전달
		model.addAttribute("memberDto", memberDto);
		//내가 쓴 리뷰 글 가져오기
		model.addAttribute("reviewList", reviewDao.selectList(loginId));
		
		return "/WEB-INF/views/member/board/review.jsp";
	}
	
	//내가 쓴 QNA 페이지
	@RequestMapping("/board/qna")
	public String qna(@ModelAttribute(value = "pageVO") PageVO pageVO,
					 HttpSession session, Model model) {
		String loginId = (String) session.getAttribute("loginId");

		MemberDto memberDto = memberDao.selectOne(loginId);
		model.addAttribute("memberDto", memberDto);
		
		int count = qnaDao.count();
		pageVO.setCount(count);
		
		List<QnaDto> list = qnaDao.selectListByPaging(pageVO, loginId);
		model.addAttribute("qnaList", list); 
		
		return "/WEB-INF/views/member/board/qna.jsp";
	}
}








