<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp"%>

<script>

	function subm(p_num){
		
		fo = document.fd;
		
		fo.submit();
	}
	
	function cancel(){
		
		if(count_uid.value == "1"){
			location.href = "cancel.do?id="+id.value+"&guest="+guest.value+"&ord_uid="+orduid.value;
		}else{
			if(confirm("함께 구매하신 모든 제품이 취소됩니다. 괜찮으십니까?") == true){
				location.href = "cancel.do?id="+id.value+"&guest="+guest.value+"&ord_uid="+orduid.value;
			}else{
				return;
			}
		}
		
	}
	
</script>

<style>
	.tittt{
		text-align:center;
		line-height:30px;
		border:2px solid #d8d8d8;
	}
</style>

<div>
	<div style="display:flex">
		<div style="width:20%"></div>
		<div style="width:79%;display:flex;height:30px;border-bottom:1px solid black">
			<div class="tittt" style="width:20%;font-weight:bold;font-size:18px;">제품번호</div>
			<div class="tittt" style="width:20%;font-weight:bold;font-size:18px;">제목</div>
			<div class="tittt" style="width:30%;font-weight:bold;font-size:18px;">다운로드 유효기간</div>
			<div class="tittt" style="width:11%;font-weight:bold;font-size:18px;">가격</div>
			<div class="tittt" style="width:11%;font-weight:bold;font-size:18px;">포인트</div>
			<div class="tittt" style="width:8%;font-weight:bold;font-size:18px;">ebook 파일</div>
		</div>
		<div style="width:20%"></div>
	</div>
	
	<form name="fd" action="/member/down.do" method="post">
	<div style="display:flex">
		<div style="width:20%"></div>
			<div style="width:79%;">
				<c:forEach var="v" items="${v}">
				<input type="hidden" id="product_num" name="product_num" value="${v.product_num}">
				<input type="hidden" id="ord_uid" name="ord_uid" value="${v.ord_uid}">
				<input type="hidden" name="ddate" value="${ddate}">
				<input type="hidden" name="ddateh" value="${ddateh}">
					<div style="display:flex">
						<div class="tittt" style="width:20%;">${v.product_num}</div> 
						<div class="tittt" style="width:20%;">${v.title}</div>
						<div class="tittt" style="width:30%;">${ddate} ~ ${ddateh}</div>
							<fmt:parseNumber var="pricef" value="${v.price}" integerOnly="true"/>
							<fmt:formatNumber var="price" value="${pricef}"/>
						<div class="tittt" style="width:11%;">${price}원</div>
							<fmt:parseNumber var="point" value="${pricef*0.05}" integerOnly="true"/>
						<div class="tittt" style="width:11%;">${point}p</div> 
						<c:choose>
							<c:when test="${todate <= v.date + 7}">
								<div class="tittt" style="width:8%;float:left">
									<a href="/upload/${v.file}" onclick="subm('${v.product_num}');" download> ebook파일 </a>
								</div>
							</c:when>
							<c:otherwise>
								<div class="tittt" style="width:8%;float:left">
									다운로드 유효기간이 지났습니다.
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</c:forEach>
			</div>
		<div style="width:20%"></div>
	</div>
	</form>
	
	<input type="hidden" id="orduid" name="orduid" value="${ord_uid}">
	<input type="hidden" id="id" name="id" value="${session_id}">
	<input type="hidden" id="guest" name="guest" value="${session_guest}">
	<input type="hidden" id="count_uid" name="count_uid" value="${count_uid}">
	<c:if test="${click_count == 0}">
		<div style="display:flex">
			<div style="width:20%"></div>
			<div style="width:79%;text-align:center">
				<input type="button" onclick="cancel();" value="구매취소">
			</div>
			<div style="width:20%"></div>
		</div>
	</c:if>
</div>

<%@ include file="/include/footer.jsp"%>