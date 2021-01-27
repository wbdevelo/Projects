<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>
	
	
<style>
	.modiQ-frame{
		width:100%;
		height:750px;
		position:relative;
	}
	
	.modiQ-insert{
		width:60%;
		height:97%;
		position: absolute;
		top:0;
		left:20%;
		margin-top:10px;
		border-right:1px solid #dedede;
		border-left:1px solid #dedede;
	}
	
	.modiQ-writtenbyname{
		border-bottom:1px solid #dedede;
		width:1000px;
		margin-left:6%;
	}
	
	.modiQ-title {
		border-bottom:1px solid #dedede;
		width:1000px;
		margin-left:6%;
	}
	
	#modiQ-titlearea{
		width:1000px;
		letter-spacing:1px;
		resize:none;
	}
	
	.modiQ-content {
		border-bottom:1px solid #dedede;
		width:1000px;
		height:480px;
		margin-left:6%;
	}
	
	#modiQ-textarea{
		width:1000px;
		height:450px;
		letter-spacing:1px;
		resize:none;
		
	}
	
	.modiQ-file {
		border-bottom:1px solid #dedede;
		width:1000px;
		height:30px;
		margin-left:6%;
		padding-top:5px;
	}
	
	.modiQ-sub {
		width:70px;
		margin-left:6%;
		padding-left:930px;
	}
	
	
</style>

<div class="modiQ-frame">
	<form action="update_q.do" method="post">
	<input type="hidden" name="uid" value="${q.uid}">
	<input type="hidden" name="pageNum" value="${pageNum}">
		<div class="modiQ-insert">
			<div class="modiQ-title"> 제목: <input id="modiQ-titlearea" name="title" value="${q.title}"> </div>
			<div class="modiQ-content"> 내용: <textarea id="modiQ-textarea" name="content">${q.content}</textarea> </div>
			<div class="modiQ-file"> 사진: <img src="/upload/${q.file}"> </div>
			<div> <input type="file" name="file"> </div>
			<div class="modiQ-sub"> <input type="submit" value="수정완료"> </div>
		</div>
	</form>
</div>

<%@ include file="/include/footer.jsp"%>