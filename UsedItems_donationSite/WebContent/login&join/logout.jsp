<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	session.invalidate(); //세션에 있는 모든 정보를 지움.
%>

<script>
	location.href = "/";
</script>