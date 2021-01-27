<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp"%>



<style>
	.tittt{
		text-align:center;
		line-height:30px;
		border:2px solid #d8d8d8;
	}
</style>

<div style="min-height:460px">
	<div style="display:flex">
		<div style="width:20%"></div>
		<div style="width:79%;display:flex;height:30px;padding-left:300px;">
			<div class="tittt" style="width:8%;font-weight:bold;font-size:18px;">주문번호</div>
			<div class="tittt" style="width:11%;font-weight:bold;font-size:18px;">가격</div>
			<div class="tittt" style="width:11%;font-weight:bold;font-size:18px;">포인트</div>
			<div class="tittt" style="width:40%;font-weight:bold;font-size:18px;">다운로드 유효기간</div>
			<div class="tittt" style="width:11%;font-weight:bold;font-size:18px;">주문현황</div>
		</div>
		<div style="width:20%"></div>
	</div>
	
	<div style="display:flex">
		<div style="width:20%"></div>
		<div style="width:79%;padding-left:300px;">
		<c:forEach var="ov" items="${ov}">
			<c:if test="${ov.date != ''}">
				<fmt:parseDate value="${ov.date}" pattern="yyyyMMdd" var="date"/>
				<fmt:formatDate value="${date}" pattern="yyyy년 MM월 dd일" var="ddate"/>
				<fmt:parseDate value="${ov.date+7}" pattern="yyyyMMdd" var="dateh"/>
				<fmt:formatDate value="${dateh}" pattern="yyyy년 MM월 dd일" var="ddateh"/>
			</c:if>
			<c:choose>
				<c:when test="${ov.state == 'o'}">
					<div style="display:flex;">
						<div class="tittt" style="width:8%;">
							<a href="gumaemokrok.do?uid=${ov.uid}&ddateh=${ddateh}&ddate=${ddate}">${ov.uid}</a>
						</div>
							<fmt:parseNumber var="pricef" value="${ov.price}" integerOnly="true"/>
							<fmt:formatNumber var="price" value="${pricef}"/>
						<div class="tittt" style="width:11%;">
							${price}원
						</div>
						<div class="tittt" style="width:11%;">
							<fmt:parseNumber var="point" value="${pricef*0.05}" integerOnly="true"/>
							${point}p
						</div>
						<div class="tittt" style="width:40%;">
							${ddate} ~ ${ddateh}
						</div>
						<div class="tittt" style="width:11%;">
							<c:if test="${ov.state == 'o'}">
								구매확정
							</c:if>
							<c:if test="${ov.state == '△'}">
								구매확정 대기
							</c:if>
							<c:if test="${ov.state == 'cDaeki'}">
								취소대기
							</c:if>
							<c:if test="${ov.state == 'c'}">
								취소
							</c:if>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div style="display:flex;">
							<fmt:parseNumber var="pricef" value="${ov.price}" integerOnly="true"/>
							<fmt:formatNumber var="price" value="${pricef}"/>
							<fmt:parseNumber var="point" value="${pricef*0.05}" integerOnly="true"/>
						<div class="tittt" style="width:8%;">${ov.uid}</div>
						<div class="tittt" style="width:11%;">${price}원</div>
						<div class="tittt" style="width:11%;">${point}p</div>
						<div class="tittt" style="width:40%;">구매확정 전입니다.</div>
						<div class="tittt" style="width:11%;">
							<c:if test="${ov.state == 'o'}">
								구매확정
							</c:if>
							<c:if test="${ov.state == '△'}">
								구매확정 대기
							</c:if>
							<c:if test="${ov.state == 'cDaeki'}">
								취소대기
							</c:if>
							<c:if test="${ov.state == 'c'}">
								취소
							</c:if>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		</div>
		<div style="width:20%"></div>
	</div>
</div>

<%@ include file="/include/footer.jsp"%>