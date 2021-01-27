<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/admin/include/header.jsp" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



<form action="member_update.do" method="post">

	<table width=30% align="center" border=1>
				<h3 align="center">회원정보 및 수정</h3>
			
		<tr>
			<td>이름</td>
			<td><input name="name" value="${modify.name }"></td>
		</tr>		
		<tr>
			<td>아이디</td>
			<td><input name="id" value="${modify.id }"></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input name="pass" value="${modify.pass }"></td>
		</tr>
		<tr>
			<td>나이</td>
			<td><input name="age" value="${modify.age }"></td>
		</tr>
		<tr>
			<td>메일주소</td>
			<td><input name="email" value="${modify.email }"></td>
		</tr>
		<tr>
			<td>레벨</td>
			<td><input name="level" value="${modify.level }"></td>
		</tr>
		<tr>
			<td>상태</td>
			<td><input name="state" value="${modify.state }"></td>
		</tr>
		<tr>
			<td colspan=2><input type="submit" value="수정완료"></td>
		</tr>
		
	</table>
	</form>
	
<%@include file="/include/footer.jsp" %>