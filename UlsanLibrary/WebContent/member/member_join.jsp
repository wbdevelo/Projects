<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>

<form name="joiin" action="member_join.do" method="post">
<h3 align="center">회원가입</h3>
	<table align="center" width=30% border=1>
		<tr>
			<td>아이디</td>
			<td>
				<input type="id" name="id" onblur="location.href='/admin/member/id_check.do?id='+joiin.id.value;" value="${requestScope.id}">
				<c:choose>
					<c:when test="${requestScope.result == '사용이 가능합니다.'}">
						<input tabindex="-1" style="color:blue" value="${requestScope.result}" readonly>
					</c:when>
					<c:otherwise>
						<input tabindex="-1" style="color:red" value="${requestScope.result}" readonly>
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<td>이름</td>
			<td><input tabindex="1" name="name"></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input tabindex="2" type="password" name="pass"></td>
		</tr>
		<tr>
			<td>나이</td>
			<td><input tabindex="3" name="age"></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td><input tabindex="4" type="email" name="email"></td>
		</tr>
		<tr>
			<td>레벨</td>
			<td><input tabindex="5" name="level" value="5"></td>
		</tr>
		<tr>
			<td><input tabindex="7" type="submit" value="회원가입"></td>
		</tr>
	</table>
	
<%@ include file="/include/footer.jsp" %>