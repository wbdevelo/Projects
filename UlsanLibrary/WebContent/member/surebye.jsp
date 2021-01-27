<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>  
    
<c:choose>
	<c:when test="${session_id != null }">
		
	</c:when>
	<c:otherwise>
		<script>alert("잘못된 접근방식 입니다."); history.back()</script>
	</c:otherwise>
</c:choose>

<script>

/* function byebye(){
	  var check = confirm("정말 탈퇴 하시겠습니까?");
	  if(check) alert("탈퇴처리 되었습니다.");location.href="bye.do?id=${session_id}";
	  else alert("탈퇴를 취소하였습니다.");location.href="/member/mypage.jsp";
	} */
	
function byebye(){
	if(confirm("정말 탈퇴하시겠습니까?")){
		window.location.href="bye.do?id=${session_id}";
	}else{
		window.location.href="/member/mypage.jsp";
	}
}	


function pageback(){
	alert("탈퇴 신청을 취소하시겠습니까?");
	location.href="/member/mypage.jsp";
}

</script>
</head>
<body>
<form>
	<table align="center">
	<h1 align="center">회원탈퇴</h1>
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
			<td>이메일</td>
			<td><input name="email" value="${modify.email }" readonly></td>
		</tr>
		<tr>
			<td>레벨</td>
			<td><input name="level" value="${modify.level }" readonly></td>
		</tr>
		<tr>
			<td><input type="button" value="탈퇴" onclick="byebye()"></td>
			<td><input type="button" value="취소" onclick="pageback()"></td>
		</tr>
	</table>
</form>	
</body>
</html>