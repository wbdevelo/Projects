<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/include/header.jsp"%>
<head>
<style>
td{
text-align:center;
border-bottom:1px solid black;
border-spacing:0px;
}

</style>

</head>
<body >
<h2 align="center">구매완료</h2>
<table border=1 align="center" width=60% >
	<tr>
		<td>
			<table border=1 align="center" width=100% >
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
							</tr>
							<tr>
								<td colspan=2><img src="/upload/${v.thum_file}"></td>
								<td colspan=2>${v.title } </td>
								<td colspan=2>${v.product_num}  </td>
								<td colspan=2>${v.price } </td>
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
		</td>
	</tr>
</table>	
</div>
<table border=0 align="center"  width=60%>
	<tr>
		<td width=50%><a href="/">확인</a></td>
	</tr>
</table>
</body>


<%@ include file="/include/footer.jsp"%>



<%-- <script type="text/javascript" src="/resources/script/html2canvas.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script language="Javascript">
    $(function(){
        /** btnDown 버튼 클릭 **/
        $('#btnDown').click(function() {
            html2canvas($('.printDiv'), {
                onrendered: function(canvas) {
                    if (typeof FlashCanvas != "undefined") {
                        FlashCanvas.initElement(canvas);
                    }
                    var image = canvas.toDataURL("image/png"); 
                    $("#imgData").val(image);
                    $("#imgForm").submit();
                }
            });
        });
    });
</script>
</head>
<body leftmargin="0" marginwidth="0" topmargin="0" marginheight="0">
    <div class="printBtnZone" align="right" >
        <a id="btnDown" class="btn bg-gray small w-auto">다운로드</a>
    </div>
    <form name="imgForm" id="imgForm" action="/link/download/" method="post">
        <input type="hidden" id="imgData" name="imgData">
    </form>
    <div class="printDiv">
       ============================================== 
       여기가 이미지로 바뀌는 영역입니다.
       이 영역에는 table 등 기타 다른 테그들로 체워질 수 있습니다.
       ==============================================
        <body >
		<!-- 캡쳐영역 시작 -->
		<h2 align="center">구매완료</h2>
		<table border=1 align="center" width=60% >
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
						</tr>
						<tr>
							<td colspan=2><img src="/upload/${v.thum_file}"></td>
							<td colspan=2>${v.title } </td>
							<td colspan=2>${v.product_num}  </td>
							<td colspan=2>${v.price } </td>
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
				<td colspan=2><button onclick ="capbutton">내 PC저장<td>
			</tr>
		</table>
		</body>
    </div> --%>







<%@ include file="/include/footer.jsp"%>