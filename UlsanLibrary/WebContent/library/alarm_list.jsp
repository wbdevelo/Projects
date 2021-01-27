<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>
	

<style>
	.btn_del{
		width:80px;
		height:30px;
		border:2px solid #7d9dfa;
		color:#7d9dfa;
		background-color:white;
		font-size:15px;
		border-radius: 5px 5px 5px 5px;
	}
</style>

<div style="display:flex">
	<div style="width:30%"></div>
	<div style="width:39%;min-height:460px;">
	<form action="deleteAlarm.do" method="post">
	<input type="hidden" name="lib_name" value="${session_name}">
		<div align="left" style="padding-right:150px;height:40px;">
			<input class="btn_del" type="submit" value="전체삭제">
		</div>
		<c:forEach var="av" items="${av}">
			<div style="display:flex;">
				<li style="height:30px;width:550px;padding-left:50px;">
					도서 예약신청이 들어왔습니다.&nbsp;&nbsp;예약대기자 명단에서 확인해주세요.</li>
				<div>${av.date}</div>
			</div>
		</c:forEach>
	</form>
	</div>
	<div style="width:30%"></div>
</div>


<%@ include file="/include/footer.jsp" %>