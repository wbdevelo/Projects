<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		width:950px;
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
	
	.list_area{
		width:99%;
		text-align: center;
		margin: 0 auto;
		min-height: 658px;
	}
	.list_column{
		display: inline-block;
		width:482px;
		vertical-align: top;
		margin-top: 70px;
	}
	.list{
		margin: 15px 10px 0;
		padding: 20px 20px 20px;
		border:1px solid black;
		min-height: 150px;
	}
	.list_content{
		margin-top:20px;
		min-height: 100px;
		text-align: left;
		font-size:15px;
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
	.list_btn{
		background-color: white;
		height:30px;
		width:100px;
		cursor: pointer;
		border:1px solid black;
	}
	.list_header{
		text-align: left;
		font-weight: bold;
		font-size: 20px;
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


<!-- 목록 -->
<div class="list_area">
	<div class="list_column">
		<div class="list">
			<div class="list_header">찜 목록</div>
			<div class="list_content">찜한 식당의 목록을 볼 수 있는 페이지로 이동합니다.</div>
			<div class="list_footer">
				<div>
					<button class="list_btn" onclick="location.href='/mypage/jjimList'">확인하기</button>
				</div>
			</div>
		</div>
		<div class="list">
			<div class="list_header">예약 내역</div>
			<div class="list_content">예약 내역을 볼 수 있는 페이지로 이동합니다.</div>
			<div class="list_footer">
				<c:if test="${session_storecode == null }">
					<div>
						<button class="list_btn" onclick="location.href='/mypage/reservList'">확인하기</button>
					</div>
				</c:if>
				<c:if test="${session_storecode != null }">
					<div>
						<button class="list_btn" onclick="location.href='/mypage/reservList2'">확인하기</button>
					</div>
				</c:if>
			</div>
		</div>
	</div>
	<div class="list_column">
		<c:set var="count" value="${count }"/>
		<div class="list">
			<div class="list_header">문의 내역</div>
			<div class="list_content">1:1 문의 내역을 볼 수 있는 페이지로 이동합니다.</div>
			<div class="list_footer">
				<div>
					<c:if test="${count == 0}">
						<button class="list_btn" onclick="location.href='/customerService/write'">확인하기</button>
					</c:if>
					<c:if test="${count > 0}">
						<button class="list_btn" onclick="location.href='/customerService/list'">확인하기</button>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</div>

<%@include file="/WEB-INF/views/include/footer.jsp"%>