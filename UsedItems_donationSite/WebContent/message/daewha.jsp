<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/include/header.jsp"%>

<%
request.setCharacterEncoding("utf-8");

String sang_name = request.getParameter("sang_nick");
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
	input{
		width:100%;
		height:100%;
		border-radius: 20px 20px 20px 20px;
	}
	.for_img{
		width:30px;
	}
</style>

</head>
<body>

<br><br><br>
<table class="big_teduri" align=center>
<form name="dae1" action="msgDB.jsp" method="post">
<input type="hidden" id="sang_name" name="sang_name" value="<%=sang_name%>">
	<tr>
		<td class="jemock"><span style="font-weight:bold;color:#7dbeb8"><%=sang_name%></span>님과의 채팅방</td>
	</tr>
	<tr>
		<td height=700px>
			<table>
				<tr>
					<td></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td style="border-top:1px solid #757575">
			<table height=100% width=100%>
				<tr>
					<td width=90px></td>
					<td><input type="text" id="my_msg" name="my_msg"></td>
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
		fo = dae1;
		
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