<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta property="og.title" content="다4조 세미 프로젝트">
<meta property="og.description" content="배송/구매대행 서비스">
<meta property="og.image" content="${pageContext.request.contextPath}/image/logotemplatecut.png">

<!-- 구글 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
	rel="stylesheet">

<!-- 프로젝트용 기본 스타일 -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/commons.css">
<!-- <link rel="stylesheet" type="text/css" href="href="${pageContext.request.contextPath}/css/test.css"> -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/layout.css">

<!-- font awesome 아이콘 CDN -->
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<style>
</style>

<!--  jQuery CDN -->
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>

<!-- summernote cdn -->
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<!-- select2 cdn -->
<link
	href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css"
	rel="stylesheet" />
<script
	src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script type="text/javascript">
	$(function() {
		$(".searchSelect").select2({
			minimumResultsForSearch : Infinity
		//selelct창에 검색 바 유무(주석처리 시 생김)
		});
	});
</script>
<style>
.note-editor {
	border: 1px solid #636e72 !important;
}

.nav {
	width: 1140px;
}

.head-bottom {
	margin: 0px;
	border-top: 1px solid #ACB8BD;
	border-bottom: 1px solid #ACB8BD;
}

.head li {
	display: inline-block;
	font-size: 12px;
	width: 60px;
	color: #2D3436;
	padding: 0.5em;
	position: relative;
}

.head-middle {
 	height: 80px !important;
}

.home>a {
	font-size: 30px;
	font-weight: 800;
	color: rgb(71, 163, 255);
}

.cs, .currency, .notice {
	border: 0.1mm solid #ACB8BD;
	width: 33.3333%;
	font-size: 14px;
	text-align: left;
	padding-left: 20px;
	padding-right: 20px;
}

.cs span, .currency span, .wdate {
	color: #ACB8BD;
	font-size: 12px;
	font-weight: lighter;
}

.cs {
	border-left: none;
}

.currency {
	border-left: none;
	border-right: none;
}

.notice {
	border-right: none;
}

.link-notice {
	position: relative;
	float: right;
}

.btn.delivery {
	background-color: rgb(0, 151, 150);
	color: white;
	white-space: nowrap
}
</style>
<script>
	$(function() {
		var options = {
			//에디터 툴바(메뉴) 설정
			toolbar : [ [ 'style', [ 'bold', 'italic', 'underline' ] ],
					[ 'fontsize', [ 'fontname', 'fontsize' ] ],
					[ 'color', [ 'forecolor', 'backcolor' ] ],
					[ 'para', [ 'style', 'ul', 'ol', 'paragraph' ] ],
					[ 'insert', [ 'picture', 'link', 'hr' ] ], ],
			//기본높이 설정(단위 : px)
			height : 500,
			minHeight : 200,
			maxHeight : 2000,
			//안내문구 설정
			callbacks : {
				//이미지 업로드 시 실행되는 콜백 함수 정의
				onImageUpload : function(files) {
					var editor = this;

					var formData = new FormData();
					for (var i = 0; i < files.length; i++) {
						formData.append("imgList", files[i]);
					}

					$.ajax({
						url : "${pageContext.request.contextPath}/rest/board_attach/upload", //이미지 업로드를 처리하는 서버
						method : "post",
						data : formData, //이미지 파일 데이터
						processData : false,
						contentType : false,
						success : function(response) {
							//서버에서 응답 받은 후 실행되는 함수
							if (response == null)
								return;

							for (var i = 0; i < response.length; i++) {
								var tag = $("<img>").attr("src",
										"/download?imgNo=" + response[i]).attr(
										"data-key", response[i]).addClass(
										"server-img");
								$(".imgArea").summernote("insertNode", tag[0]);
							}
						}
					});
				}
			}
		};
		$(".imgArea").summernote(options);

	});
</script>

<!-- 내가 만든 JS -->
<script src="${pageContext.request.contextPath}/js/commons.js"></script>

</head>

<body>

	<main>
		<div class="header">
			<div class="container">
				<div class="cell">
					<ul class="right contour head">
						<c:if
							test="${sessionScope.loginLevel == '관리자' || sessionScope.loginLevel == '총관리자'}">
							<li><a href="${pageContext.request.contextPath}/admin/">${sessionScope.loginLevel}</a></li>
						</c:if>
						<c:choose>
							<c:when test="${sessionScope.loginId != null}">
								<li><a href="${pageContext.request.contextPath}/member/logout">로그아웃</a></li>
								<li><a href="${pageContext.request.contextPath}/member/mypage">mypage</a></li>

							</c:when>
							<c:otherwise>
								<li><a href="${pageContext.request.contextPath}/member/login">로그인</a></li>
								<li><a href="${pageContext.request.contextPath}/member/join">회원가입</a></li>
							</c:otherwise>
						</c:choose>
						<li><a href="${pageContext.request.contextPath}/board/notice/list">고객센터</a></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="head-middle">
			<div class="nav container">
				<ul class="menu cell center">
					<li class="us-or nation">
						<a href="${pageContext.request.contextPath}/document/delivery-address" class="link">
							<div class="nation-icon">
								<img src="${pageContext.request.contextPath}/image/top_iso_us.png">
							</div>
							<div class="nation-text">
								<span><strong>미국(OR)</strong></span>
							</div>
						</a>
					</li>
					<li class="us-nj nation">
						<a href="${pageContext.request.contextPath}/document/delivery-address" class="link">
							<div class="nation-icon">
								<img src="${pageContext.request.contextPath}/image/top_iso_us.png">
							</div>
							<div class="nation-text">
								<span><strong>미국(NJ)</strong></span>
							</div>
						</a>
					</li>
					<li class="jp nation">
						<a href="${pageContext.request.contextPath}/document/delivery-address" class="link">
							<div class="nation-icon">
								<img src="${pageContext.request.contextPath}/image/top_iso_jp.png">
							</div>
							<div class="nation-text">
								<span><strong>일본(JP)</strong></span>
							</div>
						</a>
					</li>
					<li class="uk nation">
						<a href="${pageContext.request.contextPath}/document/delivery-address" class="link">
							<div class="nation-icon">
								<img src="${pageContext.request.contextPath}/image/top_iso_uk.png">
							</div>
							<div class="nation-text">
								<span><strong>영국(UK)</strong></span>
							</div>
						</a>
					</li>
					<li class="de nation">
						<a href="${pageContext.request.contextPath}/document/delivery-address" class="link">
							<div class="nation-icon">
								<img src="${pageContext.request.contextPath}/image/top_iso_de.png">
							</div>
							<div class="nation-text">
								<span><strong>독일(DE)</strong></span>
							</div>
						</a>
					</li>
					<li class="es nation">
						<a href="${pageContext.request.contextPath}/document/delivery-address" class="link">
							<div class="nation-icon">
								<img src="${pageContext.request.contextPath}/image/top_iso_es.png">
							</div>
							<div class="nation-text">
								<span><strong>스페인(ES)</strong></span>
							</div>
						</a>
					</li>
					<li class="cn nation">
						<a href="${pageContext.request.contextPath}/document/delivery-address" class="link">
							<div class="nation-icon">
								<img src="${pageContext.request.contextPath}/image/top_iso_cn.png">
							</div>
							<div class="nation-text">
								<span><strong>중국(CN)</strong></span>
							</div>
						</a>
					</li>
					<li class="au nation">
						<a href="${pageContext.request.contextPath}/document/delivery-address" class="link">
							<div class="nation-icon">
								<img src="${pageContext.request.contextPath}/image/top_iso_au.png">
							</div>
							<div class="nation-text">
								<span><strong>호주(AU)</strong></span>
							</div>
						</a>
					</li>
				</ul>
			</div>
		</div>
		<div class="head-bottom">
			<div class="nav container">
				<ul class="menu cell center">
					<li class="home w-25"><a href="${pageContext.request.contextPath}"> 다사조 </a></li>

					<li><a href="${pageContext.request.contextPath}/document/buying-info">이용안내</a></li>

					<li><a href="${pageContext.request.contextPath}/document/fee-info">수수료 및 요금표</a></li>

					<li><a href="${pageContext.request.contextPath}/board/notice/list">공지사항</a></li>

					<li><a href="${pageContext.request.contextPath}/board/review/list">이용후기</a></li>

					<li><a href="${pageContext.request.contextPath}/member/ship/request"><button
								class="btn delivery">배송대행 신청하기</button></a></li>

				</ul>
			</div>
		</div>
		<div class="section">
			<div class="article">