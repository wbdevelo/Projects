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
		cursor: default;
		outline: 0;
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
		cursor: default;
		outline: 0;
		resize: none;
	}
	.content{
		padding-right: 50px;
		line-height: 25px;
		font-weight: bold;
	}
	
/* 댓글 */
	.answer_area{
		margin: 0 auto;
		text-align: center;
	}	
	.answer_frame{
		display: inline-block;
		width: 40%;
		margin-top: 50px;
	}
	.answer_write{
		margin-left:85px;
		display: flex;
	}
	.answer_text{
		margin: 30px 30px 30px 150px;
	}
	.answer_text textarea{
		width:300px;
		height:100px;
		resize: none;
		outline: 0;
		border:2px solid black;
	}
	.answer_inp{
		line-height: 160px;
	}
	.answer_inp input{
		width:70px;
		height:30px;
		border:2px solid black;
		background-color: white;
		border-radius: 3px 3px 3px 3px;
	}
	.answer_view{
		text-align: left;
		margin-top: 20px;
		display: flex;
		margin-left: 140px;
	}
	.answer_view textarea{
		width:300px;
		min-height: 20px;
		overflow: visible;
		cursor: default;
		outline: none;
	}
	.name{
		 padding-right: 35px;
		 text-align: center;
	}
	.date{
		 margin-left: 40px;
		 text-align: center;
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
<div class="list_area">
	<div class="list">
		<div class="title_area">
			<div class="title">제목</div>
			<div><input value="${data.title}" readonly="readonly"></div>
		</div>
		
		<div class="content_area">
			<div class="content">내용</div>
			<div><textarea readonly="readonly">${data.content}</textarea></div>
		</div>
	</div>
</div>

<!-- 댓글 -->
<div class="answer_area">
	<div class="answer_frame">
		<c:if test="${session_level eq '10'}">
			<div class="answer_write">
				<div class="answer_text"><textarea id="answer_text"></textarea></div>
				<div class="answer_inp"><input type="button" onclick="sub_form()" value="쓰기"></div>
			</div>
		</c:if>
		<c:forEach var="answer" items="${answer}">
			<div class="answer_view">
				<div class="name">관리자</div>
				<div><textarea readonly="readonly">${answer.content}</textarea></div>
				<div class="date">${answer.date}</div>
			</div>
		</c:forEach>
	</div>
</div>

<!-- 하단 버튼 -->
<div class="bottom_button">
	<input type="button" value="목록" onclick="location.href='/customerService/list'">
</div>


<script>
	function sub_form(){
		var text = $("#answer_text").val();
		var uid = "${param.uid}";
		
		if(text == ""){
			alert("글을 입력해주세요.");
			 $("#answer_text").focus();
			 return;
		}
		
		$("#answer_text").val("");
		
		$.ajax({
			type : "post",
			url : "/customerService/answer",
			data : {
				"text" : text,
				"uid" : uid
			},
			success : function(data){
				var str = "";
				
				$(".answer_view").remove();
				
				$.each(data, function(index, item){
					str += '<div class="answer_view">'
						+ '<div class="name">관리자</div>'
						+ '<div><textarea>'+this['content']+'</textarea></div>'
						+ '<div class="date">'+this['date']+'</div>'
						+ '</div>';
				});
				
				$(".answer_frame").append(str);
			}
		});
	}
</script>

<%@include file="/WEB-INF/views/include/footer.jsp"%>