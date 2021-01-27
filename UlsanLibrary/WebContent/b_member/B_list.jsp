<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp"%>

<style>
	.guNum{
		width:10%;
	}
	.titlest{
		width:40%;
	}
	.pricest{
		width:20%;
	}
	.guState{
		width:20%;
	}
	.detailbtn{
		width:10%;
	}
	.keun{
		font-weight:bold;
		font-size:20px;
	}
</style>


<div style="display:flex">
	<div style="width:30%"></div>
	<div style="width:39%;">
		<div style="display:flex;text-align:center;height:50px;line-height:50px;border-bottom:2px solid #d8d8d8">
			<div class="guNum">No</div>
			<div class="titlest">주문번호</div>
			<div class="pricest">가격</div>
			<div class="guState">구매현황</div>
			<div class="detailbtn"></div>
		</div>
		<div style="height:20px"></div>
		<div>
			<c:set var="number" value="1"/>
			<c:forEach var="v" items="${v}">
				<form action="/b_member/bmember_mokrok.do" method="post">
					<input type="hidden" name="uid" value="${v.uid}">
					<div style="display:flex;text-align:center;">
						<div class="guNum">${number}</div>
						<div class="titlest">${v.uid}</div>
						<div class="pricest">${v.price}</div>
						<div class="guState">
							<c:if test="${v.state == '△'}">
								구매확정 대기
							</c:if>
							<c:if test="${v.state == 'o'}">
								구매확정
							</c:if>
							<c:if test="${v.state == 'cDaeki'}">
								취소확정 대기
							</c:if>
							<c:if test="${v.state == 'c'}">
								취소
							</c:if>
						</div>
						<c:if test="${v.state == 'o'}">
							<div class="detailbtn">
								<input type="submit" value="상세보기">
							</div>
						</c:if>
					</div>
				</form>
			<fmt:parseNumber var="number" value="${number+1}"/>
			</c:forEach>
		</div>
	</div>
	<div style="width:30%"></div>
</div>

<%@ include file="/include/footer.jsp"%>