<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
.menu-type {
	margin: 0px !important;
}

.menu-list {
	margin: 0px !important;
}

.listArea {
	border: 1px solid #ced3d6;
}

#memberId {
	width: 23%;
}

#memerName {
	width: 13%;
}

#memberEmail {
	width: 50%;
}

#memberCode {
	width: 32%;
}

#isBlock, #memberDetail {
	width: 9%;
}
</style>
<div class="container container-body container-body-long">
	<jsp:include page="/WEB-INF/views/template/admin-sidebar.jsp"></jsp:include>
	<div class="container inner-container">
		<div class="content content-head">
			<div class="content-head-text">
				<i class="fa-solid fa-pause"></i> 배송대행 주문취소목록
			</div>
		</div>
		<div class="content content-body">
			<div class="cell listArea">
				<ul class="menu menu-type">
					<li id="shipSvcNo"><strong>주문서번호</strong></li>
					<li id="poContact"><strong>취소시간</strong></li>
					<li id="poCustomerId"><strong>주문자</strong></li>
					<li id="poClearanceId"><strong>개인통관고유번호</strong></li>
					<li id="poAddress1"><strong>주소</strong></li>
					<li id="poStatus"><strong>상태</strong></li>
					<li id="poDetail"><strong>상세</strong></li>
				</ul>
				<c:forEach var="shipSvcDto" items="${shipSvcDto}">
						<ul class="menu menu-list">
							<li id="poNo">${shipSvcDto.shipSvcNo}</li>
							<li id="shipSvcPayDate"><fmt:formatDate
									value="${shipSvcDto.shipSvcPayDate}" pattern="Y-MM-dd HH:mm" /></li>
							<li id="shipSvcNameKor">${shipSvcDto.shipSvcNameKor}</li>
							<li id="shipSvcClearanceId">${shipSvcDto.shipSvcClearanceId}</li>
							<li id="shipSvcAddress1">${shipSvcDto.shipSvcAddress1}</li>
							<li id="shipSvcStatus">${shipSvcDto.shipSvcStatus}</li>
							<li id="shipSvcDetail"><a href="cancelDetail?shipSvcNo=${shipSvcDto.shipSvcNo}"><i
									class="fa-solid fa-list"></i></a></li>
						</ul>
				</c:forEach>
			</div>
			<div class="cell searchArea center">
				<form action="cancelList" method="get">
					<select name="column" class="searchSelect">
						<option value="shipSvc_no" ${param.column == 'shipSvc_no' ? 'selected' : ''}>주문서</option>
						<option value="shipSvc_customer_id"
							${param.column == 'shipSvc_customer_id' ? 'selected' : ''}>주문자</option>
					</select> <input type="search" name="keyword" placeholder=""
						value="${param.keyword}" class="searchBar">
					<button class="btn searchBtn">
						<i class="fa-solid fa-search"></i>
					</button>
				</form>
			</div>
		</div>
		<div class="page-navigator">
			<%-- 이전이 있을 경우만 링크를 제공 --%>
			<c:choose>
				<c:when test="${pageVO.isFirstBlock()}">
					<a class="off">&lt;이전</a>
				</c:when>
				<c:otherwise>
					<a
						href="cancelList?page=${pageVO.getPrevBlock()}&${pageVO.getQueryString()}">&lt;이전</a>
				</c:otherwise>
			</c:choose>

			<%-- for(int i=beginBlock; i <= endBlock; i++) { .. } --%>
			<c:forEach var="i" begin="${pageVO.getBeginBlock()}"
				end="${pageVO.getEndBlock()}" step="1">
				<%-- 다른 페이지일 경우만 링크를 제공 --%>
				<c:choose>
					<c:when test="${pageVO.isCurrentPage(i)}">
						<a class="on">${i}</a>
					</c:when>
					<c:otherwise>
						<a href="cancelList?page=${i}&${pageVO.getQueryString()}">${i}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>

			<%-- 다음이 있을 경우만 링크를 제공 --%>
			<c:choose>
				<c:when test="${pageVO.isLastBlock()}">
					<a class="off">다음&gt;</a>
				</c:when>
				<c:otherwise>
					<a
						href="cancelList?page=${pageVO.getNextBlock()}&${pageVO.getQueryString()}">다음&gt;</a>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/admin-footer.jsp"></jsp:include>
</body>
</html>