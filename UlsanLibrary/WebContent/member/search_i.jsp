<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp"%>


<style>
	.inp{
		width:400px;
		height:40px;
	}
	.btn_find{
		width:400px;
		height:40px;
		border:0px;
		background-color:#5882fa;
		color:white;
		font-size:16px;
		font-weight:bold;
	}
</style>


<div style="display:flex;min-height:390px">
	<div style="width:30%">	</div>
	<div style="width:39%;min-height:620px;">
		<div style="text-align:center;padding-top:100px;font-size:30px;font-weight:bold">아이디 찾기</div>
		<form action="search_id.do" method="post">
			<div style="text-align:center;padding-top:70px;">
				<div><input class="inp" name="name" placeholder="이름"></div>
				<div style="height:20px;"></div>
				<div><input class="inp" type="email" name="email" placeholder="이메일"></div>
				<div style="height:40px;"></div>
				<div><input class="btn_find" type="submit" value="찾기"></div>
			</div>
		</form>
	</div>
	<div style="width:30%"></div>
</div>


<%@ include file="/include/footer.jsp"%>