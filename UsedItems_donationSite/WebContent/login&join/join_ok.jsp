<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String kind = request.getParameter("kind");
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String name = request.getParameter("name");
String email = request.getParameter("email") + "@" + request.getParameter("email_address");
String phone = request.getParameter("phone").replace("-", "");
String zip1 = request.getParameter("zip1");
String nickname = request.getParameter("nickname");
String zipcode = request.getParameter("zipcode");

String sql = "insert into " + kind + " (id, password, email, phone, address, nickname, zipcode) values ('" + id + "', '" + pass + "', '" + email + "', '" + phone + "', '" + zip1 + "', '" + nickname + "', '" + zipcode + "')";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
stmt.executeUpdate(sql);

stmt.close();
conn.close();
%>

<style>
    .al{
		border:1px solid black;
		background-color:white;
		width:100%;
        height:100%;
    }
    .ah{
		border:1px solid black;
		background-color:black;
		color:white;
		width:100%;
        height:100%;
    }
    .img_st{
    	width:300px;
    	height:300px;
    }
    .abc{
    	text-align:center;
    	height:40px
    }
</style>

<br><br><br><br>

<table width=300px align=center>
    <tr>
        <td class="abc" style="font-size:16px">Welcome</td>
    </tr>
    <tr>
    	<td height=100px></td>
    </tr>
    <tr>
    	<td class="abc"><img src="/img/check-mark.png"></td>
    </tr>
    <tr>
    	<td height=40px></td>
    </tr>
    <tr>
    	<td class="abc" style="font-size:18px">회원가입이 <b>완료</b> 되었습니다.</td>
    </tr>
    
    <tr>
    	<td class="abc" style="font-size:14px"><span style="color:#7dbeb8"><b><%=nickname%></b></span>님의 회원가입을 축하합니다.<br>알차고 실속있는 서비스로 찾아뵙겠습니다.</td>
    </tr>
    <tr>
    	<td height=10px></td>
    </tr>
    <tr>
        <td class="abc">
        	<table width=100% height=100%>
        		<tr>
        			<td><a href="login.jsp"><input class="al" type="button" value="로그인"></a></td>
        			<td><a href="/"><input class="ah" type="button" value="홈으로"></a></td>
        		</tr>
        	</table>
        </td>
    </tr>
</table>
<table width=100% height=150px>
	<tr>
		<td></td>
	</tr>
</table>
<%@ include file="/include/footer.jsp" %>