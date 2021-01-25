<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/include/header.jsp"%>

<%
request.setCharacterEncoding("utf-8");

String post = request.getParameter("post");
String uid = request.getParameter("uid");
String sql = "delete from " + post + " where uid='" + uid + "'";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
stmt.executeUpdate(sql);

stmt.close();
conn.close();
%>

<script>
	location.href="recipient_list.jsp?post=<%=post%>";
</script>