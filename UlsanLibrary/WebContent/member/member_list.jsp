<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file ="/admin/include/header.jsp"%>


<table width=100% border=1>
	<h3 align="center">회원관리 페이지</h3>
		<a href="member_join.jsp">회원가입</a>
		total : ${count }
		<tr>
			<td colspan=9 align=center><b>회원목록</b></td>
		</tr>
		<tr>
			<td>No</td>
			<td>이름</td>
			<td>아이디</td>
			<td>비밀번호</td>
			<td>나이</td>
			<td>메일</td>
			<td>레벨</td>
			<td>가입/탈퇴여부</td>
			<td>수정/삭제</td>
		</tr>
	<c:set var="number" value="${number }"/>
		<c:forEach var="list" items="${v }">
		<tr>
			<td>${number }</td>
			<td>${list.name }</td>
			<td>${list.id }</td>
			<td>${list.pass }</td>
			<td>${list.age }</td>
			<td>${list.email }</td>
			<td>${list.level }</td>
			<td>${list.state }</td>
			<td>
				<a href="member_modify.do?id=${list.id }">[수정]</a>
			</td>
		</tr>
		<c:set var="number" value="${number-1 }"/> 
		</c:forEach>
	</table>
	<table width=50% border=1 align="center">
		<tr>
			<td align="center">
			<!-- 페이징 처리 -->		
			<c:if test="${count  > 0}">
				<c:set var="pageCount" value="${count / pageSize + (count % pageSize == 0 ? 0 : 1) }" />
				<fmt:parseNumber var="pageCount" value="${pageCount }" integerOnly="true"/>
				
				<!-- 2개의 변수 초기화 -->
				<c:set var="startPage" value="${1 }"/>
				<c:set var="pageBlock" value="${5 }"/>
				
				<!-- 다음 페이지 블럭이 존재 할 경우 startPage 값 변경 부분 -->
				<c:if test="${pageNum > pageBlock }">
					<!-- 결과 값을 정수형으로 리턴 받아야 하기 때문에 fmt 처리 -->
					<fmt:parseNumber var="result" value="${pageNum / pageBlock - (pageNum % pageBlock == 0 ? 1 : 0) }" integerOnly="true"/>
					<c:set var="startPage" value="${result * pageBlock + 1 }"/>
				</c:if>
				
				<!-- endPage 설정 -->
				<c:set var="endPage" value="${startPage + pageBlock - 1 }"/>
				<c:if test="${endPage > pageCount }">
					<c:set var="endPage" value="${pageCount }"/>
				</c:if>
				
				<!-- 이전 링크 -->
				<c:if test="${startPage > pageBlock }">
					<a href="member_list.do?pageNum=${startPage - pageBlock }">[이전]</a>
				</c:if>
				
				<!-- 페이지 출력 -->
				<c:forEach var="i" begin="${startPage }" end="${endPage }">
					<a href="member_list.do?pageNum=${i }">[${i }]</a>
				</c:forEach>
				
				<!-- 다음 링크 -->
				<c:if test="${endPage < pageCount}">
					<a href="member_list.do?pageNum=${startPage + pageBlock }">[다음]</a>
				</c:if>
			</c:if>
		</td>
	</tr>
</table>
<table align="center">
	<form action="member_list.do" method="post">
		<tr>
			<td align="center" width=20%>
				<input name="search" size="40" >
				<input type="image" src="/img/search.png">
			</td>
		</tr>
	</form>
</table>
<%@ include file="/admin/include/footer.jsp" %>

</body>
</html>