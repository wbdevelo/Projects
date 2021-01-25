<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>


<%
request.setCharacterEncoding("utf-8");

String gu = "";
String sql = "select * from " + session_kind + " where id='" + session_id + "'";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

if(session_kind.equals("giver_mem")){
	gu = "일반인";
}else{
	gu = "기관인";
}

int point = 0;
while(rs.next()){
	point = rs.getInt("point");
}
%>

<style>
	.menu_table{
		width:70%;
		height:300px;
		border:1px solid #999;
	}
	.sangwi_menu{
		font-weight:bold;
		border-bottom:1px dotted #aaa;
		height:50px;
		width:300px;
	}
	.hawi_menu{
		color:#888888;
		font-size:12px;
		height:30px;
	}
	.info{
		height:100px;
		width:40%;
		border:1px solid #999;
		text-align:center;
	}
	.sp_st{
		color:#7dbeb8;
		font-weight:bold;
	}
</style>

<br><br><br><br><br><br>
<table class="info" align=center>
	<tr>
		<td><span class="sp_st"><%=session_nickname%></span>님은 <span class="sp_st"><%=gu%></span> 멤버입니다.</td>
	</tr>
	<%-- <tr>
		<td>Point: <%=point%>점</td>
	</tr> --%>
</table>
<br><br><br>
<table align=center class="menu_table">
	<tr>
		<td>
			<table>
				<tr>
					<td width=80px rowspan=4></td>
					<td class="sangwi_menu">회원정보</td>
				</tr>
				<tr>
					<td height=20px></td>
				</tr>
				<tr>
					<td class="hawi_menu"><a href="/login&join/before_infoChange.jsp">회원수정</a></td>
				</tr>
				<tr>
					<td class="hawi_menu"><a href="/login&join/before_withdrawal.jsp">회원탈퇴</td>
				</tr>
			</table>
		</td>
		<td>
			<table>
				<tr>
					<td width=80px rowspan=4></td>
					<td class="sangwi_menu">내가 올린 글</td>
				</tr>
				<tr>
					<td height=20px></td>
				</tr>
				<tr>
					<td class="hawi_menu"><a href="what_iWrote.jsp">진행 중인 글</a></td>
				</tr>
				<tr>
					<td class="hawi_menu"><a href="complete_geul.jsp">완료된 글</a></td>
				</tr>
			</table>
		</td>
		<td>
			<table>
				<tr>
					<td width=80px rowspan=4></td>
					<td class="sangwi_menu">메시지</td>
				</tr>
				<tr>
					<td height=20px></td>
				</tr>
				<tr>
					<td class="hawi_menu"><a href="/message/reci_mocklock.jsp">받은 메시지</a></td>
				</tr>
				<tr>
					<td class="hawi_menu"><a href="/message/send_mocklock.jsp">보낸 메시지</a></td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width=100% height=100px>
	<tr>
		<td></td>
	</tr>
</table>
<%@ include file="/include/footer.jsp" %>