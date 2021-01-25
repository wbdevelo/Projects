<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>
<%@page import="java.awt.Image"%>
<%@page import="com.sun.jimi.core.Jimi"%>
<%@page import="com.sun.jimi.core.JimiException"%>
<%@page import="com.sun.jimi.core.JimiUtils"%> 

<%
request.setCharacterEncoding("utf-8");

java.util.Date today = new java.util.Date();
SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String signdate = cal.format(today);

String file = "";
String file_o = "";
String file_rename = "";

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
String uid = mult.getParameter("uid");

Enumeration files = mult.getFileNames();

file = (String)files.nextElement();
file_o = mult.getOriginalFileName(file);
file_rename = mult.getFilesystemName(file);

String sql;
if(file_rename == "" || file_rename == null){
	sql="update " + post + " set title='" + title + "', content='" + content + "' where uid='" + uid + "'";
}else{

	//썸네일 처리
	String orgImg = uploadPath+"\\"+file_rename;//원본파일
	String thum_img = "thum_"+file_rename;//썸네일파일
	String thumbImg = uploadPath+"\\"+thum_img;

	int thumbWidth = 160 ;//썸네일 가로
	int thumbHeight = 160 ;//썸네일 세로

	Image thumbnail = JimiUtils.getThumbnail(orgImg, thumbWidth, thumbHeight, Jimi.IN_MEMORY);// 썸네일 설정
	Jimi.putImage(thumbnail, thumbImg);
	
	sql ="update " + post + " set title='" + title + "', content='" + content + "', file_rename = '" + file_rename + "', file_o = '" + file_o + "', file_s = '" + thum_img + "' where uid='" + uid + "'";
}
Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
stmt.executeUpdate(sql);

stmt.close();
conn.close();
%>

<script>
	location.href="view.jsp?post=<%=post%>&uid=<%=uid%>";
</script>