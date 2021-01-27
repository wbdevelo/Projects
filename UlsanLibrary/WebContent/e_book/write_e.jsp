<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/include/header.jsp"%>


<script>
	function ssub(){
		fo = document.wre;
		
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
		if(!fo.pub_date.value){
			alert("출판일을 입력해주세요.");
			fo.pub_date.focus();
			return;
		}
		if(!fo.price.value){
			alert("가격을 입력해주세요.");
			fo.price.focus();
			return;
		}
		if(!fo.file1.value){
			alert("책 표지 파일을 입력해주세요.");
			fo.file1.focus();
			return;
		}
		if(!fo.file2.value){
			alert("ebook 파일을 입력해주세요.");
			fo.file2.focus();
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
<form name="wre" action="insert_E.do" method="post" enctype="multipart/form-data">
	<table class="tt" align="center">
		<input type="hidden" name="id" value="${session_id}">
		<input type="hidden" name="name" value="${session_name}">
		<tr>
			<td class="ab">카테고리</td>
			<td>
				<input type="radio" id="category" name="category" value="domestic" checked>국내소설
				<input type="radio" id="category" name="category" value="foreign">외국소설
				<input type="radio" id="category" name="category" value="none">비소설
				<input type="radio" id="category" name="category" value="poem">시
				<input type="radio" id="category" name="category" value="economy">경제경영
				<input type="radio" id="category" name="category" value="child">어린이
				<input type="radio" id="category" name="category" value="science">인문과학
				<input type="radio" id="category" name="category" value="language">외국어
				<input type="radio" id="category" name="category" value="IT">IT
				<input type="radio" id="category" name="category" value="study">수험
			</td>
		</tr>
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
			<td class="ab">출판년도</td>
			<td><input class="inp" name="pub_date" id="pub_date"></td>
		</tr>
		<tr>
			<td class="ab">지원기기</td>
			<td>
				<input type="checkbox" name="device_pc" value="pc">pc
				<input type="checkbox" name="device_mobile" value="Mobile">Mobile
				<input type="checkbox" name="device_tablet" value="tablet">tablet pc
			</td>
		</tr>
		<tr>
			<td class="ab">책 표지</td>
			<td><input type="file" multiple="multiple" name="file1" id="file1"></td>
		</tr>
		<tr>
			<td class="ab">E-book파일</td>
			<td><input type="file" multiple="multiple" name="file2" id="file2"></td>
		</tr>
		<tr>
			<td class="ab">가격</td>
			<td><input class="inp" name="price" id="price"></td>
		</tr>
	</table>
	<table width="100%" height="120px">
		<tr>
			<td align="center">
				<input class="bt_wr" type="button"  onclick="ssub()" value="책 등록">
			</td>
		</tr>
	</table>
</form>

<%@ include file="/include/footer.jsp"%>