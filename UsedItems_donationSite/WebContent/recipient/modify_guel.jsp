<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>

<script>
	 function save(){
		 
		var fo = modify_list;
		fo.submit();
		
	 }
</script>
<%
request.setCharacterEncoding("utf-8");

String post = request.getParameter("post");
String uid = request.getParameter("uid");

String sql = "select * from " + post + " where uid='" + uid + "'";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

String id = "";
String title = "";
String content = "";
while(rs.next()){
	id = rs.getString("id");
	title = rs.getString("title");
	content = rs.getString("content");
}
rs.close();
stmt.close();
conn.close();
%>

<style>
	input{
		width:100%;
		height:100%;
		border:0px solid white;
	}
	
	.bu_st{
		width:240px;
        height:50px;
        background-color: black;
        border: 0px;
        color:white;
	}
</style>

<br><br>
<div style="text-align:center;"><span style="border-bottom:1px solid black">글쓰기</span></div>
<br><br>

<table width=100% height=400px border=1>
<form name="modify_list" action="mo_guel_update.jsp" method="post">
<input type="hidden" name="post" value="<%=post%>">
<input type="hidden" name="uid" value="<%=uid%>">
	<tr>
		<td width=30%></td>
		<td style="border:1px solid black">
			<table width=100% height=100%>
				<tr>
					<td height=10%>
						<input id="title" name="title" type="text" style="border-bottom:1px solid gray" 
								placeholder="제목" value="<%=title%>">
					</td>
				</tr>
				<tr>
					<td>
						<input id="content" name="content" type="text" placeholder="내용" value="<%=content%>">
					</td>
				</tr>
			</table>
		</td>
		<td width=30%></td>
	</tr>
</form>
</table>
<br><br>
<table width=100% border=1>
	<tr>
		<td align=center>
			<button class="bu_st" onclick="save()">저장</button>
			<button class="bu_st" onclick="location.href='/'">취소</button>
		</td>
	</tr>
</table>

</body>
</html>