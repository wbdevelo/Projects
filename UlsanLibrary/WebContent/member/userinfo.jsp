<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>  

	<table align="center">
		<h1 align="center">내 정보</h1>
			<tr>
				<td>이름</td>
				<td><input name="name" value="${modify.name }" readonly></td>
			</tr>
			<tr>
				<td>아이디</td>
				<td><input name="id" value="${modify.id}" readonly></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input name="pass" value="${modify.pass }" readonly></td>
			</tr>
			<tr>
				<td>나이</td>
				<td><input name="age" value="${modify.age }" readonly></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><input name="email" value="${modify.email }" readonly></td>
			</tr>
			<tr>
				<td colspan=2 align="center"><a href="modify.do?id=${modify.id }">수정하기</a></td>
				<td></td>
			</tr>
	</table>
