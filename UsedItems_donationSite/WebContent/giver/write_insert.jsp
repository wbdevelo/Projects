<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.awt.Image"%>
<%@page import="com.sun.jimi.core.Jimi"%>
<%@page import="com.sun.jimi.core.JimiException"%>
<%@page import="com.sun.jimi.core.JimiUtils"%>    

<%@ include file="/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8");

java.util.Date today = new java.util.Date();
SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd HH:mm");
String signdate = cal.format(today);

String file = "";
String file_o = "";
String file_rename = "";
String file1_small = "";

String uploadPath = "C:\\JSP\\FirstProject\\WebContent\\upload";
int size = 10*1024*1024; //10M(메가 바이트)

MultipartRequest mult = new MultipartRequest(
		request, 
		uploadPath, 
		size, 
		"utf-8", 
		new DefaultFileRenamePolicy()
		);

String post = mult.getParameter("post");
String title = mult.getParameter("title");
String content = mult.getParameter("content");

content = content.replaceAll("\"","&quot;");
content = content.replaceAll("\'","&lsquo;");
content = content.replaceAll("<","&lt;");
content = content.replaceAll(">","&gt;");
title = title.replaceAll("\"","&quot;");
title = title.replaceAll("\'","&lsquo;");
title = title.replaceAll("<","&lt;");
title = title.replaceAll(">","&gt;");

Enumeration files = mult.getFileNames();

file = (String)files.nextElement();
file_o = mult.getOriginalFileName(file);
file_rename = mult.getFilesystemName(file);

//썸네일 처리
String orgImg = uploadPath+"\\"+file_rename;//원본파일
String thum_img = "thum_"+file_rename;//썸네일파일
String thumbImg = uploadPath+"\\"+thum_img;

int thumbWidth = 160 ;//썸네일 가로
int thumbHeight = 160 ;//썸네일 세로

Image thumbnail = JimiUtils.getThumbnail(orgImg, thumbWidth, thumbHeight, Jimi.IN_MEMORY);// 썸네일 설정
Jimi.putImage(thumbnail, thumbImg);

String sql = "insert into " + post + " (nickname, id, title, content, signdate, file_rename, file_o, file_s) values ('" + session_nickname + "', '" + session_id + "', '" + title + "', '" + content + "', '" + signdate + "', '" + file_rename + "', '" + file_o + "', '" + thum_img + "')";
String sql2 = "select * from " + post + " where title='" + title + "'"; 

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
stmt.executeUpdate(sql);
ResultSet rs = stmt.executeQuery(sql2);

String uid = "";
while(rs.next()){
	uid = rs.getString("uid");
}
rs.close();
conn.close();
stmt.close();
%>

<script>
	location.href = "giver_list.jsp?post=<%=post%>&uid=<%=uid%>";
</script>
