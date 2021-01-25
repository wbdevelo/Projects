<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("id");
String email = request.getParameter("email");
String phone = request.getParameter("phone").replace("-", "");
String address = request.getParameter("zip1");
String zipcode = request.getParameter("zipcode");

String sql = "update " + session_kind + " set email='" + email + "', phone='" + phone + "', address='" + address + "', zipcode='" + zipcode + "' where id='" + id + "'";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
stmt.executeUpdate(sql);
%>

<script>
	alert("수정이 완료되었습니다.");
	location.href="info_change.jsp";
</script>