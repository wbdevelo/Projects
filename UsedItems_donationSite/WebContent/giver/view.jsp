<%@page import="com.mysql.cj.protocol.Resultset"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/include/header.jsp"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%
request.setCharacterEncoding("utf-8");

String post = request.getParameter("post");
int uid = Integer.parseInt(request.getParameter("uid"));
String ref_up = "update " + post + " set ref=ref+1 where uid=" + uid + "";


Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
stmt.executeUpdate(ref_up);


String sql = "select * from " + post + " where uid='" + uid + "'";
ResultSet rs = stmt.executeQuery(sql);
String title = "";
String content = "";
String file_rename = "";
String nickname = "";
String signdate = "";
String file_s = "";
String id = "";
while(rs.next()){
	title = rs.getString("title");
	content = rs.getString("content");
	file_rename = rs.getString("file_rename");
	nickname = rs.getString("nickname");
	signdate = rs.getString("signdate");
	file_s = rs.getString("file_s");
	id = rs.getString("id");
}

rs.close();
stmt.close();
conn.close();

pageContext.setAttribute("cnt", content);
pageContext.setAttribute("LF", "\n");
%>

<style>
	input{
		width:100%;
		height:100%;
		border:0px solid white;
	}
	.bu_st{
		width:50px;
        height:30px;
        background-color: white;
        border: 1px solid #e5e5e5;
        color:#8a837e;
        font-size:15px;
        cursor:pointer;
	}
	.lay_st{
		border:1px solid #e5e5e5;
		width:100%;
		height:100%;
	}
	.title_st{
		font-weight:bold;
		font-size:30px;
		color:#7dbeb8;
		height:60px;
	}
	.naljja{
		font-size:13px;
		color:#8a837e;
	}
	.gesy_tb{
		width:785px;
		height:400px;
	}
	.gesy_geul{
		font-size:12px;
		color:#8a837e;
		font-weight:bold;
		height:30px
	}
	.gesy_other{
		font-size:12px;
		color:#cfccca;
		height:30px
	}
	.gesy_wi{
		font-weight:bold;
		color:#8a837e;
		height:50px
	}
	.page_go{
		font-size:13px;
		color:#8a837e;
	}
	.page_no{
		font-size:11px;
		color:#cfccca;
	}
	.matching{
		width:68px;
        height:30px;
        background-color: white;
        border: 1px solid #e5e5e5;
        color:#8a837e;
        font-size:15px;
        cursor:pointer;
	}
</style>
<br><br>
<table class="gesy_tb" align=center>
<form name="make_daewha" action="/message/daewha.jsp" method=post>
<input type="hidden" id="sang_nick" name="sang_nick" value="<%=nickname%>">
<input type="hidden" id="post" name="post" value="<%=post%>">
<input type="hidden" id="uid" name="uid" value="<%=uid%>">
	<tr>
		<td>
			<table class="lay_st">
				<tr>
					<td colspan=2 height=20px></td>
				</tr>
				<tr>
					<td colspan=2 class="title_st"><%=title%></td>
				</tr>
				<tr height=30px>
					<td style="width:500px;font-color:#8a837e;font-size:14px">
						<%if(session_kind != null && session_kind.equals("recipient_mem")){ %>
							<a onclick="dae()"><span style="border-bottom:1px solid black;cursor:pointer"><%=nickname%></span></a>
						<%}else{%>
							<%=nickname%>
						<%}%>
					</td>
					<td class="naljja" align=right><%=signdate%></td>
				</tr>
				<tr>
					<td colspan=2 height=20px style="border-bottom:1px solid #e5e5e5"></td>
				</tr>
				<tr>
					<td colspan=2 height=500px>
							<%if(file_rename != ""){ %>
								<a href="/upload/<%=file_rename %>"><img src="/upload/<%=file_s %>"></a>
							<%}else{ %>
								파일없음
							<%} %>
						<br>
						${fn:replace(cnt,LF,"<br>")}
					</td>
				</tr>
				<tr>
					<td align=right valign=top colspan=2>
						<table>
							<tr>
								<td align=right>
								<%if(session_kind == null){%>
									<a class="bu_st" onclick="location.href='giver_list.jsp?post=<%=post%>'">목록</a>
								<%}else if((session_kind.equals("giver_mem")&&session_id.equals(id)) || session_level.equals("10")){%>
									<a class="matching" onclick="location.href='/pages/complete.jsp?post=<%=post%>&uid=<%=uid%>'">매칭완료</a>
									<a class="bu_st" onclick="location.href='modify_guel.jsp?post=<%=post%>&uid=<%=uid%>'">수정</a>
									<a class="bu_st" onclick="location.href='delete_guel.jsp?post=<%=post%>&uid=<%=uid%>'">삭제</a>
									<a class="bu_st" onclick="location.href='giver_list.jsp?post=<%=post%>'">목록</a>
								<%}else{%>
									<a class="bu_st" onclick="location.href='giver_list.jsp?post=<%=post%>'">목록</a>
								<%}%>
							</td>
							<td width=20px rowspan=2></td>
						</tr>
						<tr>
							<td height=20px></td>
						</tr>
					</table>
				</tr>
			</table>
		</td>
	</tr>
</form>
</table>
<br>

<script>
	function dae(){
		document.make_daewha.submit();
	}
</script>
</body>
</html>