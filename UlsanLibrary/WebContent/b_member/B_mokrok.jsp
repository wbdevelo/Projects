<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp"%>

<script>
	function file_down(){
		fo = document.b_click;
		fo.submit();
	}
</script>


<c:forEach var="v" items="${v}">
<form name="b_click" action="Bmem_down.do" method="post">
<input type="hidden" name="guest" value="${v.guest}">
<input name="product_num" value="${v.product_num}">
	${v.guest}, ${v.bank}, ${v.ipkumja}, ${v.price}, ${v.purchase}
	<c:choose>
		<c:when test="${todate <= v.date + 7}">
			<a href="/upload/${v.file}" onclick="file_down()" download>ebook 파일</a>
		</c:when>
		<c:otherwise>
			다운로드 유효기간이 지났습니다.
		</c:otherwise>
	</c:choose>
	<c:if test="${v.click == 0 || v.click == null}">
		구매취소
	</c:if>
	<br>
</form> 
</c:forEach>

<%@ include file="/include/footer.jsp"%>