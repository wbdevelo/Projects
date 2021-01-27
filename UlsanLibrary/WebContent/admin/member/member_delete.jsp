<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 회원탈퇴</title>
</head>
<body>
<form action="member_delupdate.do" method="post">

	<table width=30% align="center" border=1>
				<h3 align="center">회원탈퇴 관리</h3>
			
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
			<td><input name="pass" value="${modify.pass }" readonly></td>
		</tr>
		<tr>
			<td>나이</td>
			<td><input name="age" value="${modify.age }" readonly></td>
		</tr>
		<tr>
			<td>메일주소</td>
			<td><input name="email" value="${modify.email }" readonly></td>
		</tr>
		<tr>
			<td>레벨</td>
			<td><input name="level" value="${modify.level }" readonly></td>
		</tr>
		<tr>
			<td>상태</td>
			<td><input name="state" value="${modify.state }" readonly></td>
		</tr>
		<tr>
			<td colspan=2><input type="submit" value="회원탈퇴"></td>
		</tr>
		
	</table>
	</form>
</body>
</html>