<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>

<style>
	.abc{
		width:600px;
		height:200px;
		background-color:white;
	}
	.ct{
		height:25px;
		border-right:1px solid #e9eef4;
	}
	.cn{
		height:25px;
		width:100px;
		text-align:left;
	}
	.cs{
		height:25px;
		text-align:right;
	}
	body{
		background-color:#e9eef4;
	}
</style>
<br><br><br><br><br><br>

<table width=100% height=100%>
	<tr>
		<td align=center><span style="border-bottom:1px solid black"><%=session_nickname%>님의 진행 중인 글입니다.</span></td>
	</tr>
</table>
<br><br>
<%
request.setCharacterEncoding("utf-8");

String sql;
if(session_kind.equals("giver_mem")){
	sql = "select * from giver_post where id='" + session_id + "'";
}else{
	sql = "select * from recipient_post where id='" + session_id + "'";
}

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);
%>

<%
if(session_kind.equals("giver_mem")){
	while(rs.next()){
		String title = rs.getString("title");
		String content = rs.getString("content");
		String nickname = rs.getString("nickname");
		String signdate = rs.getString("signdate");
		String file_s = rs.getString("file_s");
		String complete = rs.getString("complete");
		int uid = rs.getInt("uid");
		
		if(!complete.equals("완료")){
%>
<table class="abc" align=center>
	<tr>
		<td height=5px colspan=3></td>
	</tr>
	<tr>
		<td class="ct"><a href="/giver/view.jsp?post=giver_post&uid=<%=uid%>"><%=title%></a></td>
		<td class="cn"><%=nickname%></td>
		<td class="cs"><%=signdate%></td>
	</tr>
	<tr>
		<td height=5px colspan=3></td>
	</tr>
	<tr>
		<td colspan=3>
			<table width=100% height=100%>
				<tr>
					<td width=10px></td>
					<td width=100px><img src="/upload/<%=file_s%>"></td>
					<td><%=content%></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<table>
	<tr>
		<td height=20px></td>
	</tr>
</table>
<%		}
	}
	
}else{
	while(rs.next()){
		String title = rs.getString("title");
		String content = rs.getString("content");
		String nickname = rs.getString("nickname");
		String signdate = rs.getString("signdate");
		int uid = rs.getInt("uid");
		String complete = rs.getString("complete");
		
		if(!complete.equals("완료")){
%>

<table class="abc" align=center>
	<tr>
		<td height=5px colspan=3></td>
	</tr>
	<tr>
		<td class="ct"><a href="/recipient/view.jsp?post=recipient_post&uid=<%=uid%>"><%=title%></a></td>
		<td class="cn"><%=nickname%></td>
		<td class="cs"><%=signdate%></td>
	</tr>
	<tr>
		<td height=5px colspan=3></td>
	</tr>
	<tr>
		<td colspan=3><%=content%></td>
	</tr>
</table>
<table>
	<tr>
		<td height=20px></td>
	</tr>
</table>

<%
		}
	}
}
%>
	
<table height=500px width=100%>
	<tr>
		<td></td>
	</tr>
</table>

<%@ include file="/include/footer.jsp" %>