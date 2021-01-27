<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/include/header.jsp" %>


<style>
	#mybook{
		text-align:center;
	}
</style>

<table width=100% border=1>
	<h3 align="center">MY - EBOOK</h3>
		Total : ${count }
		<tr>
			<td colspan=9 align=center><b>나의 ebook 목록</b></td>
		</tr>
		<tr>
			<td id=mybook>No</td>
			<td id=mybook>표지</td>
			<td id=mybook>제목</td>
			<td id=mybook>다운로드</td>
		</tr>
	<c:set var="number" value="${number }"/>
		<c:forEach var="list" items="${v }">
		<tr>
			<td id=mybook>${number }</td>
			<td id=mybook><img src="/upload/${list.thum_file}"></td>
			<td id=mybook>${list.title }</td>
			<td id=mybook><a href="/upload/${list.book_file }" download>${list.book_file }</a></td><!-- 파일 다운로드 버튼 생성법 찾아보기 -->
		</tr>
		<c:set var="number" value="${number-1 }"/> 
		</c:forEach>
	</table>
	<!-- 페이징 -->
	<table width=50% border=1 align="center">
		<tr>
			<td align="center">
<!-- 페이징 처리 -->		
<c:if test="${count  > 0}">
	<c:set var="pageCount" value="${count / pageSize + (count % pageSize == 0 ? 0 : 1) }" />
	<fmt:parseNumber var="pageCount" value="${pageCount }" integerOnly="true"/>
	
	<!-- 2개의 변수 초기화 -->
	<c:set var="startPage" value="${1 }"/>
	<c:set var="pageBlock" value="${3 }"/>
	
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
<%@ include file="/include/footer.jsp" %>

</body>
</html>