<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/include/header.jsp"%>

<%
request.setCharacterEncoding("utf-8");

String sang_name = request.getParameter("sang_name");
String my_msg = request.getParameter("my_msg");

String sql;
if(session_kind.equals("giver_mem")){
	sql= "insert into daewha (my_name, my_msg, my_gu, sang_name, sang_gu) values ('" + session_nickname + "', '" + my_msg + "', '" + session_kind + "', '" + sang_name + "', 'recipient_mem')";
}else{
	sql= "insert into daewha (my_name, my_msg, my_gu, sang_name, sang_gu) values ('" + session_nickname + "', '" + my_msg + "', '" + session_kind + "', '" + sang_name + "', 'giver_mem')";
}

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
stmt.executeUpdate(sql);
%>

<script>
<%if(session_kind.equals("giver_mem")){%>
	location.href="up_dae.jsp?sang_name=<%=sang_name%>&sang_gu=recipient_mem&my_name=<%=session_nickname%>&my_gu=<%=session_kind%>";
<%}else{%>
	location.href="up_dae.jsp?sang_name=<%=sang_name%>&sang_gu=giver_mem&my_name=<%=session_nickname%>&my_gu=<%=session_kind%>";
<%}%>
</script>
</body>