<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%-- 템플릿 페이지를 불러오는 코드 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- 스위퍼  cdn-->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<script
	src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<style>
.swiper {
	width: 1140px;
	height: 400px;
}

.head-banner {
	background-color: #FFE0F0;
}

.swiper-button-prev, .swiper-button-next {
	border-radius: 20px;
	color: #FFFFFF !important;
}

.swiper-button-prev:after, .swiper-button-next:after {
	font-size: 52px !important;
	font-weight: 100 !important;
}

.link-container {
	width: 1140px;
}

.link-wrapper {
	display: flex;
	margin: 30px 10px 20px 10px;
}

.link-kh {
	flex: 5;
	border-top: 1px solid #d8d8d8;
	border-bottom: 1px solid #d8d8d8;
	padding: 10px;
}

.btn.ship, .btn.buying {
	color: white;
	white-space: nowrap;
	width: 150px;
	height: 130px;
	font-size: 20px;
}

.link-ship {
	flex: 1;
	padding: 10px;
}

.btn.ship {
	background-color: rgb(0, 151, 150);
}

.link-buying {
	flex: 1;
	padding: 10px;
}

.btn.buying {
	background-color: rgb(234, 111, 0);
}

.add {
	max-width: 100%;
}

.best-review {
	width: 1140px;
	margin-top: 20px;
	margin-bottom: 20px;
}

.middle-banner {
	margin-top: 20px;
}

.review-wrapper {
	display: flex;
}

.review-content {
	padding: 20px;
	margin-left: 10px;
	margin-right: 5px;
	border: 1px solid #d8d8d8;
}

.reviewImage {
	height: 323px;
}
</style>
<script type="text/javascript">
	$(function() {
		var swiper = new Swiper('.banners', {
			direction : 'horizontal',
			loop : true,
			speed : 2000,
			autoplay : {
				delay : 5000,
				disableOnInteraction : false,
			},
			navigation : {
				nextEl : '.swiper-button-next',//다음버튼 선택자
				prevEl : '.swiper-button-prev',//이전버튼 선택자
			},
		// effect: 'slide',
		});

		var colors = [ "#FFE0F0", "#FCFFD2", "#F3ECDC", "#90DEF2", "#4F70D9",
				"#8A50E2", "#FFD800" ];

		swiper.on('slideChange', function() {
			var index = swiper.realIndex;
			$(".head-banner").css({
				"backgroundColor" : colors[index],
				"transition" : "background-color 3s",
			});
		});

		var swiper2 = new Swiper('.banners2', {
			direction : 'horizontal',
			loop : true,
			speed : 4000,
			slidesPerView : 2, // 동시에 보여줄 슬라이드 갯수
			spaceBetween : 30, // 슬라이드간 간격
			slidesPerGroup : 1, // 그룹으로 묶을 수
			autoplay : {
				delay : 2000,
				disableOnInteraction : false,
			},
			navigation : {
				nextEl : '.swiper-button-next',//다음버튼 선택자
				prevEl : '.swiper-button-prev',//이전버튼 선택자
			},
		});

		var swiper3 = new Swiper('.banners3', {
			loop : true,
			speed : 2000,
			effect : 'fade',
			fadeEffect: { crossFade: true },
			pagination : {
				el : '.swiper-pagination-custom',
				clickable : true,
				renderBullet : function(index, className) {
					var pageName;
					switch (index) {
					case 0:
						pageName = '미국'
						break;
					case 1:
						pageName = '영국'
						break;
					case 2:
						pageName = '독일'
						break;
					case 3:
						pageName = '일본'
						break;
					case 4:
						pageName = '중국'
						break;
					case 5:
						pageName = '스페인'
						break;
					}
					return '<span class="' + className + '">' + pageName
							+ '</span>';
				},
			},
		});

	});
</script>
<div class="head-banner">
	<div class="swiper banners center">
		<div class="swiper-wrapper">
			<div class="swiper-slide">
				<img src="image/01_배너_제휴이벤트.jpg">
			</div>
			<div class="swiper-slide">
				<img src="image/02_배너_3월쿠폰.jpg">
			</div>
			<div class="swiper-slide">
				<img src="image/03_배너_부피무게면제.jpg">
			</div>
			<div class="swiper-slide">
				<img src="image/04_배너_보험서비스.jpg">
			</div>
			<div class="swiper-slide">
				<img src="image/05_배너_수수료안내.jpg">
			</div>
			<div class="swiper-slide">
				<img src="image/06_배너_웰컴쿠폰.jpg">
			</div>
			<div class="swiper-slide">
				<img src="image/07_배너_카카오톡플러스친구.jpg">
			</div>
		</div>
		<div class="swiper-button-prev"></div>
		<div class="swiper-button-next"></div>
	</div>
</div>
<div class="container link-container">
	<div class="link-wrapper">
		<div class="link-kh center">
			<a class="link" href="https://kh-academy.co.kr/main/main.kh" target='_blank'> <img
				class="m-10" src="${pageContext.request.contextPath}/image/KH정보교육원 로고.png">
			</a>
		</div>
		<div class="link-ship center">
			<a class="link" href="${pageContext.request.contextPath}/member/ship/request">
				<button class="btn ship">
					<strong>배송대행</strong><br>신청하기
				</button>
			</a>
		</div>
		<div class="link-buying center">
			<a class="link" href="${pageContext.request.contextPath}/member/po/request">
				<button class="btn buying">
					<strong>구매대행</strong><br>신청하기
				</button>
			</a>
		</div>
	</div>
</div>
<br>
<br>
<div class="container sponsor-title">
	<div class="cell center">
		<h3>후원사</h3>
		<hr width="1140px">
	</div>
</div>
<div class="middle-banner">
	<div class="swiper banners2 center">
		<div class="swiper-wrapper">
			<div class="swiper-slide">
				<a class="link" href="https://docs.sysout.co.kr/" target='_blank'>
					<img class="add" src="${pageContext.request.contextPath}/image/Hacademy.png">
				</a>
			</div>
			<div class="swiper-slide">
				<a class="link"
					href="https://www.youtube.com/channel/UCdllyP_VgK-PY7VJRWOkOKQ"
					target='_blank'> <img class="add" src="${pageContext.request.contextPath}/image/열혈강사youtube.png">
				</a>
			</div>
			<div class="swiper-slide">
				<a class="link" href="https://video.sysout.co.kr/" target='_blank'>
					<img class="add" src="${pageContext.request.contextPath}/image/video-sysout.png">
				</a>
			</div>
		</div>
		<div class="swiper-button-prev"></div>
		<div class="swiper-button-next"></div>
	</div>
</div>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						$.ajax({
							url : "${pageContext.request.contextPath}/rest/best-review",
							method : "GET",
							success : function(response) {
								var container = $("<div class='review-wrapper'></div>");
								for (var i = 0; i < response.length; i++) {
									var review = response[i];
									var reviewNo = review.reviewNo;
									var reviewWriter = review.reviewWriter;

									var reviewImage = $("<img class='reviewImage w-100' src='${pageContext.request.contextPath}/board/review/image?reviewNo=" + reviewNo + "'>");
									var reviewLink = $("<a class='link review-link'></a>")
											.attr("href", "${pageContext.request.contextPath}/board/review/detail?reviewNo=" + reviewNo)
											.text(reviewWriter + '님의 리뷰')
											.css("font-size", "14px");
									var listItem = $("<div class='w-100 center review-content'></div>")
											.append(reviewImage)
											.append(reviewLink);
									container.append(listItem);
								}
								$(".best-review").append(container);
							},
							error : function(xhr, status, error) {
								console.error("띠로리...");
							}
						});
					});
</script>
<div class="container best-review-title">
	<div class="cell center">
		<h3>베스트 후기</h3>
		<hr width="1140px">
	</div>
</div>
<div class="container best-review"></div>
<div class="bottom-banner">
	<div class="swiper banners3 center">
		<div class="custom-slide-wrapper">
			<div class="swiper-pagination-custom"></div>
		</div>
		<div class="swiper-wrapper">
			<div class="swiper-slide us">
				<div class="link-wrapper">
					<ul class="menu line">
						<li class="image-wrapper">
						<a class="link" href="https://www.amazon.com/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/us_shop/amazon.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.ebay.com/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/us_shop/ebay.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.shopbop.com/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/us_shop/shopbop.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.6pm.com/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/us_shop/6pm.jpg">
						</a>
						</li>
					</ul>
					<ul class="menu line">
						<li class="image-wrapper">
						<a class="link" href="https://www.target.com/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/us_shop/target.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://athleta.gap.com/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/us_shop/gap.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.yoox.com/us/women" target="_blank">
							<img src="${pageContext.request.contextPath}/image/us_shop/yoox.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="http://www.ralphlauren.com/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/us_shop/ralph_lauren.jpg">
						</a>
						</li>
					</ul>
					<ul class="menu line">
						<li class="image-wrapper">
						<a class="link" href="https://www.walmart.com/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/us_shop/walmart.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.zappos.com/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/us_shop/zappos.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.footlocker.com/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/us_shop/Foot_locker.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.gymboree.com/home?lang=en_KR" target="_blank">
							<img src="${pageContext.request.contextPath}/image/us_shop/gymboree.jpg">
						</a>
						</li>
					</ul>
				</div>
			</div>
			<div class="swiper-slide uk">
				<div class="link-wrapper">
					<ul class="menu line">
						<li class="image-wrapper">
						<a class="link" href="https://www.asos.com/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/uk_shop/asos.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.ebay.co.uk/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/uk_shop/ebay.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.asos.com/topshop/?ctaref=ts|ww|gb|web" target="_blank">
							<img src="${pageContext.request.contextPath}/image/uk_shop/topshop.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.amazon.co.uk/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/uk_shop/amazon.jpg">
						</a>
						</li>
					</ul>
					<ul class="menu line">
						<li class="image-wrapper">
						<a class="link" href="https://www.boots.com/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/uk_shop/boots.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.nealsyardremedies.com/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/uk_shop/nealsyardremedies1.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.nealsyardremedies.com/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/uk_shop/nealsyardremedies2.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.lush.com/uk/en" target="_blank">
							<img src="${pageContext.request.contextPath}/image/uk_shop/lush.jpg">
						</a>
						</li>
					</ul>
					<ul class="menu line">
						<li class="image-wrapper">
						<a class="link" href="https://www.harrods.com/en-gb" target="_blank">
							<img src="${pageContext.request.contextPath}/image/uk_shop/harrods.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.next.co.uk/cath-kidston" target="_blank">
							<img src="${pageContext.request.contextPath}/image/uk_shop/next.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.cos.com/ko-kr/index.html" target="_blank">
							<img src="${pageContext.request.contextPath}/image/uk_shop/cos.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.selfridges.com/GB/en/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/uk_shop/selfridges.jpg">
						</a>
						</li>
					</ul>
				</div>
			</div>
			<div class="swiper-slide de">
				<div class="link-wrapper">
					<ul class="menu line">
						<li class="image-wrapper">
						<a class="link" href="https://www.nespresso.com/de/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/de_shop/nespresso.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.shop-apotheke.com/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/de_shop/shop_apotheke.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://myapo-shop.de/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/de_shop/myapo_shop.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.amazon.de/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/de_shop/amazon.jpg">
						</a>
						</li>
					</ul>
					<ul class="menu line">
						<li class="image-wrapper">
						<a class="link" href="https://www.peek-cloppenburg.de/de/stylebop" target="_blank">
							<img src="${pageContext.request.contextPath}/image/de_shop/peek.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.playmobil.com/de-de/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/de_shop/playmobil.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.mytheresa.com/de/en?rdr_src=mag" target="_blank">
							<img src="${pageContext.request.contextPath}/image/de_shop/mytheresa.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.mycare.de/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/de_shop/mycare.jpg">
						</a>
						</li>
					</ul>
					<ul class="menu line">
						<li class="image-wrapper">
						<a class="link" href="https://www.cos.com/ko-kr/index.html" target="_blank">
							<img src="${pageContext.request.contextPath}/image/de_shop/cos.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.zalando.de/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/de_shop/zalando.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.otto.de/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/de_shop/otto.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.otto.de/mytoys/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/de_shop/mytoys.jpg">
						</a>
						</li>
					</ul>
				</div>
			</div>
			<div class="swiper-slide jp">
				<div class="link-wrapper">
					<ul class="menu line">
						<li class="image-wrapper">
						<a class="link" href="https://www.rakuten.co.jp/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/jp_shop/rakuten.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://auctions.yahoo.co.jp/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/jp_shop/yahoo.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://zozo.jp/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/jp_shop/zozo.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.buyma.com/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/jp_shop/buyma.jpg">
						</a>
						</li>
					</ul>
					<ul class="menu line">
						<li class="image-wrapper">
						<a class="link" href="https://hands.net/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/jp_shop/hands.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://francfranc.com/shop?pc_header_h" target="_blank">
							<img src="${pageContext.request.contextPath}/image/jp_shop/franc.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.muji.com/jp/ja/store" target="_blank">
							<img src="${pageContext.request.contextPath}/image/jp_shop/muji.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.suruga-ya.jp/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/jp_shop/suruga.jpg">
						</a>
						</li>
					</ul>
					<ul class="menu line">
						<li class="image-wrapper">
						<a class="link" href="https://ssx.xebio-online.com/ec/cmShopTopPage1.html" target="_blank">
							<img src="${pageContext.request.contextPath}/image/jp_shop/xebio.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.konami.com/games/jp/ja/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/jp_shop/konami.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.yodobashi.com/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/jp_shop/yodobashi.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://p-bandai.jp/global_pc.html" target="_blank">
							<img src="${pageContext.request.contextPath}/image/jp_shop/bandai.jpg">
						</a>
						</li>
					</ul>
				</div>
			</div>
			<div class="swiper-slide cn">
				<div class="link-wrapper">
					<ul class="menu line">
						<li class="image-wrapper">
						<a class="link" href="https://www.1688.com/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/cn_shop/1688.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://global.jd.com/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/cn_shop/jd.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.tmall.com/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/cn_shop/tmall.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.dangdang.com/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/cn_shop/dangdang.jpg">
						</a>
						</li>
					</ul>
					<ul class="menu line">
						<li class="image-wrapper">
						<a class="link" href="http://www.suning.com" target="_blank">
							<img src="${pageContext.request.contextPath}/image/cn_shop/suning.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://ko.aliexpress.com/?gateayAdapt=glo2kor" target="_blank">
							<img src="${pageContext.request.contextPath}/image/cn_shop/ali.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="http://www.taobao.com/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/cn_shop/taobao.jpg">
						</a>
						</li>
						<li class="">
						<a class="link" href="" target="_blank">
							<img src="">
						</a>
						</li>
					</ul>
				</div>
			</div>
			<div class="swiper-slide es">
				<div class="link-wrapper">
					<ul class="menu line">
						<li class="image-wrapper">
						<a class="link" href="https://www.zara.com/es/en/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/es_shop/zara.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.zarahome.com/es/en/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/es_shop/zara_home.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="http://shop.mango.com/es" target="_blank">
							<img src="${pageContext.request.contextPath}/image/es_shop/mango.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.lush.com/es/es" target="_blank">
							<img src="${pageContext.request.contextPath}/image/es_shop/lush.jpg">
						</a>
						</li>
					</ul>
					<ul class="menu line">
						<li class="image-wrapper">
						<a class="link" href="https://es.maje.com/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/es_shop/maje.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.massimodutti.com/es/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/es_shop/massimodutti.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.bershka.com/es/h-woman.html" target="_blank">
							<img src="${pageContext.request.contextPath}/image/es_shop/bershka.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="http://es.sandro-paris.com/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/es_shop/sandro.jpg">
						</a>
						</li>
					</ul>
					<ul class="menu line">
						<li class="image-wrapper">
						<a class="link" href="https://www.oysho.com/es/en/" target="_blank">
							<img src="${pageContext.request.contextPath}/image/es_shop/oysho.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.massimodutti.com/es" target="_blank">
							<img src="${pageContext.request.contextPath}/image/es_shop/massimodutti.jpg">
						</a>
						</li>
						<li class="image-wrapper">
						<a class="link" href="https://www.camper.com/en_ES" target="_blank">
							<img src="${pageContext.request.contextPath}/image/es_shop/camper.jpg">
						</a>
						</li>
						<li class="">
						<a class="link" href="" target="_blank">
							<img src="">
						</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<style>
.swiper-pagination-custom {
	display: flex;
	justify-content: center;
	align-items: center;
	margin-top: 20px;
	margin-bottom: 20px;
}

.swiper-pagination-custom .swiper-pagination-bullet {
	justify-content: center;
    align-items: center;
    display: flex;
	width: 87px;
	height: 32px;
	background-color: white;
	margin: 0 5px; /* 각 버튼 간격 조절 */
	cursor: pointer;
	border-radius: 0;
	border: 1px solid #2D3436;
	color: #2D3436;
	opacity: 1;
}

.swiper-pagination-custom .swiper-pagination-bullet-active {
	background-color: rgb(234, 111, 0); /* 활성화된 버튼의 배경색 */
	color: white;
	border: none;
}

.link-wrapper {
	justify-content: center;
	flex-wrap: wrap;
}

.line {
	margin:10px;
}/* 세로 ul에 마진*/

.image-wrapper {
    border: 1px solid #d8d8d8;
}/* 이미지 감싸는 li에 테두리*/

.image-wrapper img {
    width: 100%; 
    height: auto; 
    display: block; 
}/* 이미지가 li태그 안으로 들어가도록*/
</style>
<%-- 템플릿 페이지를 불러오는 코드 --%>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>







