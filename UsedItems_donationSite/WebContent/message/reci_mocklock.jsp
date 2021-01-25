<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String sql="select * from daewha where (my_name='" + session_nickname + "' and my_gu='" + session_kind + "') or(sang_name='" + session_nickname + "' and sang_gu='" + session_kind + "') group by my_name";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);
%>

<br><br><br><br>
<table width=100% height=600px>
	<tr>
		<td height=20px></td>
	</tr>
	<tr>
		<td align=center>
			<table >
				<%
				while(rs.next()){
					String my_name = rs.getString("my_name");
					String my_gu = rs.getString("my_gu");
					String sang_name = rs.getString("sang_name");
					String sang_gu = rs.getString("sang_gu");
					
					if(sang_name.equals(session_nickname)&&sang_gu.equals(session_kind)){
				%>
					<tr>
						<td style="border-bottom:1px solid black">
							<a href="up_dae.jsp?sang_name=<%=my_name%>&sang_gu=<%=my_gu%>&my_name=<%=session_nickname%>&my_gu=<%=session_kind%>">
								<span style="color:#7dbeb8;font-weight:bold;"><%=my_name%></span>님과의 대화
							</a>
						</td>
					</tr>
					<tr>
						<td height=20px></td>
					</tr>
				<%
					}
				}%>	
			</table>
		</td>
	</tr>
	<tr>
		<td height=20px></td>
	</tr>
</table>


<%@ include file="/include/footer.jsp" %>