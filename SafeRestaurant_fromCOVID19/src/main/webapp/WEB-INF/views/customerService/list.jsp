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
	
/* 문의하기 버튼 */
	.ask_btn{
		margin-top: 50px;
		width: 75%;
		text-align: right;
	}
	.ask_btn button{
		border:2px solid #dc4300;
		width:100px;
		height:30px;
		margin-left:50px;
		background-color: white;
		font-size: 15px;
		cursor: pointer;
		outline: 0;
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
		margin-top: 20px;
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
	.number{
		width:10%;
		line-height: 40px;
	}
	.title{
		width:40%;
		line-height: 40px;
	}
	.date{
		width:30%;
		line-height: 40px;
	}
	.check{
		width:20%;
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
<div class="kindof_area">
	<ul class="kindof">
		<li class="info"><a href="/mypage/information">회원 정보</a></li>
		<li class="activ"><a href="/mypage/activity">활동 내역</a></li>
	</ul>
</div>

<!-- 문의하기 버튼 -->
<div class="ask_btn"><button onclick="location.href='write'">문의하기</button></div>

<!-- 리스트 -->
<div class="list_area">
	<div class="list">
		<div class="list_header">
			<div class="number"><b>No</b></div>
			<div class="title"><b>제목</b></div>
			<div class="date"><b>날짜</b></div>
			<div class="check"><b>관리자 확인</b></div>
		</div>
		<c:set var="i" value="${listNum}"/>
		<c:forEach var="list" items="${list}">
			<div class="list_content">
				<div class="number">${i}</div>
				<div class="title"><a href="view?uid=${list.uid}">${list.title}</a></div>
				<div class="date">${list.date}</div>
				<div class="check">
					<c:choose>
						<c:when test="${list.count == 0}">
						</c:when>
						<c:otherwise>
							확인
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		<c:set var="i" value="${i-1}"/>
		</c:forEach>
	</div>
</div>

<div class="paging_area">
	<div class="paging">
		<div class="paging_content">
			<c:if test="${pvo.nowBlock > 1 && pvo.nowBlock <= pvo.totalBlock}">
				<div class="preBlock"><a href="/customerService/list?nowPage=${pvo.startPage-pvo.pagePerBlock}"><img src="/resources/img/previous.png"></a></div>
			</c:if>
			<c:if test="${pvo.totalPage > 1}">
			<c:forEach var="i" begin="${pvo.startPage}" end="${pvo.endPage}">
					<div class="paging_number"><a href="/customerService/list?nowPage=${i}">${i}</a></div>
			</c:forEach>
			</c:if>
			<c:if test="${pvo.endPage < pvo.totalPage}">
				<div class="nextBlock"><a href="/customerService/list?nowPage=${pvo.startPage+pvo.pagePerBlock}"><img src="/resources/img/next.png"></a></div>
			</c:if>
		</div>
	</div>
</div>

<%@include file="/WEB-INF/views/include/footer.jsp"%>