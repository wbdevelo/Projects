<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String kind = request.getParameter("kind");
String id = request.getParameter("id");
String pass = request.getParameter("password");

String sql = "select * from " + kind + " where id='" + id + "'";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

String mem_id = "";
String mem_pass = "";
String mem_level = "";
String mem_nick = "";
if(rs.next()){
	mem_id = rs.getString("id");
	mem_pass = rs.getString("password");
	mem_level = rs.getString("level");
	mem_nick = rs.getString("nickname");
}

if(id.equals(mem_id) && pass.equals(mem_pass)){
	session.setAttribute("id", mem_id);
	session.setAttribute("kind", kind);
	session.setAttribute("pass", mem_pass);
	session.setAttribute("level", mem_level);
	session.setAttribute("nickname", mem_nick);
}else{%>
<script>
	alert("아이디와 비밀번호를 확인하세요.");
	history.back();
</script>
<%}%>

<%
stmt.close();
conn.close();
%>
<script>
	location.href = '/'; //인덱스 페이지로 넘어간다.
</script>

<%@ include file="/include/footer.jsp" %>