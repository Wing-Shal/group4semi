<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
.content-body {
	border: 1px solid #c3cacc;
	font-size: 14px;
	white-space: nowrap;
	margin: 20px 0 20px 0;
}

.info-head {
	font-size: 18px;
	text-align: left;
	background-color: #F5F6F7;;
	padding: 3px 0px 5px 10px;
	border-bottom: 1px solid #c3cacc;
	padding: 10px 0 12px 20px;
}

.info-body {
	padding: 15px 15px 15px 15px;
}

.info-group {
	display: flex;
	padding: 15px 0 15px 0;
	border-bottom: 1px solid #c3cacc;
}

.info-group:first-child {
	padding-top: 0;
}

.info-group:last-child {
	border: none;
	padding-bottom: 0;
}

.info-label {
	width: 20%;
	padding-right: 15px;
	text-align: right;
}

.info-content-wrapper {
	width: 80%;
	padding-left: 15px;
	text-align: left;
}

.btns {
	display: flex;
	justify-content: flex-end;
}

.btn-cancel{
	margin-left: 260px;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$(".weightInput").on("blur", function() {
			var weight = $(this).val();
			$.ajax({
				type : "POST",// 데이터를 줘야해서 POST로 보내야함
				url : "${pageContext.request.contextPath}/rest/ship/getFee",
				data : {
					weight : weight
				},
				success : function(response) {
					$(".itemPrice").text(response.itemPrice); // 물건원화가격
					$(".vat").text(response.vat); // 물건의 부가세
					$(".serviceFee").text(response.fee); // 물건의 수수료
					$(".totalPrice").text(response.totalPrice); // 결제금액
				},
				error: function(xhr, status, error) { // 엉키면...
		            console.error("띠로리...");
		        }
			});
		});
	});
</script>
<script type="text/javascript">
	$(function() {
		if ($(".isBlock").text().trim() === "N") {
			$(".isBlock").css("color", "rgb(71, 163, 255)");
		} else if ($(".isBlock").text().trim() === "Y") {
			$(".isBlock").css("color", "#D1180B");
		}
	});
</script>
<div class="container container-body">
	<jsp:include page="/WEB-INF/views/template/admin-sidebar.jsp"></jsp:include>
	<div class="container inner-container">
		<div class="content content-head">
			<div class="content-head-text">
				<i class="fa-solid fa-user"></i> ${shipSvcDto.shipSvcCustomerId} 님의
				배송대행 신청서
			</div>
		</div>
		<div class="content content-body">
			<div class="info-head w-100">
				<strong>구매자 정보</strong>
			</div>
			<div class="info-body">
				<div class="info-group">
					<div class="info-label">아이디</div>
					<div class="info-content-wrapper">
						<div class="info-content">${shipSvcDto.shipSvcCustomerId}</div>
					</div>
				</div>
				<div class="info-group">
					<div class="info-label">이름(한글)</div>
					<div class="info-content-wrapper">
						<div class="info-content">${shipSvcDto.shipSvcNameKor}</div>
					</div>
				</div>
				<div class="info-group">
					<div class="info-label">이름(영문)</div>
					<div class="info-content-wrapper">
						<div class="info-content">${shipSvcDto.shipSvcNameEng}</div>
					</div>
				</div>
				<div class="info-group">
					<div class="info-label">개인통관고유번호</div>
					<div class="info-content-wrapper">
						<div class="info-content">${shipSvcDto.shipSvcClearanceId}</div>
					</div>
				</div>
				<div class="info-group">
					<div class="info-label">연락처</div>
					<div class="info-content-wrapper">
						<div class="info-content">${shipSvcDto.shipSvcContact}</div>
					</div>
				</div>
			</div>
		</div>
		<div class="content content-body">
			<div class="info-head w-100">
				<strong>배송지</strong>
			</div>
			<div class="info-body">
				<div class="info-group">
					<div class="info-label">주소</div>
					<div class="info-content-wrapper">
						<div class="info-content">${shipSvcDto.shipSvcZipcode}</div>
						<div class="info-content">${shipSvcDto.shipSvcAddress1}</div>
						<div class="info-content">${shipSvcDto.shipSvcAddress2}</div>
					</div>
					<div class="info-group"></div>
					<div class="info-label">배송메모</div>
					<div class="info-content-wrapper">
						<div class="info-content">${shipSvcDto.shipSvcDComment}</div>
					</div>
				</div>
			</div>
		</div>
		<div class="content content-body">
			<div class="info-head w-100">
				<strong>상품정보</strong>
			</div>
			<div class="info-body">
				<div class="info-group">
					<div class="info-label">구매대행정보</div>
					<div class="info-content-wrapper">
						<div class="info-content">국가 ${shipSvcDto.shipSvcCountry}</div>
						<div class="info-content">통화 ${shipSvcDto.shipSvcCurrency}</div>
						<div class="info-content">환율 ${shipSvcDto.shipSvcFxRate}</div>
					</div>
				</div>
				<div class="info-group">
					<div class="info-label">상품링크</div>
					<div class="info-content-wrapper">
						<div class="info-content">${shipSvcDto.shipSvcLink}</div>
					</div>
				</div>
				<div class="info-group">
					<div class="info-label">상품금액(외화)</div>
					<div class="info-content-wrapper">
						<div class="info-content">${shipSvcDto.shipSvcFx}</div>
					</div>
				</div>
				<div class="info-group">
					<div class="info-label">상품이름(영문)</div>
					<div class="info-content-wrapper">
						<div class="info-content">${shipSvcDto.shipSvcItemEngName}</div>
					</div>
				</div>
				<div class="info-group">
					<div class="info-label">상품카테고리</div>
					<div class="info-content-wrapper">
						<div class="info-content">${shipSvcDto.shipSvcItemCategory}</div>
					</div>
				</div>
				<div class="info-group">
					<div class="info-label">상품옵션1</div>
					<div class="info-content-wrapper">
						<div class="info-content">${shipSvcDto.shipSvcItemOption1}</div>
					</div>
				</div>
				<div class="info-group">
					<div class="info-label">상품수량</div>
					<div class="info-content-wrapper">
						<div class="info-content">${shipSvcDto.shipSvcQty}</div>
					</div>
				</div>
				<div class="info-group">
					<div class="info-label">신청서 작성시간</div>
					<div class="info-content-wrapper">
						<div class="info-content">
							<fmt:formatDate value="${shipSvcDto.shipSvcSDate}"
								pattern="y년 M월 d일 E H시 m분 s초" />
						</div>
					</div>
				</div>
				<div class="info-head w-100">
					<strong>결제정보</strong>
				</div>
				<!-- 사용자에게 결제금액 전달해주는 창인데 자동계산되게 함
				원래 200달러 이상만 부가세 대상인데 우리는 다른 통화가 있어서..
				그것까지 고려하면 너무 어려워서 그냥 20만원 이상이면 부가세 내게 함
				 -->
				<form action="orderDetail" method="post" autocomplete="off">
					<div class="info-body">
						<div class="info-group">
							<div class="info-label">상품무게</div>
							<div class="info-content-wrapper">
								<div class="info-content">
									<div class="info-content">${shipSvcDto.shipSvcItemWeight}</div>
								</div>
							</div>
						</div>
						<div class="info-group">
							<div class="info-label">상품금액(원화)</div>
							<div class="info-content-wrapper">
								<div class="info-content">
									<input type="text" name="shipSvcItemPriceKrw" class="itemPrice"
										value="${shipSvcDto.shipSvcItemPriceKrw}" readonly>
								</div>
							</div>
						</div>
						<div class="info-group">
							<div class="info-label">부가세</div>
							<div class="info-content-wrapper">
								<div class="info-content">
									<c:choose>
										<c:when test="${shipSvcDto.itemPrice >= 200000}">
											<input type="text" name="shipSvcItemVat" class="vat"
												value="${shipSvcDto.vat}" readonly>
										</c:when>
										<c:otherwise>
											<input type="text" name="shipSvcItemVat" value="0" readonly>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
						<div class="info-group">
							<div class="info-label">수수료</div>
							<div class="info-content-wrapper">
								<div class="info-content">
									<input type="text" name="shipSvcServiceFee" class="serviceFee"
										value="${shipSvcDto.fee}" readonly>
								</div>
							</div>
						</div>
						<div class="info-group">
							<div class="info-label">결제금액</div>
							<div class="info-content-wrapper">
								<div class="info-content">
									<input type="text" name="shipSvcTotalPriceKrw" class="totalPrice"
										value="${shipSvcDto.totalPrice}" readonly>
								</div>
							</div>
						</div>
						<input type="hidden" name="shipSvcStatus" value="결제 대기 중">
						<input type="hidden" name="shipSvcNo"
							value="${shipSvcDto.shipSvcNo}">
						<div class="cell right">
							<button type="submit" class="btn">사용자에게 전송</button>
						</div>
				</form>
				<div class="cell btns">
					<div class="cell">
						<a href="${pageContext.request.contextPath}/admin/ship/orderList" class="link">
							<button type="button" class="btn btn-list">목록으로</button>
						</a> 
					</div>
					<div class="cell">
						<a href="${pageContext.request.contextPath}/admin/ship/orderCancel?shipSvcNo=${shipSvcDto.shipSvcNo}" class="link">
							<button type="button" class="btn btn-cancel negative">주문서 반려</button>
						</a>
					</div>
				</div>
				<a href="${pageContext.request.contextPath}/admin/ship/orderInvoice?shipSvcNo=${shipSvcDto.shipSvcNo}" class="link">
						견적내러가기	
				</a>
			</div>
		</div>
	</div>
</div>



<jsp:include page="/WEB-INF/views/template/admin-footer.jsp"></jsp:include>
</body>
</html>