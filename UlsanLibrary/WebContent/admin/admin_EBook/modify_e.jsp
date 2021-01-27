<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/admin/include/header.jsp"%>

<style>
 textarea {
	width:200px;
	height:150px;
	resize:none;
}
</style>

<script>

function pageback(){
	alert("수정을 취소하시겠습니까?");
	window.history.back();
}

</script>

<form action="/admin/admin_EBook/AdminUpdateE.do" method="post" enctype="multipart/form-data">
<input type="hidden"  name="uid" value="${e.uid}">
<input type="hidden" name="id" value="${session_id}">
<input type="hidden" name="name" value="${session_name}">
	<table border=1 align="center">
		<tr>
			<td>책 제목</td>
			<td><input name="title" value="${e.title }"></td>
		</tr>
		<tr>
			<td>책 소개</td>
			<td><textarea name="content">${e.content }</textarea></td>
		</tr>
		<tr>
			<td>작가</td>
			<td><input name="writer" value="${e.writer }"></td>
		</tr>
		<tr>
			<td>ISBN</td>
			<td><input name="ISBN" value="${e.ISBN }"></td>
		</tr>
		<tr>
			<td>출판년도</td>
			<td><input name="pub_date" value="${e.pub_date }"></td>
		</tr>
		<tr>
			<td>지원기기</td>
			<td>
				<input type="checkbox" name="device_pc" value="${e.device_pc }">pc
				<input type="checkbox" name="device_mobile" value="${e.device_mobile }">Mobile
				<input type="checkbox" name="device_tablet" value="${e.device_tablet }">tablet pc
			</td>
		</tr>
		<tr>
			<td>책 표지</td>
			<td><input type="file" multiple="multiple" name="file1" value="${e.file }"></td>
		</tr>
		<tr>
			<td>E-book파일</td>
			<td><input type="file" multiple="multiple" name="file2" value="${e.book_file }"></td>
		</tr>
		<tr>
			<td>가격</td>
			<td><input name="price" value="${e.price }"></td>
		</tr>
		<tr>
			<td><input type="submit"  onsubmit="return;" value="책 등록수정"></td>
			<td><input type="button"  onsubmit="return false;" onclick="pageback()" value="수정취소"></td>
		</tr>
	</table>
</form>



<%@ include file="/admin/include/footer.jsp"%>