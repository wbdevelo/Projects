<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/include/header.jsp"%>

<style>
td{
text-align:center;
border-bottom:1px solid black;
border-spacing:0px;
}

</style>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<!-- 화면 캡쳐 CDN -->
<script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>


</head>
<body>
<h2 align="center">나의 E-BOOK 구매내역</h2>
<table border=1 align="center" width=60% id="capture">
	<tr>
		<td>주문정보</td>
		<td>
		<c:forEach var="m" items="${m}">
			<table  border=0 width=100%><!-- session_id로 member테이블에서 끌고오자 -->
				<tr>
					<td>주문자</td>
					<td>${m.id }/${m.name }</td>
				</tr>
				<tr>
					<td>이메일</td>
					<td>${m.email }</td>
				</tr>
				<tr>
					<td>적립포인트</td>
					<td>--p</td>
				</tr>
			</table>
		</c:forEach>	
		</td>
	</tr>
	<tr>
		<td>주문상품</td>	
		<td>
		<c:forEach var="v" items="${v}">
			<table  border=0 width=100%><!-- session_id로 cart테이블에서 끌고오자 -->
				<tr>
					<td colspan=2>표지</td>
					<td colspan=2>제목</td>
					<td colspan=2>상품번호</td>
					<td colspan=2>가격</td>
					<td colspan=2>상품현황</td>
				</tr>
				<tr>
					<td colspan=2><img src="/upload/${v.thum_file}"></td>
					<td colspan=2>${v.title } </td>
					<td colspan=2>${v.product_num}  </td>
					<td colspan=2>${v.price } </td>
					<td colspan=2>${v.purchase } </td>
				</tr>
			</table>
		</c:forEach>
		</td>
	</tr>
	<tr>
		<td>결제 정보</td>	
		<td>
			<c:forEach var="v" items="${v}" begin="1" end="1">
				<table  border=0 width=100%><!-- session_id로 order테이블에서 끌고오자 -->
					<tr>
						<td colspan=2>결제은행</td>
						<td colspan=2>입금 계좌번호</td>
					</tr>
					<tr>
						<td colspan=2></td>
						<td colspan=2>1234-1234-1234-12</td>
					</tr>
				</table>
			</c:forEach>
		</td>
	</tr>
	</table>
	<table border=0 align="center"  width=60%>
	<tr>
		<td width=50%><a href="/">확인</a></td>
		<td colspan=2><button id="shot">내 PC에 저장</button><td>
	</tr>
</table>


<!-- 캡쳐할 영역 -->

<script>
$(function(){
$("#shot").on("click", function(){
// 캡쳐 라이브러리를 통해서 canvas 오브젝트를 받고 이미지 파일로 리턴한다.
html2canvas(document.querySelector("#capture")).then(canvas => {
saveAs(canvas.toDataURL('image/png'),"capture-test.png");
});
});
function saveAs(uri, filename) {
// 캡쳐된 파일을 이미지 파일로 내보낸다.
var link = document.createElement('a');
if (typeof link.download === 'string') {
link.href = uri;
link.download = filename;
document.body.appendChild(link);
link.click();
document.body.removeChild(link);
} else {
window.open(uri);
}
}
});
</script>




<%@ include file="/include/footer.jsp"%>