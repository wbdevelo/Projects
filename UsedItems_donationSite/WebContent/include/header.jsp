<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@ include file="/include/dbconnect.jsp" %>

<%
String session_id = (String)session.getAttribute("id");
String session_pass = (String)session.getAttribute("pass");
String session_level = (String)session.getAttribute("level");
String session_kind = (String)session.getAttribute("kind");
String session_nickname = (String)session.getAttribute("nickname");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/CSS/basic.css">
</head>
<body>

<style>
	.aa{
		color:#526069;
        width:7%;
	}
	.log_td{

		color:#526069;
		text-align:center;
        width:15%;
	}
	.anavada{
		text-align:center;
		font-size:50px;
		font-family:"Nanum Pen";
	}
</style>

<table width=100% height=50px style="background-color:white">
	<tr>
        <td class="aa"><a href="/pages/about.jsp">About</a></td>
        <td class="aa"><a href="/giver/giver_list.jsp?post=giver_post">Giver</a></td>
        <td class="aa"><a href="/recipient/recipient_list.jsp?post=recipient_post">Recipient</a></td>
        <td class="anavada">
        	<a href="/"><span style="color:#7dbeb8">아나바다</span></a>
        </td>
        <td width=100px></td>
        <td class="log_td">
        	<%if(session_id != null){%>
        		<table width=100% height=100%>
        			<tr>
        				<td>
        					<a href="/pages/mypage_info.jsp">
        						<span style="border-bottom:1px solid #7dbeb8;color:#7dbeb8"><b><%=session_nickname%></b></span>
        					</a>님 환영합니다.
        				</td>
        				<td>
        					<a href="/login&join/logout.jsp"><span style="font-size:18px"><b>logout</b></span></a>
        				</td>     		
        			</tr>
        		</table>
        	<%}else{%>
        		<a href="/login&join/login.jsp"><span style="font-size:18px"><b>login</b></span></a>
        	<%}%>
        </td>
    </tr>
</table>