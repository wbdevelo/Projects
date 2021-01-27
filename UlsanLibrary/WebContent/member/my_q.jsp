<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp"%>

<c:forEach var="v" items="${v}">
	<div>
		<c:choose>
			<c:when test="${v.thread.length() > 1}">
				<c:forEach var="i" begin="1" end="${v.thread.length()}">
					&nbsp;&nbsp;
				</c:forEach>
						-><a href="/qna/view_q.do?uid=${v.uid}&now=mypage">제목: ${v.title}</a><br>
			</c:when>
			<c:otherwise>
					<a href="/qna/view_q.do?uid=${v.uid}&now=mypage">제목: ${v.title}</a>
			</c:otherwise>
		</c:choose>
	</div>
</c:forEach>

<%@ include file="/include/footer.jsp"%>