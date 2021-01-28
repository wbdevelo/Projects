<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@include file="/WEB-INF/views/include/nav.jsp"%>

<style>
	.kindof_area{
		width:99%;
		height:40px;
		font-size:15px;
		font-weight:600;
		text-align:center;
		margin:0 auto;
	}
	.kindof{
		height:100%;
		width:51%;
		display:inline-block;
		text-align:left;
	}
	.kindof li{
		float: left;
		list-style: none;
		line-height: 39px;
	}
	a{
		text-decoration: none;
	}
	a:link{
		color:black;
	}
	a:visited{
		color:black;
	}
	.activ{
		margin-left:30px;
		border-bottom: 2px solid #dc4300;
	}
	.activ a{
		color: #dc4300;
	}
	
/* 리스트 */
	.list_area{
		text-align: center;
		margin: 0 auto;
		width: 99%;
	}
	.list{
		display: inline-block;
		min-height: 400px;
		width: 51%;
		margin-top: 50px;
	}
	.list0{
		display: inline-block;
		height: 400px;
		width: 51%;
		margin-top: 200px;
	}
	.list_header{
		width: 100%;
		display: flex;
		height:40px;
		background-color: #ffbba0;
		border-top: 1px solid #dc4300;
		border-bottom: 1px solid #dc4300;
		font-size: 18px;
	}
	.name{
		width:30%;
		line-height: 40px;
	}
	.tel{
		width:25%;
		line-height: 40px;
	}
	.time{
		width:25%;
		line-height: 40px;
	}
	.number{
		width: 15%;
		line-height: 40px;
	}
	.cancel{
		width:10%;
		line-height: 40px;
	}
	.list_content{
		display: flex;
		width: 100%;
		min-height: 40px;
		border-bottom: 1px solid #dc4300;
		font-size: 14px;
	}

/* 페이징 */
	.paging_area{
		width:100%;
		padding-top:30px;
		text-align:center;
		margin: 0 auto;
	}
	.paging{
		display:inline-block;
		width:150px;
	}
	.paging_content{
		display:flex;
	}
	.paging_number{
		width:50px;
	}
	.preBlock{
		padding-right:10px;
		padding-top:3px;
	}
	.nextBlock{
		padding-left:10px;
		padding-top:3px;
	}
</style>


<!-- 메뉴 -->
<c:choose>
	<c:when test="${session_storecode != null }">
		<c:set var="code" value="${session_storecode }"/>
		<div class="kindof_area">
			<ul class="kindof">
				<li class="info"><a href="/mypage/information">회원 정보</a></li>
				<li class="activ"><a href="/mypage/activity">활동 내역</a></li>
				<li class="info" style="margin-left: 30px;"><a href="/board/detailpage?code=${code }">내 가게 관리</a></li>
			</ul>
		</div>
	</c:when>
	<c:otherwise>
		<div class="kindof_area">
			<ul class="kindof">
				<li class="info"><a href="/mypage/information">회원 정보</a></li>
				<li class="activ"><a href="/mypage/activity">활동 내역</a></li>
			</ul>
		</div>
	</c:otherwise>
</c:choose>

<fmt:parseDate var="todayDate" value="${todate}" pattern="yyyy-MM-dd"/>
<fmt:formatDate var="todayDate" value="${todayDate}" pattern="yyyyMMdd"/>

<div class="list_area">
	<c:if test="${list.size() == 0}">
		<div class="list0">
			<i class="fas fa-times" style="font-size: 90px;"></i><br><br>
			예약 내역이 없습니다.
		</div>
	</c:if>
	<c:if test="${list.size() > 0}">
		<div class="list">
			<div class="list_header">
				<div class="name"><b>예약자</b></div>
				<div class="tel"><b>식당번호</b></div>
				<div class="time"><b>예약시간</b></div>
				<div class="number"><b>예약명수</b></div>
				<div class="cancel"></div>
			</div>
			<c:forEach var="list" items="${list}">
				<div class="list_content">
					<div class="name">${list.id}</div>
					<div class="tel">${list.res_tel}</div>
					<div class="time">${list.reserv_date}&nbsp;&nbsp;${list.reserv_time}</div>
					<div class="number">${list.peopleNum} 명</div>
					<div class="cancel">
						<fmt:parseDate var="reserv_date" value="${list.reserv_date}" pattern="yyyy-MM-dd" />
						<fmt:formatDate var="reserv_date" value="${reserv_date}" pattern="yyyyMMdd" />
						<c:if test="${todayDate < reserv_date}">
							<a href="/mypage/reserv_cancel?uid=${list.uid}">예약취소</a>
						</c:if>
					</div>
				</div>
			</c:forEach>
		</div>
	</c:if>
</div>

<div class="paging_area">
	<div class="paging">
		<div class="paging_content">
			<c:if test="${pvo.nowBlock > 1 && pvo.nowBlock <= pvo.totalBlock}">
				<div class="preBlock"><a href="/mypage/reservList?nowPage=${pvo.startPage-pvo.pagePerBlock}"><img src="/resources/img/previous.png"></a></div>
			</c:if>
			<c:if test="${pvo.totalPage > 1}">
			<c:forEach var="i" begin="${pvo.startPage}" end="${pvo.endPage}">
					<div class="paging_number"><a href="/mypage/reservList?nowPage=${i}">${i}</a></div>
			</c:forEach>
			</c:if>
			<c:if test="${pvo.endPage < pvo.totalPage}">
				<div class="nextBlock"><a href="/mypage/reservList?nowPage=${pvo.startPage+pvo.pagePerBlock}"><img src="/resources/img/next.png"></a></div>
			</c:if>
		</div>
	</div>
</div>

<%@include file="/WEB-INF/views/include/footer.jsp"%>