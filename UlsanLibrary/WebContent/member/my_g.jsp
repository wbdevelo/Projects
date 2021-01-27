<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp"%>

<c:forEach var="v" items="${v}">
	<div>
		<a href="/gallery/view_g.do?uid=${v.uid}&now=mypage&lib_name=${v.lib_name }&loc=lib"><img src="/upload/${v.thum_file }"><br>제목: ${v.title}</a>
	</div>
</c:forEach>

<%@ include file="/include/footer.jsp"%>