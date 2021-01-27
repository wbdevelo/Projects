<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/include/header.jsp"%>

<script>
	 function check(){
		if(confirm("장바구니에 상품을 담으시겠습니까?")== true){
		 document.go_cart.location.href="/cart/cartSI";
		}else{//취소
			return false;
		}
	} 
</script>

<style>
	.btn_cart{
		width:100px;
		height:30px;
		background-color:#8777e3;
		color:white;
		border:0px;
	}
	.btn_ba{
		width:100px;
		height:30px;
		background-color:#60a9f2;
		color:white;
		border:0px;
	}
	.ti {
		width:100px;
	}
</style>
<br><br><br>
<form id="go_cart" name="go_cart" action="/cart/cartSI" method="post" onsubmit="return check()">
	<input type="hidden" name="uid" value="${e.uid}">
	<input type="hidden" name="id" value="${sessionScope.id}">
	<input type="hidden" name="guest" value="${session_guest}">
	<input  type="hidden" name="writtenbyid" value="${e.writtenbyid}">
<table align="center" width=1000px style="border:2px solid #d8d8d8">
	<tr>
		<td colspan=2><h2>${e.title }</h2></td>
	</tr>
	<tr>
		<td width=10%>
			<img src="/upload/${e.thum_file}"><!-- 나타낼때 경로지정해서 출력 -->
			<input type="hidden" value="${e.thum_file}"><!--DB넣을때는 경로지정 X -->
		</td>
		<td width=50px;></td>
		<td>
			<table align=top width=100%>
			<tr>
				<td class="ti">작가</td>
				<td>${e.writer }</td>
			</tr>
			<tr>
				<td class="ti">출판년도</td>
				<td>${e.pub_date }</td>
			</tr>
			<tr>
				<td class="ti">지원기기</td>
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
				<td class="ti">가격</td>
				<td>${e.price}원</td>
			</tr>
			<tr>
				<td class="ti">포인트</td>
				<td>${e.point}p</td>
			</tr>
			</table>
		</td>
	</tr>
</table>
<table width=100%>
	<tr>
		<td height=20px;></td>
	</tr>
	<tr>
		<td style="text-align:center" colspan=2>
			<input class="btn_cart" type="submit" value="장바구니">
			<input class="btn_ba" type="button" onclick="action='/e_book/BuyPass.do';submit();" value="바로구매">
		</td>
	</tr>
	<tr>
		<td height=20px;></td>
	</tr>
</table>
<table align="center" width=1000px style="border:1px solid #d8d8d8">
	<tr>
		<td width=100px align=center>책 소개</td>
		<td>${e.content }</td>
	</tr>
</table>
</form>
<table align="center" style="border-spacing: 150px 10px;" width=1000px>
	<tr>
		<td><h3>저자의 다른 책</h3></td>
	</tr>
	<tr>
		<td colspan=4 style="text-align:right;"><a href="view_writerBook.do?writer=${e.writer }">저자의 다른책 더보기 >></a></td>
	</tr>
	<tr>
		<c:forEach var="v" items="${v }">
				<td>
					<a href="view_e.do?uid=${v.uid}&writer=${e.writer }">
					<img src="/upload/${v.thum_file}"><br>${v.title}
					</a>
				</td>
		</c:forEach>
	</tr>
</table>

<table width=1600px;>
	<c:choose>
		<c:when test="${e.writtenbyname == session_name || session_level == '10'}">
			<tr>
				<td align=right>
					<a href="modify_e.do?uid=${e.uid }">수정</a>
					<a href="delete_e.do?uid=${e.uid }">삭제</a>
					<a href="SelectE">목록</a>
				</td>
			</tr>
		</c:when>
		<c:otherwise> 
			<tr>
				<td align=right><a href="SelectE?category=${category}">목록</a></td>
			</tr>
		</c:otherwise>
	</c:choose>
</table>

<%@ include file="/include/footer.jsp"%>