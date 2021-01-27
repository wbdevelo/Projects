<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ include file="/include/header.jsp"%>



<script>
	function mu(){
		var fo = document.pur;
		
		location.href="BaroPayMethod.do?num="+fo.num.value+"&pay="+fo.pmethod.value;
	}
	
	function subb(){
		var fo = document.pur;
		
		if(fo.bank.value == "x"){
			alert('은행을 선택해주세요.');
			fo.bank.focus();
			return;
		}
		if(!fo.ip.value){
			alert('입금자명을 입력해주세요.');
			fo.ip.focus();
			return;
		}
		fo.submit();
	}
	
	function pointU(){
		var fo = document.pur;
		
		fo.sub.value = (fo.price.value*1) - (fo.use_point.value*1);
		fo.mypoint.value = (fo.pp.value*1) - (fo.use_point.value*1);
		
	}

</script>


<fmt:parseNumber var="total_price" value="0"/>
<fmt:parseNumber var="total_point" value="0"/>
<form name="pur" action="/purchase/paybaro.do"  method="post">
	<table border=1 align="center" width="50%" height="300px" style="text-align:center;">
		<h1>바로구매 페이지</h1>
		<tr>
			<td colspan=3>구매자 정보</td>
		</tr>
		<tr>
			<td>아이디</td>
			<td colspan=2>${session_id }</td>
		</tr>
		<tr>
			<td>이름</td>
			<td colspan=2>${m.name }</td>
		</tr>
		<tr>
			<td colspan=3>주문 물품</td>
		</tr>
	<input type="hidden" name="num" value="${num}">
	<c:forEach var="b" items="${b }">	
		<tr>
			<td><img src="/upload/${b.thum_file}"></td>
			<td>${b.title }</td>
			<td>
				<fmt:formatNumber var="price" value="${b.price }"/>
				\ ${price}
				<input type="hidden" name="hereis" value="${b.whereis }"><!-- cart구매와 buynow 구매를 구분함 -->
			</td>
		</tr>
		<fmt:parseNumber var="total_price" value="${total_price + b.price}" integerOnly="true"/>
		<fmt:parseNumber var="total_point" value="${total_point + b.point}" integerOnly="true"/>
	</c:forEach>
			
		<tr>
			<td colspan=3>결제정보</td>
		</tr>
		<c:choose>
			<c:when test="${m.point < 1000}">
				<tr>
					<td colspan=3>
						포인트는 1,000점 이상부터 사용이 가능합니다.<br>
						현재 ${m.name} 님의 포인트는 ${m.point}점 입니다.
					</td>
				</tr>
			</c:when>
			<c:otherwise>
				<tr>
					<td>사용 가능한 포인트</td>
					<input id="pp" value="${m.point}">
					<td colspan=2><input id="mypoint" name="mypoint" value="${m.point}" readonly="readonly"></td>
				</tr>
				<tr>
					<td>사용할 포인트</td>
					<td colspan=2><input id="use_point" name="use_point"><input type="button" onclick="pointU()" value="사용하기"></td>
				</tr>
			</c:otherwise>
		</c:choose>
		<tr>
		<input id="price" name="price" value="${total_price}" readonly="readonly">
		<fmt:formatNumber var="total_point" value="${total_point}"/>
			<td>총 금액</td>
			<td colspan=2>Total price: \ <input id="sub" name="sub" value="${total_price}" readonly="readonly"></td>
		</tr>
		<tr>
			<td>총 포인트</td>
			<td colspan=2>Total point : \ ${total_point}</td>
		</tr>
		<tr>
			<td>결제 방식</td>
			<td colspan=2>
			<input type="radio" id="pmethod" name="pmethod" value="mutongjang" onclick="mu(this)"<c:if test="${paymethod == 'mutongjang'}">checked</c:if> >무통장 
			<input type="radio" id="pmethod" name="pmethod" value="card" onclick="mu(this)"<c:if test="${paymethod == 'card'}">checked</c:if> >카드
			</td>
		</tr>
		<c:if test="${paymethod == 'mutongjang'}">
			<tr>
				<td colspan=3>
					<select name="bank">
						<option value="x">입금하실 은행을 선택하세요.</option>
						<option value="우리은행">우리은행</option>
						<option value="제일은행">제일은행</option>
						<option value="신한은행">신한은행</option>
						<option value="우체국">우체국</option>
						<option value="KEB하나은행">KEB하나은행</option>
						<option value="기업은행">기업은행</option>
						<option value="국민은행">국민은행</option>
						<option value="농협">농협</option>
					</select>
					<input name="ip" placeholder="입금자">
				</td>
			</tr>
			<tr>
				<td colspan=3>예금주: ------ ##은행 1234-1234-1234-12</td>
			</tr>
		</c:if>
		<c:if test="${session_id == null || session_id == ''}">
			<tr>
				<td colspan=3>비밀번호: <input type="password" name="pass"></td>
			</tr>
		</c:if>
		<tr>
			<td colspan=3><input type="button" value="결제하기" onclick="subb()"></td>
		</tr>
	</table>
</form>































<%@ include file="/include/footer.jsp"%>