<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/include/header.jsp"%>
    
    
	
	
	
<style>
	.modiN-frame{
		width:100%;
		height:750px;
		position:relative;
	}
	
	.modiN-insert{
		width:60%;
		height:97%;
		position: absolute;
		top:0;
		left:20%;
		margin-top:10px;
		border-right:1px solid #dedede;
		border-left:1px solid #dedede;
	}
	
	.modiN-writtenbyname{
		border-bottom:1px solid #dedede;
		width:1000px;
		margin-left:6%;
	}
	
	.modiN-title {
		border-bottom:1px solid #dedede;
		width:1000px;
		margin-left:6%;
	}
	
	#modiN-titlearea{
		width:1000px;
		letter-spacing:1px;
		resize:none;
	}
	
	.modiN-content {
		border-bottom:1px solid #dedede;
		width:1000px;
		height:480px;
		margin-left:6%;
	}
	
	#modiN-textarea{
		width:1000px;
		height:450px;
		letter-spacing:1px;
		resize:none;
		
	}
	
	.modiN-file {
		border-bottom:1px solid #dedede;
		width:1000px;
		height:30px;
		margin-left:6%;
		padding-top:5px;
	}
	
	.modiN-sub {
		width:70px;
		margin-left:6%;
		padding-left:930px;
	}
	
	
</style>
<%-- <form action="update_n.do" method="post">
	<div class="modiN-writtenbyname">글쓴이 :<input value="${n.name }" readonly name="name"></div>
	<div class="modiN-title">제목 : <input value="${n.title }" name="title" id="modiN-titlearea"></div>
	<div class="modiN-content">내용 : <input value="${n.content }" name="content" id="modiN-textarea"></div>
	<div>첨부파일 : <input type="file" value="${n.file }" name="file"></div>
	<div><input type="hidden" name="uid" value="${n.uid }"></div>
	<div>
	<input type="submit" value="수정완료">
	</div>
</form>  --%>
	
<div class="modiN-frame">
	<form action="update_n.do" method="post" >
		<div class="modiN-insert">
			<div class="modiN-writtenbyname">글쓴이 :<input value="${n.name }" readonly name="name"></div>
			<div class="modiN-title">제목<input value="${n.title }" name="title" id="modiN-titlearea"></div>
			<div class="modiN-content">내용<input value="${n.content }" name="content" id="modiN-textarea"></div>
			<div class="modiN-file">첨부파일<input type="file" value="${n.file }" name="file"></div>
			<div><input type="hidden" name="uid" value="${n.uid }"></div>
			<div class="modiN-sub"><input type="submit" value="수정완료"></div>
		</div>
	</form>
</div>
	
	
	
<%@ include file="/include/footer.jsp"%>	