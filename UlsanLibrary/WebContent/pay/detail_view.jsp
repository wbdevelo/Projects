<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/admin/include/header.jsp" %>

<c:forEach var="cv" items="${cv}">
	<c:choose>
		<c:when test="${cv.id == null || cv.id == ''}">
			${cv.guest}, ${cv.title}, ${cv.product_num}, ${cv.date}, ${cv.bank}, ${cv.ipkumja}, \ ${cv.price}<br>
		</c:when>
		<c:otherwise>
			${cv.id}, ${cv.title}, ${cv.product_num}, ${cv.date}, ${cv.bank}, ${cv.ipkumja}, \ ${cv.price}<br>
		</c:otherwise>
	</c:choose>
</c:forEach>

<div><a href="mu.do">[목록]</a></div>


<%@include file="/admin/include/footer.jsp" %>