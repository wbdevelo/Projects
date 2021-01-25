<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8");

java.util.Date today = new java.util.Date();
SimpleDateFormat cal = new SimpleDateFormat("yyyy.MM.dd HH:mm");
String signdate = cal.format(today);

String post = request.getParameter("post");
String title = request.getParameter("title");
String content = request.getParameter("content");

//특수기호 에러 안나도록
content = content.replaceAll("\"","&quot;");
content = content.replaceAll("\'","&lsquo;");
content = content.replaceAll("<","&lsaquo;");
title = title.replaceAll("\"","&quot;");
title = title.replaceAll("\'","&lsquo;");
title = title.replaceAll("<","&lsaquo;");

String sql = "insert into " + post + " (id, title, content, signdate, nickname) values ('" + session_id + "', '" + title + "', '" + content + "', '" + signdate + "', '" + session_nickname + "')";
 

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
stmt.executeUpdate(sql);


String sql2 = "select * from " + post + " where title='" + title + "'";
ResultSet rs = stmt.executeQuery(sql2);
String uid = "";
while(rs.next()){
	uid = rs.getString("uid");
}
rs.close();
conn.close();
stmt.close();
%>

<script>
	location.href = "recipient_list.jsp?post=<%=post%>&uid=<%=uid%>";
</script>