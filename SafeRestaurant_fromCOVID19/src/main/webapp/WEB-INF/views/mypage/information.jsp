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
	.info{
		border-bottom: 2px solid #dc4300;
	}
	.activ{
		margin-left:30px;
	}
	.info a{
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
		font-size: 15px;
		line-height: 30px;
	}
	.list_content ul{
		display: flex;
	}
	.list_content li{
		list-style: none;
		margin: 0 20px 10px 0;
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
				<li class="activ"><a href="/board/detailpage?code=${code }">내 가게 관리</a></li>
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
	<c:choose>
		<c:when test="${session_storecode == null }">
			<div class="list">
				<div class="list_header">정보수정</div>
				<div class="list_content">
					<ul>
						<li>아이디</li>
						<li>${session_id}</li>
					</ul>
					<ul>
						<li>연락처</li>
						<li>${tel}</li>
					</ul>
				</div>
				<div class="list_footer">
					<div>
						<button class="list_btn" onclick="location.href='/member/modify';">수정</button>
					</div>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<div class="list">
				<div class="list_header">정보수정</div>
				<div class="list_content">
					<ul>
						<li>아이디</li>
						<li>${session_id}</li>
					</ul>
					<ul>
						<li>상호명</li>
						<li>${svo.storename}</li>
					</ul>
					<ul>
						<li>주소</li>
						<li>${svo.address}</li>
					</ul>
					<ul>
						<li>연락처(가게)</li>
						<li>${svo.tel2}</li>
					</ul>
				</div>
				<div class="list_footer">
					<div>
						<button class="list_btn" onclick="location.href='/member/modifystore'">수정</button>
					</div>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
		<div class="list">
			<div class="list_header">회원탈퇴</div>
			<div class="list_content">탈퇴 버튼을 누르시면 바로 탈퇴처리가 됩니다.</div>
			<div class="list_footer">
				<div>
					<button class="list_btn" onclick="goSecession()">탈퇴</button>
				</div>
			</div>
		</div>
	</div>
	<div class="list_column">
		<div class="list">
			<div class="list_header">비밀번호 변경</div>
			<div class="list_content">비밀번호 변경 페이지로 이동합니다.</div>
			<div class="list_footer">
				<div>
					<button class="list_btn" onclick="location.href='/mypage/passChange';">변경</button>
				</div>
			</div>
		</div>
	</div>
</div>


<script>
	function goSecession(){
		var session_id = "${session_id}";
		var session_store = "${session_storecode}";
		
		$.ajax({
			type : "post",
			url : "/mypage/secession",
			data : {
				"id" : session_id,
				"storecode" : session_store
			},
			success : function(data){
				if(data == "secession_ok"){
					alert("탈퇴가 완료되었습니다.");
					location.href="/";
				}
			}
		});
	}
</script>

<%@include file="/WEB-INF/views/include/footer.jsp"%>