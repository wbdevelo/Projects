<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/include/header.jsp"%>


<script>

function pageback(){
	alert("수정을 취소하시겠습니까?");
	window.history.back();
}

</script>

<style>
	 textarea {
		width:200px;
		height:150px;
		resize:none;
	}
	.inp{
		height:25px;
		width:300px;
	}
	.bt_up{
		width:100px;
		height:40px;
		background-color:#5882fa;
		color:white;
		border:0px;
	}
	.bt_ca{
		width:100px;
		height:40px;
		border:2px solid #5882fa;
		background-color:white;
	}
	.ab{
		text-align:center;
		font-weight:bold;
		width:150px;
	}
	.tt{
		width:700px;
		height:700px;
		border-left:2px solid #d8d8d8;
		border-right:2px solid #d8d8d8;
	}
</style>

<form action="/e_book/update_E.do" method="post" enctype="multipart/form-data">
<input type="hidden" name="uid" value="${e.uid}">
<input type="hidden" name="id" value="${session_id}">
<input type="hidden" name="name" value="${session_name}">
<br><br>
	<table class="tt" align=center>
		<tr>
			<td colspan=2 height=30px;></td>
		</tr>
		<tr>
			<td class="ab">책 제목</td>
			<td><input class="inp" name="title" value="${e.title }"></td>
		</tr>
		<tr>
			<td class="ab">책 소개</td>
			<td><textarea style="width:400px" name="content">${e.content }</textarea></td>
		</tr>
		<tr>
			<td class="ab">작가</td>
			<td><input class="inp" name="writer" value="${e.writer }"></td>
		</tr>
		<tr>
			<td class="ab">출판년도</td>
			<td><input class="inp" name="pub_date" value="${e.pub_date }"></td>
		</tr>
		<tr>
			<td class="ab">지원기기</td>
			<td>
				<input type="checkbox" name="device_pc" value="${e.device_pc }" checked>PC
				<input type="checkbox" name="device_mobile" value="${e.device_mobile }" checked>Mobile
				<input type="checkbox" name="device_tablet" value="${e.device_tablet }" checked>tablet
			</td>
		</tr>
		<tr>
			<td class="ab">책 표지</td>
			<td>
				<input type="file" name="file1" value="${e.file }">
				<input type="hidden" name="thum_file1" value="${e.thum_file }">
			</td>
		</tr>
		<tr>
			<td class="ab">E-book파일</td>
			<td><input type="file" name="file2" value="${e.book_file }"></td>
		</tr>
		<tr>
			<td class="ab">가격</td>
			<td><input class="inp" name="price" value="${e.price }"></td>
		</tr>
	</table>
	<table width=100% height=120px>
		<tr>
			<td align=center>
				<input class="bt_up" type="submit"  onsubmit="return false;" value="책 등록수정">
				<input class="bt_ca" type="button"  onsubmit="return false;" onclick="pageback()" value="수정취소">
			</td>
		</tr>
	</table>
</form>



<%@ include file="/include/footer.jsp"%>