<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/include/header.jsp"%>

<style>
 textarea {
	width:200px;
	height:150px;
	resize:none;
}
</style>


<form name="" action="insert_E.do" method="post" enctype="multipart/form-data">
	<table border=1 align="center">
		<input type="hidden" name="id" value="${session_id}">
		<input type="hidden" name="name" value="${session_name}">
		<tr>
			<td>책 제목</td>
			<td><input name="title"></td>
		</tr>
		<tr>
			<td>책 소개</td>
			<td><textarea name="content"></textarea></td>
		</tr>
		<tr>
			<td>작가</td>
			<td><input name="writer"></td>
		</tr>
		<tr>
			<td>ISBN</td>
			<td><input name="ISBN"></td>
		</tr>
		<tr>
			<td>출판년도</td>
			<td><input name="pub_date"></td>
		</tr>
		<tr>
			<td>지원기기</td>
			<td>
				<input type="checkbox" name="device_pc" value="pc">pc
				<input type="checkbox" name="device_mobile" value="Mobile">Mobile
				<input type="checkbox" name="device_tablet" value="tablet">tablet pc
			</td>
		</tr>
		<tr>
			<td>책 표지</td>
			<td><input type="file" multiple="multiple" name="file1"></td>
		</tr>
		<tr>
			<td>E-book파일</td>
			<td><input type="file" multiple="multiple" name="file2" ></td>
		</tr>
		<tr>
			<td>가격</td>
			<td><input name="price"></td>
		</tr>
		<tr>
			<td colspan=2><input type="submit"  onsubmit="return false;" value="책 등록"></td>
		</tr>
	</table>
</form>








<%@ include file="/include/footer.jsp"%>