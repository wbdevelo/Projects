<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp"%>


<script>
	function subjo(){
		fo = document.johwoi;
		
		if(!fo.guest_num.value){
			alert("게스트번호를 입력해주세요.");
			fo.guest_num.focus();
			return;
		}
		if(!fo.pass.value){
			alert("비밀번호를 입력해주세요.");
			fo.pass.focus();
			return;
		}
		
		fo.submit();
	}
</script>

<style>
	.tl{
		width:100%;
		height:50px;
		text-align:center;
	}
	.guti{
		width:100%;
		text-align:center;
		margin-top:80px;
	}
	.btn_b{
		background-color:#5882fa;
		color:white;
		font-size:20px;
		font-weight:bold;
		width:500px;
		border:0px;
		height:40px;
	}
	.inp_st{
		width:500px;
		height:50px;
	}
</style>

<div style="height:500px;">
	
	<h2 class="guti">비회원 구매조회</h2>
	
	<div style="height:50px;"></div>
	
	<form name="johwoi" action="bmember_list.do" method="post">
	<div>
		<div class="tl"><input class="inp_st" name="guest_num" id="guest_num" placeholder="게스트번호"></div>
		<div style="height:20px;"></div>
		<div class="tl"><input class="inp_st" name="pass" id="pass" placeholder="비밀번호"></div>
		<div style="height:50px;"></div>
		<div class="tl"><input class="btn_b" type="button" onclick="subjo()" value="조회"></div>
	</div>
	</form>
</div>

<%@ include file="/include/footer.jsp"%>