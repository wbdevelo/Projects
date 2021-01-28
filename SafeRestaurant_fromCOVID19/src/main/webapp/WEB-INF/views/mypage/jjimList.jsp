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
		width: 100%;
		text-align: center;
		margin: 0 auto;
		min-height: 658px; 
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.list_row1{
		width:60%;
		display: flex;
		justify-content:space-between;
		flex-wrap: wrap;
	}
	.list{
		width:460px;
		vertical-align: top;
		margin-top: 50px;
		border:1px solid black;
	}
	.list_content{
		margin-top:10px;
		margin-bottom:20px;
		margin-left:10px;
		min-height: 155px;
		text-align: left;
	}
	.list_content ul{
		display: flex;
	}
	.list_content li{
		list-style: none;
		margin: 0 10px 10px 0;
		min-width:50px;
	}
	.list_footer{
		min-height: 40px;
		text-align: left;
	}
	.list_footer div{
		margin-top: 10px;
	}
	.content_img{
		float:left;
	}
	.content_img img{
		width:130px;
		height:130px;
	}
	.content_data{
		float:left;
		display: flex;
	}
	.content_data ul{
		flex-direction: column;
	}
	.data_header{
		width:80px;
		padding-left:20px;
	}
	.data_content{
		width:200px;
		padding-left:20px;
	}
	.cancel_btn{
		text-align: right;
		padding-right:10px;
	}
	.cancel_btn img{
		cursor: pointer;
	}
	.paging_area{
		width:100%;
		padding-top:30px;
		text-align:center;
		margin: 0 auto;
	}
	.paging{
		display:inline-block;
		min-width:150px;
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
	.close{
		cursor: pointer;
		font-size: 20px;
	}
	.close:hover{
		color : red;
	}
</style>


<!-- 메뉴 -->
<div class="kindof_area">
	<ul class="kindof">
		<li class="info"><a href="/mypage/information">회원 정보</a></li>
		<li class="activ"><a href="/mypage/activity">활동 내역</a></li>
	</ul>
</div>


<!-- 리스트 -->
<div class="list_area">
	<div style="width: 20%;"></div>
	<div class="list_row1">
		<c:if test="${list.size() == 0}">
				<div><i class="fas fa-times" style="font-size: 90px;"></i></div>
				<div style="margin-top: 30px;"><h1>찜하신 가게가 없습니다.</h1></div>
		</c:if>
		<c:forEach var="list" items="${list}">
			<div class="list">
				<div class="list_content">
					<div class="cancel_btn">
						<i class="fas fa-times close" onclick="location.href='/mypage/cancel_like?code=${list.code}'"></i>
					</div>
					<div class="content_img"><a href="/board/detailpage?code=${list.code}&date=${list.date}"><img src="/resources/img/burger-4955630_1280.png"></a></div>
					<div class="content_data">
						<ul class="data_header">
							<li>시</li>
							<li>업종</li>
							<li>가게명</li>
							<li>전화번호</li>
						</ul>
						<ul class="data_content">
							<li>${list.si}</li>
							<li>${list.kind_detail}</li>
							<li>${fn:substring(list.name,0,8)} <c:if test="${list.name.length() > 8}">...</c:if></li>
							<li>${list.tel}</li>
						</ul>
					</div>
				</div>
			</div>		
		</c:forEach>
	</div>
	<div style="width: 20%;"></div>
</div>

<c:if test="${list.size() >= 1}">
	<div class="paging_area">
		<div class="paging">
			<div class="paging_content">
				<c:if test="${pvo.nowBlock > 1 && pvo.nowBlock <= pvo.totalBlock}">
					<div class="preBlock"><a href="/mypage/jjimList?nowPage=${pvo.startPage-pvo.pagePerBlock}"><img src="/resources/img/previous.png"></a></div>
				</c:if>
				<c:if test="${pvo.totalPage > 1}">
				<c:forEach var="i" begin="${pvo.startPage}" end="${pvo.endPage}">
						<div class="paging_number"><a href="/mypage/jjimList?nowPage=${i}">${i}</a></div>
				</c:forEach>
				</c:if>
				<c:if test="${pvo.endPage < pvo.totalPage}">
					<div class="nextBlock"><a href="/mypage/jjimList?nowPage=${pvo.startPage+pvo.pagePerBlock}"><img src="/resources/img/next.png"></a></div>
				</c:if>
			</div>
		</div>
	</div>
</c:if>

<%@include file="/WEB-INF/views/include/footer.jsp"%>