<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/admin/include/header.jsp"%>


<style>
	.btn_wr{
		width:80px;
		height:30px;
		border:0px;
		background-color:#00a7d8;
		color:white;
		border-radius: 5px 5px 5px 5px;
	}
</style>


<h1 align="center">관리자 E-BOOK 리스트</h1>

<div style="padding-left:1800px">
	<input class="btn_wr" type="button" onclick="location.href='/e_book/write_e.jsp';" value="글쓰기">
</div>

<div style="height:20px"></div>

<form>
	<table align="center" width=80% style="border-spacing: 2px;">
		<tr><td colspan=6 style="border-top:3px solid #00a7d8"></td></tr>	
		<tr>
			<td><input type="checkbox" name="" value="" id=""></td>
			<td>표지</td>
			<td>제목</td>
			<td>작가</td>
			<td>출간일</td>
		</tr>
		<tr><td colspan=6 style="border-top:3px solid #00a7d8"></td></tr>	
		<c:forEach var="v" items="${v }">
		<tr>
			<td><input type="checkbox" name="" value="" id=""></td>
			<td>
				<a href="/admin/admin_EBook/AdminViewE_Book.do?uid=${v.uid}">
					<img src="/upload/${v.thum_file }">
				</a>
			</td>
			<td>${v.title }</td>
			<td>${v.writer }</td>
			<td>${v.pub_date }</td>
		</tr>
		<tr><td colspan=6 style="border-top:1px solid #5f6368"></td></tr>	
		</c:forEach>
	</table>
</form>
    
    
    
<%@ include file="/admin/include/footer.jsp" %>