<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp"%>

<%-- <form action="insert_G" method="post" enctype="multipart/form-data">
<input type="hidden" name="id" value="${session_id}">
<input type="hidden" name="name" value="${session_name}">
	<div>제목<input name="title"></div>
	<div>내용<textarea name="content">내용</textarea></div>
	<div>첨부파일<input type="file" name="file"></div>
	<div>ISBN<input name="ISBN"></div>
	<div>글쓴이<input name="writer"></div>
	<div>출판년도<input name="pub_date"></div>
	<div>
		대출 가능여부
		<label><input type="radio" name="daechul" value="가능">대출 가능</label>
		<label><input type="radio" name="daechul" value="불가능">불가능</label>
	</div>
	<div><input type="submit" value="전송"></div>
</form> --%>

<script>
	function ssub(){
		fo = document.wrg;
		
		if(!fo.title.value){
			alert("제목을 입력해주세요.");
			fo.title.focus();
			return;
		}
		if(!fo.content.value){
			alert("책 내용을 입력해주세요.");
			fo.content.focus();
			return;
		}
		if(!fo.writer.value){
			alert("작가를 입력해주세요.");
			fo.writer.focus();
			return;
		}
		if(!fo.ISBN.value){
			alert("ISBN을 입력해주세요.");
			fo.ISBN.focus();
			return;
		}
		if(!fo.pub_date.value){
			alert("출판일을 입력해주세요.");
			fo.pub_date.focus();
			return;
		}
		if(!fo.file.value){
			alert("책 표지 파일을 입력해주세요.");
			fo.file1.focus();
			return;
		}
		fo.submit();
	}
</script>


<style>
	 textarea {
		width:200px;
		height:150px;
		resize:none;
	}
	.tt{
		width:720px;
		height:700px;
		border-left:2px solid #d8d8d8;
		border-right:2px solid #d8d8d8;
	}
	.ab{
		text-align:center;
		font-weight:bold;
		width:150px;
	}
	.inp{
		height:25px;
		width:300px;
	}
	.bt_wr{
		width:100px;
		height:40px;
		background-color:#5882fa;
		color:white;
		border:0px;
	}
</style>
<br><br>
<form name="wrg" action="insert_G" method="post" enctype="multipart/form-data" onsubmit="ssub()">
	<table class="tt" align="center">
		<input type="hidden" name="id" value="${session_id}">
		<input type="hidden" name="name" value="${session_name}">
		<tr>
			<td class="ab">책 제목</td>
			<td><input class="inp" name="title" id="title"></td>
		</tr>
		<tr>
			<td class="ab">책 소개</td>
			<td><textarea style="width:400px" name="content" id="content"></textarea></td>
		</tr>
		<tr>
			<td class="ab">작가</td>
			<td><input class="inp" name="writer" id="writer"></td>
		</tr>
		<tr>
			<td class="ab">ISBN</td>
			<td><input class="inp" name="ISBN" id="ISBN"></td>
		</tr>
		<tr>
			<td class="ab">출판년도</td>
			<td><input class="inp" name="pub_date" id="pub_date"></td>
		</tr>
		<tr>
			<td class="ab">책 표지</td>
			<td><input type="file" multiple="multiple" name="file" id="file"></td>
		</tr>
		<tr>
			<td class="ab">대출가능 여부</td>
			<td>
				<label><input type="radio" name="daechul" value="가능">대출 가능</label>
				<label><input type="radio" name="daechul" value="불가능">불가능</label>
			</td>
		</tr>
	</table>
	<table width="100%" height="120px">
		<tr>
			<td align="center">
				<input class="bt_wr" type="submit" value="책 등록">
			</td>
		</tr>
	</table>
</form>


<%@ include file="/include/footer.jsp"%>