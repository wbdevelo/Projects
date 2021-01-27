<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file ="/admin/include/header.jsp"%>

<script>
	 function check(){
		if(confirm("장바구니에 상품을 담았습니다.\n장바구니로 이동하시겠습니까?")== true){
		 document.go_cart.location.href="/cart/cartSI";
		}else{//취소
			return false;
		}
	} 
	
	function baro_go(){
		  document.frm.action = "/e_book/BuyPass.do";
		  document.frm.method = "post";
	}
	/* function check(){
		var con_test = confirm("어떤 값이 나올까요.");
		if(con_test == true){
		    alert("확인을 누르셨군요");
		}
		else if(con_test == false){
		    alert("취소를 누르셨군요.");
		}
	} */
</script>

<form id="frm" name="go_cart" action="/cart/cartSI" method="post" onsubmit="return check()">
	<input type="hidden" name="uid" value="${e.uid}">
	<input type="hidden" name="id" value="${sessionScope.id}">
	<input type="hidden" name="guest" value="${session_guest}">
<table border=1 align="center">
	<tr>
		<td>책 제목</td>
		<td><h3>${e.title }</h3></td>
	</tr>
	<tr>
		<td>책 소개</td>
		<td>${e.content }</td>
	</tr>
	<tr>
		<td>작가</td>
		<td>${e.writer }</td>
	</tr>
	<tr>
		<td>ISBN</td>
		<td>${e.ISBN }</td>
	</tr>
	<tr>
		<td>출판년도</td>
		<td>${e.pub_date }</td>
	</tr>
	<tr>
		<td>지원기기</td>
		<td>
			<c:choose>
				<c:when test="${e.device_pc != null }">
					${e.device_pc } / 
				</c:when>
				<c:otherwise>
				
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${e.device_mobile != null }">
					${e.device_mobile } / 
				</c:when>
				<c:otherwise>
				
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${e.device_tablet != null }">
					${e.device_tablet }
				</c:when>
				<c:otherwise>
				
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
	<tr>
		<td>책 표지</td>
		<td>
			<img src="/upload/${e.file}"><!-- 나타낼때 경로지정해서 출력 -->
			<input type="hidden" value="${e.thum_file}"><!--DB넣을때는 경로지정 X -->
		</td>
	</tr>
	<tr>
		<td>E-book파일</td>
		<td>${e.book_file }</td>
	</tr>
	<tr>
		<td>가격</td>
		<td>${e.price}</td>
	</tr>
</table>
</form>

<table>
	<tr>
		<td><a href="/admin/AdminModifyE_Book.do?uid=${e.uid }">수정</a></td>
		<td><a href="/admin/include/AdminDeleteE_book.do?uid=${e.uid }">삭제</a></td>
		<td><a href="/admin/include/AdminBook_list.do">목록</a></td>
	</tr>
</table>

<%@include file ="/admin/include/footer.jsp"%>