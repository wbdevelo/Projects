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
	
/* 목록 */
	.list_area{
		margin: 0 auto;
		text-align: center;
		float: clear;
	}
	.list{
		display: inline-block;
		margin-top: 80px;
	}
	.title_area{
		display: flex;
	}
	.title_area input{
		width:500px;
		height:25px;
		border:2px solid #ffbba0;
	}
	.title{
		padding-right: 50px;
		line-height: 25px;
		font-weight: bold;
	}
	.content_area{
		margin-top: 30px;
		display: flex;
	}
	.content_area textarea{
		width:500px;
		height:400px;
		border:2px solid #ffbba0;
		resize: none;
	}
	.content{
		padding-right: 50px;
		line-height: 25px;
		font-weight: bold;
	}
	
/* 하단 버튼 */
	.bottom_button{
		margin-top: 70px;
		text-align: center;
	}
	.bottom_button input{
		border:0px;
		width:150px;
		height:30px;
		margin-left:50px;
		background-color: #ffbba0;
		border-radius: 3px 3px 3px 3px;
		font-size: 15px;
		cursor: pointer;
		outline: 0;
	}
</style>

<!-- 메뉴 -->
<div class="kindof_area">
	<ul class="kindof">
		<li class="info"><a href="/mypage/information">회원 정보</a></li>
		<li class="activ"><a href="/mypage/activity">활동 내역</a></li>
	</ul>
</div>


<!-- 목록 -->
<form name="list" method="post">
	<div class="list_area">
		<div class="list">
			<div class="title_area">
				<div class="title">제목</div>
				<div><input name="title" id="title"></div>
			</div>
			
			<div class="content_area">
				<div class="content">내용</div>
				<div style="float:left"><textarea name="content" id="content"></textarea></div>
			</div>
		</div>
	</div>

<!-- 하단 버튼 -->
<div class="bottom_button">
	<c:if test="${count > 0}">
		<input type="button" value="목록" onclick="location.href='/customerService/list'">
	</c:if>
	<input type="button" value="저장" onclick="sub_list()">
</div>

</form>


<script>
	function sub_list(){
		var fn = list;
		
		if(!list.title.value){
			alert("제목을 입력해주세요.");
			list.title.focus();
			return;
		}
		if(!list.content.value){
			alert("내용을 입력해주세요.");
			list.content.focus();
			return;
		}
		
		fn.submit();
	}	
</script>

<%@include file="/WEB-INF/views/include/footer.jsp"%>