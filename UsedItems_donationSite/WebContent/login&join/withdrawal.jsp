<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String sql = "update " + session_kind + " set join_value='0' where id='" + session_id + "'";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
stmt.executeUpdate(sql);

%>

<table>
	<tr>
		<td>감사합니다.<br>탈퇴가 완료되었습니다.</td>
	</tr>
</table>

<%@ include file="/include/footer.jsp" %>