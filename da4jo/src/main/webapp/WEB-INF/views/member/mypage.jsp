<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.boxInfo{
	border-color: #6c6e6e33;
	border-width: 1px;
    border-style: solid;
	boarder-radius: 2px;
	font-size: 14px;
}

.memberInfo{
	font-size:14px;
	border-bottom-color: #6c6e6e33;
	border-bottom-width: 1px;
    border-bottom-style: solid;
}

.detailInfo,
.btnMypage {
	font-size: 12px;
	padding: 5px;
}

.profileEdit{
	display : none;
}

</style>

<style>
.menuBox {
	padding : 5px;
	padding-bottom : 20px;
	height : 200px;
	margin-top : 0px !important;
}
.title-head {
	background-color: #60A1F833;
}
</style>


<style>
.chargeList {
	margin-left: auto;
	margin-right: auto;
}
.chargeList li {
	width: 30%;
}
.chargeList .chargeTime {
	width: 70%;
}

img.newProfile { /*프로필 공간 고정*/
    width: 100%;
    height: 150px;
}
</style>



<!-- 프로필 변경 -->
<script>
$(function(){
	$(".profileEdit").on("input", function(){
		//파일이 없으면 리턴(전송 X)
		if(this.files.length == 0) return;
		console.log(this.files);
		
		var formData = new FormData();
		formData.append("img", this.files[0]);
		console.log(formData);
		
		//비동기 통신
		$.ajax({
			url : "/rest/member/editProfile", //이미지 업로드를 처리하는 서버
			method : "post",
			data : formData, //이미지 파일 데이터 (전송해주기)
			processData : false,
			contentType : false,
			success : function(response) {
				//서버에서 응답 받은 후 실행되는 함수
				if (response == null) return;
				
				//기존에 있는 img 태그에 넣기!!!
				$(".newProfile").attr({
				    src: "img",
				    name: "imgChanged"
				});
			
			}
		});
			
	});		
  	
});
</script>


<!-- 마이페이지 -->
<br>
<br>
<div class="container container-body">
	<!-- 마이페이지 헤더 -->
	<div class="container inner-container">
		<div class="content content-head">
			<div class="content-head-text">
				<i class="fa-solid fa-pause"></i>마이페이지
			</div>
		</div>
	</div>
		<div class="container flex-container">
		<div class="container inner-container">
			<!-- 회원 정보 -->
			<div class="boxInfo">
				<div class="cell center memberInfo">
					<img src="/member/img" width="100%" class="newProfile">
					<div class="cell">
						<label for="edit-profile"><i class="fa-solid fa-user-pen"></i>수정</i></label>
						<input type="file" name="img" class="tool w-100 profileEdit" id="edit-profile">
					</div>
					<p><b>'${sessionScope.loginId}'</b> 회원님</p>
				</div>
				<div class="cell center detailInfo">
					<p><b>'${sessionScope.loginLevel}'</b> 입니다</p>
					<div class="cell pt-10">
						<a class="btn w-50 btnMypage" href="/member/mypage/change">개인정보 변경</a>
					</div>
					<div class="cell">
						<a class="btn w-150 btnMypage" href="/member/mypage/password">비밀번호 변경</a>
					</div>
				</div>
			</div>
			<br><br>
			<!-- 메뉴바 -->
			<div class="title title-head">
				<div>
					<a class="link" href="/member/mypage">MYPAGE</a>
				</div>
			</div>
			<div class="title title-body">
				<div class="title-body-main">
					<div class="title-body-text">
						<a class="link main-title">구매대행</a>
					</div>
					<div class="title-body-sub">
						<div class="title-body-text">
							<a class="link" href="/member/po/request">구매대행 신청서 작성</a>
						</div>
						<div class="title-body-text">
							<a class="link" href="/member/mypage/purchase/pendingPayment">구매대행 결제대기</a>
						</div>
						<div class="title-body-text">
							<a class="link" href="/member/mypage/purchase/processList">배송 진행 상황</a>
						</div>
						<div class="title-body-text">
							<a class="link" href="/member/mypage/purchase/list">구매대행 신청 내역</a>
						</div>
					</div>
				</div>
				<div class="title-body-main">
					<div class="title-body-text">
						<a class="link main-title">배송대행</a>
					</div>
					<div class="title-body-sub">
						<div class="title-body-text">
							<a class="link" href="/member/ship/request">배송대행 신청서 작성</a>
						</div>
						<div class="title-body-text">
							<a class="link" href="/member/mypage/ship/pendingPayment">배송대행 결제대기</a>
						</div>
						<div class="title-body-text">
							<a class="link" href="/member/mypage/ship/processList">배송 진행 상황</a>
						</div>
						<div class="title-body-text">
							<a class="link" href="/member/mypage/ship/list">배송대행 신청 내역</a>
						</div>
					</div>
				</div>
				<div class="title-body-main">
					<div class="title-body-text">
						<a class="link main-title" href="/board/qna/list">QNA</a>
					</div>
				</div>
				<div class="title-body-main">
					<div class="title-body-text">
						<a class="link main-title" href="/board/review/list">리뷰 게시판</a>
					</div>
				</div>
			</div>
		</div><!-- 왼쪽 사이드 바 닫는 태그 -->
		<!-- 오른쪽 내용 -->
		<div class="container inner-container">
			<div class="content content-body">
				<!-- 주요메뉴 -->
				<div class="cell center flex-cell">
					<div class="cell menuBox w-20"> <!-- 메뉴1 -->
						<div class="title title-head">
							구매대행 신청서
						</div>
						<div class="title title-body mt-10">
							<h3>${countPo} 건</h3>
							<a class="btn w-100 btnMypage " href="/member/po/request">작성하기</a>
							<a class="btn w-100 btnMypage " href="mypage/purchase/list">내 신청서 보기</a>
						</div>
					</div>
					<div class="cell menuBox w-20"> <!-- 메뉴2 -->
						<div class="title title-head"> <!-- 제목 -->
							 <a class="link">배송대행 신청서</a>
						</div>
						<div class="title title-body mt-10"> <!-- 내용 -->
							<h3>${countShip} 건</h3>
							<a class="btn w-100 btnMypage " href="/member/ship/request">작성하기</a>
							<a class="btn w-100 btnMypage " href="mypage/ship/list">내 신청서 보기</a>
						</div>
					</div>
					<div class="cell menuBox w-20"> <!-- 메뉴3 -->
						<div class="title title-head">
							 나의 문의내역
						</div>
						<div class="title title-body mt-10">
							<div>
								<h3> ${countQna} 건</h3>
								<a class="btn w-100 btnMypage " href="board/qna">내 문의내역</a>
							</div>
						</div>
					</div>
					<div class="cell menuBox w-20"> <!-- 메뉴4 -->
						<div class="title title-head">
							 나의 리뷰내역
						</div>
						<div class="title title-body mt-10">
							<div>
								<h3> ${countReview} 건</h3>
								<a class="btn w-100 btnMypage " href="board/review">내가 쓴 리뷰</a>
							</div>
						</div>
					</div>
					<div class="cell menuBox w-20"> <!-- 메뉴5 -->
						<div class="title title-head">
							보유캐시
						</div>
						<div class="title title-body mt-10">
							<div>
								<h3><fmt:formatNumber value="${memberDto.memberCredit}" pattern="#,##0"></fmt:formatNumber>원</h3>	
								<a class="btn btnMypage " href="credit/charge">충전하기</a>
							</div>
						</div>
					</div>
				</div><!-- 주요 메뉴 닫는 태그 -->
				<hr>
				<!-- 캐쉬 충전 내역 테이블 -->
				<div>
				<c:if test="${empty creditList}"> <!-- 캐쉬 내역이 없는 경우 -->
					<div class="cell center mt-30">
						<i class="fa-regular fa-face-sad-tear fa-3x"></i>
						<h2>구매내역이 없습니다</h2>
					</div>
					<div class="cell center">
						<h2>
							<a href="credit/charge" class="btn"> 
							<i class="fa-solid fa-sack-dollar" style="color: #dbdd7e;"></i>
							구매하러 가기
							</a>
						</h2>
					</div>
				</c:if><!-- 캐쉬 내역이 없는 경우 닫는 태그 -->
				<c:if test="${!empty creditList}"><!-- 캐쉬 내역이 있는 경우 -->
					<div class="cell center">
						<h2>
							캐쉬 충전내역
						</h2>
					</div>
					<div class="cell right">
						<a href="credit/charge" class="btn btnCredit">
							<i class="fa-solid fa-sack-dollar" style="color: #dbdd7e;"></i>크레딧 충전
						</a>
					</div>
					<div class="cell center">
						<ul class="menu chargeList">
							<li>충전금액</li>
							<li class="chargeTime">충전일시</li>
						</ul>
						<c:forEach var="creditDto" items="${creditList}">
							<ul class="menu chargeList">
								<li><fmt:formatNumber value="${creditDto.creditCharge}" pattern="#,##0"></fmt:formatNumber>원</li>
								<li class="chargeTime"><fmt:formatDate value="${creditDto.creditTimeDate}"
										pattern="y년 M월 d일 H시 m분 s초" /></li>
							</ul>
						</c:forEach>
					</div>
				</c:if><!-- 캐쉬 내역이 있는 경우 닫는 태그 -->
				
				
				<!-- 회원 탈퇴 페이지 이동 -->
				<div class="cell right" style="font-size:10px;">
					<a class="link" href="/member/mypage/exit">회원 탈퇴</a>
				</div>
				</div>
			</div>
		</div><!-- 오른쪽 내용 닫는 태그 -->
	</div><!-- 컨텐트 자리 닫는 태그 -->
</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>