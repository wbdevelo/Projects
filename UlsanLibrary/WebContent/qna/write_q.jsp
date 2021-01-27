<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp"%>

<form action="insertQ" method="post" enctype="multipart/form-data">
<input type="hidden" name="id" value="${session_id}">
<input type="hidden" name="name" value="${session_name}">
	<div>제목 <input name="title"></div>
	<div>내용 <textarea name="content"></textarea></div>
	<div>첨부파일 <input type="file"name="file"></div>
	<div><input type="submit" value="전송"></div>
</form>

<%@ include file="/include/footer.jsp"%>