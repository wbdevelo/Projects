<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/admin/include/header.jsp" %>


<fmt:parseNumber var="total_price" value="0" integerOnly="true"/>
<c:forEach var="ov" items="${ov}">
<form action="cancel_permit.do" method="post">
<input type="hidden" name="product_num" value="${ov.product_num}">
<input type="hidden" name="id" value="${ov.id}">
	<c:choose>
		<c:when test="${ov.id == null || ov.id == ''}">
			<a href="detail.do?guest=${ov.guest}&product_num=${ov.product_num}&state=${ov.state}"> ${ov.guest}, ${ov.product_num}, \ ${ov.price}, ${ov.ipkumja}, ${ov.state} </a>
		</c:when>
		<c:otherwise>
			<a href="detail.do?id=${ov.id}&product_num=${ov.product_num}&state=${ov.state}"> ${ov.id}, ${ov.product_num}, \ ${ov.price}, ${ov.ipkumja}, ${ov.state} </a>
		</c:otherwise>
	</c:choose>
	<fmt:parseNumber var="total_price" value="${total_price + ov.price}" integerOnly="true"/>
	<c:if test="${ov.state == 'cdaeki'}">
		<input type="submit" value="취소승인">
	</c:if>
	<br>
</form>
</c:forEach>

<fmt:formatNumber var="total_price" value="${total_price}"/>
Total: \ ${total_price}

<%@include file="/admin/include/footer.jsp" %>