<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@ include file="/include/dbconnect.jsp" %>

<%
request.setCharacterEncoding("utf-8");
String id = request.getParameter("id_value");
String kind = request.getParameter("kind_value");

String sql = "select count(*) from " + kind + " where id = '"+id+"'";
Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

int count = 0;
if(rs.next()){
	count = rs.getInt("count(*)");
}

if(count == 0){%>
	<script>
		opener.document.getElementById("check_same").value = "사용 가능";
		opener.document.getElementById("check_same").style = "color:blue; border:0px; font-size:15px";
	</script>
<%}else{%>
	<script>
		opener.document.getElementById("check_same").value = "사용 불가";
		opener.document.getElementById("check_same").style = "border:0px; color:red; font-size:15px;";
	</script>
<%}

rs.close();
stmt.close();
conn.close();
%>