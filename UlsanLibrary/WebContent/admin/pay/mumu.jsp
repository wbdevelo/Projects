<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/admin/include/header.jsp"%>

<style>
	.admu-frame{
		width:100%;
		min-height: 650px;
	}
</style>

<script>
	function go(aa){
		location.href="/admin/pay/mu.do?gubun="+aa;
	}
</script>

<div class="admu-frame"><!-- frame -->
	<table width=60% border=0px style="vertical-align:top; margin-left:20%;">
		<tr>
			<td><input type="radio" id="gubun" name="gubun" value="전체" onclick="go(this.value)" <c:if test="${gubun == null || gubun == '전체'}">checked</c:if> >전체</td>
			<td><input type="radio" id="gubun" name="gubun" value="gDaeki" onclick="go(this.value)" <c:if test="${gubun == 'gDaeki'}">checked</c:if> >구매확정 대기목록</td>
			<td><input type="radio" id="gubun" name="gubun" value="cDaeki" onclick="go(this.value)" <c:if test="${gubun == 'cDaeki'}">checked</c:if> >취소확정 대기목록</td>
			<td><input type="radio" id="gubun" name="gubun" value="o" onclick="go(this.value)" <c:if test="${gubun == 'o'}">checked</c:if> >구매확정 목록</td>
			<td><input type="radio" id="gubun" name="gubun" value="c" onclick="go(this.value)" <c:if test="${gubun == 'c'}">checked</c:if> >취소확정 목록</td>
		</tr>
	</table>
	
	<table width=60% border=2px style="vertical-align:top; margin-left:20%; border-color:#515658">
		<tr height=70px>
			<td>주문번호</td>
			<td>구분</td>
			<td>아이디</td>
			<td>가격</td>
			<td>주문현황</td>
			<td width=70px;>취소여부</td>
		</tr>
	
	<c:forEach var="v" items="${v}">
	<form action="gumae_complete.do" method="post">
	<tr>
		<td><a href="detail.do?id=${v.id}&guest=${v.guest}&product_num=${v.product_num}&state=${v.state}">${v.uid}</a></td>
		<c:choose>
			<c:when test="${v.id == '' || v.id == null}">
				<td>비회원</td>
				<td>${v.guest}</td>
				<td>${v.price}</td>
				<c:if test="${v.state eq '△'}">
					<td>구매확정 대기</td>
					<td><input type="submit" value="확인"></td>
				</c:if>
				<c:if test="${v.state eq 'o'}">
					<td>구매확정</td>
					<td><input type="submit" formaction="adminCancel.do" value="취소"></td>
				</c:if>
				<c:if test="${v.state eq 'cDaeki'}">
					<td>구매취소 대기</td>
					<td><input type="submit" formaction="cancel_permit.do" value="취소"></td>
				</c:if>
				<c:if test="${v.state eq 'c'}">
					<td>구매취소</td>
					<td></td>
				</c:if>
			</c:when>
			<c:otherwise>
				<td>회원</td>
				<td>${v.id}</td>
				<td>${v.price}</td>
				<c:if test="${v.state eq '△'}">
					<td>구매확정 대기</td>
					<td><input type="submit" value="확인"></td>
				</c:if>
				<c:if test="${v.state eq 'o'}">
					<td>구매확정</td>
					<td><input type="submit" formaction="adminCancel.do" value="취소"></td>
				</c:if>
				<c:if test="${v.state eq 'cDaeki'}">
					<td>구매취소 대기</td>
					<td><input type="submit" formaction="cancel_permit.do" value="취소"></td>
				</c:if>
				<c:if test="${v.state eq 'c'}">
					<td>구매취소</td>
					<td></td>
				</c:if>
			</c:otherwise>
		</c:choose>
		<input type="hidden" name="product_num" value="${v.product_num}">
		<input type="hidden" name="id" value="${v.id}">
		<input type="hidden" name="guest" value="${v.guest}">
		<input type="hidden" name="uid" value="${v.uid}">
		<br>
	</tr>
	</form> 
	</c:forEach>
	
	</table>
</div>

<%@ include file="/admin/include/footer.jsp"%>