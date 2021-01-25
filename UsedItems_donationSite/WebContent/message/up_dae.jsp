<%@page import="com.mysql.cj.protocol.Resultset"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/include/header.jsp"%>

<%
request.setCharacterEncoding("utf-8");

String sang_name = request.getParameter("sang_name");
String sang_gu = request.getParameter("sang_gu");
String my_name = request.getParameter("my_name");
String my_gu = request.getParameter("my_gu");

String sql = "select * from daewha where (sang_name='" + sang_name + "' and sang_gu='" + sang_gu + "' and my_name='" + session_nickname + "' and my_gu='" + my_gu + "') or (my_name='" + sang_name + "' and my_gu='" + sang_gu + "' and sang_name='" + session_nickname + "' and sang_gu='" + my_gu + "')";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);
%>

<style>
	.big_teduri{
		width:30%;
		height:600px;
		border:1px solid #757575;
		border-radius: 10px 10px 10px 10px;
	}
	.jemock{
		border-bottom:1px solid #757575;
		height:50px;
		text-align:center;
	}
	.msg_s{
		width:100%;
		height:100%;
		border-radius: 20px 20px 20px 20px;
	}
	.for_img{
		width:30px;
	}
	.sang {
		 position:relative;
		 margin: 50px;
		 height:30px;
		 background:#f7a992;
		 border-radius: 10px;
		 color:white;
	}
	.sang:after {
		 border-top:12px solid #f7a992;
		 border-left: 12px solid transparent;
		 border-right: 0px solid transparent;
		 border-bottom: 0px solid transparent;
		 content:"";
		 position:absolute;
		 top:10px;
		 left:-12px;
	}
	.my {
		 position:relative;
		 margin: 50px;
		 height:30px;
		 background:#8dc6bf;
		 border-radius: 10px;
		 color:white;
	}
	.my:after {
		 border-top:12px solid #8dc6bf;
		 border-left: 0px solid transparent;
		 border-right: 12px solid transparent;
		 border-bottom: 0px solid transparent;
		 content:"";
		 position:absolute;
		 top:10px;
		 right:-12px;
	}
</style>

</head>
<body>

<br><br><br><br>
<table class="big_teduri" align=center>
<form name="dae2" action="msgDB.jsp" method="post">
<input type="hidden" id="sang_post" name="sang_post" value="<%=sang_gu%>">
<input type="hidden" id="sang_name" name="sang_name" value="<%=sang_name%>">
	<tr>
		<td class="jemock"><%=sang_name%>님과의 채팅방</td>
	</tr>
	<tr>
		<td height=700px>
			<table width=100%>
		<%
		while(rs.next()){
			String my_msg = rs.getString("my_msg");
			String my_name1 = rs.getString("my_name");
			String sang_name1 = rs.getString("sang_name");
			if(my_name1.equals(my_name)){
			%>
			<tr>
				<td width=100% align=right>
					<table>
						<tr>
							<td class="my"><%=my_msg%></td>
							<td width=10px></td>
						</tr>
					</table>
				</td>
			</tr>
			<%}else if(sang_name1.equals(my_name)){%>
			<tr>
				<td width=100% align=left>
					<table>
						<tr>
							<td width=10px></td>
							<td class="sang"><%=my_msg%></td>
						</tr>
					</table>
				</td>
			</tr>
			<%}else{}
			}%>
			</table>
		</td>
	</tr>
	<tr>
		<td style="border-top:1px solid #757575">
			<table height=100% width=100%>
				<tr>
					<td width=90px></td>
					<td><input class="msg_s" type="text" id="my_msg" name="my_msg"></td>
					<td width=50px></td>
					<td class="for_img"><img src="/img/send.png" onclick="send_message()"></td>
				</tr>
			</table>
		</td>
	</tr>
</form>
</table>

<script>
	function send_message(){
		fo = dae2;
		
		if(!fo.my_msg){
			alert("메시지를 입력하세요");
			fo.my_msg.focus();
			return;
		}
		fo.submit();
	}
</script>
</body>
</html>
</html>