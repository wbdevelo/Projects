<%@page import="com.sun.xml.internal.bind.v2.model.core.ID"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>  
    
<c:choose>
	<c:when test="${session_id != null}">
	</c:when>
	<c:otherwise>
		<script>
			alert('잘못된 접근 방식 입니다.');
			history.back();
		</script>
	</c:otherwise>
</c:choose>

<script>

function pageback(){
	alert("정보수정을 취소하시겠습니까?");
	location.href="/member/mypage.jsp";
}

</script>

<style>
	#canmodi{
		 border: #2b75b9 2px solid;
         background-color: #c1c1c1;
	}
</style>

<form name="selfmodify" action="member_update.do" method="post">
	<table align="center">
	<h1 align="center">내 정보수정</h1>
		<tr>
			<td>이름</td>
			<td><input name="name" value="${modify.name }" readonly></td>
		</tr>
		<tr>
			<td>아이디</td>
			<td><input name="id" value="${modify.id }" readonly></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input id="canmodi" name="pass" value="${modify.pass }"></td>
		</tr>
		<tr>
			<td>나이</td>
			<td><input id="canmodi" name="age" value="${modify.age }"></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td><input id="canmodi" name="email" value="${modify.email }"></td>
		</tr>
		<tr>
			<td><input type="submit" value="수정완료"></td>
			<td><input type="button" value="취소" onclick="pageback()"></td>
		</tr>
	</table>