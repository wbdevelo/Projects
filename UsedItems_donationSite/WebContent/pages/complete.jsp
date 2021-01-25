<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8");
int uid = Integer.parseInt(request.getParameter("uid"));
String post = request.getParameter("post");
String sql = "update " + post + " set complete='완료' where uid=" + uid + "";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
stmt.executeUpdate(sql);

String sql_point = "";
if(post.equals("giver_post")){
	sql_point = "update giver_mem set point=point+500 where id='" + session_id + "'"; 
}else{
	sql_point = "update recipient_mem set point=point+500 where id='" + session_id + "'"; 
}

stmt.executeUpdate(sql_point);

stmt.close();
conn.close();
%>

<script>
	alert("축하드립니다. \n거래가 완료되었습니다.");
	location.href="/";
</script>

</body>
</html>