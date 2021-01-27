<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>

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

<form action="update_gallery.do" method="post" enctype="multipart/form-data">
<input type="hidden"  name="uid" value="${g.uid}">
<input type="hidden"  name="thum_fileo" value="${g.thum_file}">
<input type="hidden" name="fileo" value="${g.file}">
<br><br>
	<table class="tt" align=center>
		<tr>
			<td colspan=2 height=30px;></td>
		</tr>
		<tr>
			<td class="ab">책 제목</td>
			<td><input class="inp" name="title" value="${g.title}"></td>
		</tr>
		<tr>
			<td class="ab">책 소개</td>
			<td><textarea style="width:400px" name="content">${g.content }</textarea></td>
		</tr>
		<tr>
			<td class="ab">작가</td>
			<td><input class="inp" name="writer" value="${g.writer }"></td>
		</tr>
		<tr>
			<td class="ab">ISBN</td>
			<td><input class="inp" name="ISBN" value="${g.ISBN }"></td>
		</tr>
		<tr>
			<td class="ab">출판년도</td>
			<td><input class="inp" name="pub_date" value="${g.pub_date }"></td>
		</tr>
		<tr>
			<td class="ab">책 표지</td>
			<td>
				<input type="file" name="file" value="${g.file }">
				<input type="hidden" name="thum_file" value="${g.thum_file }">
			</td>
		</tr>
		<tr>
			<td class="ab">도서관</td>
			<td><input class="inp" name="lib_name" value="${g.lib_name}"></td>
		</tr>
		<tr>
			<td class="ab">대출가능여부</td>
			<td>
				<c:if test="${g.daechul == '가능'}">
				<label><input type="radio" name="daechul" value="가능" checked> 가능 </label>
				<label><input type="radio" name="daechul" value="불가능"> 불가능 </label>
				</c:if>
				
				<c:if test="${g.daechul == '불가능'}">
				<label><input type="radio" name="daechul" value="가능"> 가능 </label>
				<label><input type="radio" name="daechul" value="불가능" checked> 불가능 </label>
				</c:if>
			</td>
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