<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>


<script>
	function subjoin(){
		fo = document.joiin;
		
		if(!fo.id.value){
			alert("아이디를 입력해주세요.");
			fo.id.focus();
			return;
		}
		if(!fo.name.value){
			alert("이름을 입력해주세요.");
			fo.name.focus();
			return;
		}
		if(!fo.pass.value){
			alert("비밀번호를 입력해주세요.");
			fo.pass.focus();
			return;
		}
		if(!fo.age.value){
			alert("나이를 입력해주세요.");
			fo.age.focus();
			return;
		}
		if(isNaN(fo.age.value)){
			alert("나이에 숫자를 입력해주세요.");
			fo.age.focus();
			return;
		}
		if(!fo.email.value){
			alert("이메일을 입력해주세요.");
			fo.email.focus();
			return;
		}
		fo.submit();
	}
</script>


<style>
	.aa {
		width:500px;
		height:50px;
		display:flex;
	}
	.b {
		text-align:center;
		width:100%;
		height:600px;
		margin-top:30px;
	}
	.c {
		width:100px;
	}
	.d {
		font-weight:bold;
		width:150px;
	}
	.e {
		width:50%;
		text-align:left;
	}
	.inp_wr{
		width:250px; 
		height:30px;
	}
	.btn_jo{
		background-color:#5882fa;
		color:white;
		font-size:20px;
		font-weight:bold;
		width:300px; 
		height:40px;
		border:0px;
		cursor: pointer;
	}
	.chk_id{
		width:250px; 
		height:30px;
		border:0px;
	}
	.bt_div{
		text-align:center;
		height:50px;
	}
</style>


<div class="b">
<form name="joiin" action="member_insert.do" method="post">
<h2 align="center">회원가입</h2>
	<div style="height:50px;"></div>
	<div align="center">
		<div class="aa">
			<div class="d">아이디</div>
			<div style="width:40px;"></div>
			<div class="e">
				<input style="width:250px; height:30px;" type="id" name="id" id="id" onblur="location.href='id_check.do?id='+joiin.id.value;" value="${requestScope.id}">
				<c:choose>
					<c:when test="${requestScope.result == '사용이 가능합니다.'}">
						<input class="chk_id" style="color:blue" value="${requestScope.result}">
					</c:when>
					<c:otherwise>
						<input class="chk_id" style="color:red" value="${requestScope.result}">
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div style="height:30px"></div>
		<div class="aa">
			<div class="d">이름</div>
			<div style="width:40px;"></div>
			<div class="e"><input style="width:250px; height:30px;" tabindex="1" name="name" id="name" <c:if test="${a eq 'a'}">autofocus</c:if> ></div>
		</div>
		<div class="aa">
			<div class="d">비밀번호</div>
			<div style="width:40px;"></div>
			<div class="e"><input style="width:250px; height:30px;" tabindex="2" type="password" name="pass" id="pass"></div>
		</div>
		<div class="aa">
			<div class="d">나이</div>
			<div style="width:40px;"></div>
			<div class="e"><input style="width:250px; height:30px;" tabindex="3" name="age" id="age"></div>
		</div>
		<div class="aa">
			<div class="d">이메일</div>
			<div style="width:40px;"></div>
			<div class="e"><input  style="width:250px; height:30px;" tabindex="4" type="email" name="email" id="email"></div>
		</div>
		<div style="height:50px;"></div>
		<div class="bt_div">
			<input class="btn_jo" tabindex="5" type="button" onclick="subjoin()" value="회원가입">
		</div>
	</div>
</div>
	
<%@ include file="/include/footer.jsp" %>