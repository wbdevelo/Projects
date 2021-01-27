<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp"%>

<style>
	.writeN-frame{
		width:100%;
		height:750px;
		position:relative;
	}
	
	.writeN-insert{
		width:60%;
		height:97%;
		position: absolute;
		top:0;
		left:20%;
		margin-top:10px;
		border-right:1px solid #dedede;
		border-left:1px solid #dedede;
	}
	
	.writeN-title {
		border-bottom:1px solid #dedede;
		width:1000px;
		margin-left:6%;
	}
	
	#writeN-titlearea{
		width:1000px;
		letter-spacing:1px;
		resize:none;
	}
	
	.writeN-content {
		border-bottom:1px solid #dedede;
		width:1000px;
		height:480px;
		margin-left:6%;
	}
	
	#writeN-textarea{
		width:1000px;
		height:450px;
		letter-spacing:1px;
		resize:none;
		
	}
	
	.writeN-file {
		border-bottom:1px solid #dedede;
		width:1000px;
		height:30px;
		margin-left:6%;
		padding-top:5px;
	}
	
	.writeN-sub {
		width:70px;
		margin-left:6%;
		padding-left:930px;
	}
	
	
</style>

<div class="writeN-frame">
	<form action="insertN" method="post" enctype="multipart/form-data">
		<input type="hidden" name="id" value="${session_id}">
		<input type="hidden" name="name" value="${session_name}">
		<div class="writeN-insert">
			<div class="writeN-title">제목<input name="title" id="writeN-titlearea"></div>
			<div class="writeN-content">내용<textarea id="writeN-textarea" name="content" ></textarea></div>
			<div class="writeN-file">첨부파일<input type="file" name="file"></div>
			<div class="writeN-sub"><input id="writeN-sub" type="submit" value="작성완료"></div>
		</div>
	</form>
</div>

<%@include file = "/include/footer.jsp" %>