<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/include/header.jsp"%>



<script>
	function mu(){
		var fo = document.pur;
		
		location.href="/purchase/method.do?num="+fo.num.value+"&pay="+fo.pmethod.value;
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
		if(!fo.pass.value){
			alert("비밀번호를 입력해주세요.");
			fo.pass.focus();
			return;
		}
		fo.submit();
	}
	
	function subb_id(){
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

<Style>
	.banktr {
       visibility: hidden;
	}
	.btn_buy{
		width:100px;
		height:30px;
		background-color:#60a9f2;
		color:white;
		border:0px;
	}
	.btn_use{
		width:80px;
		height:20px;
		background-color:#8777e3;
		color:white;
		border:0px;
		border-radius: 10px 10px 10px 10px;
	}
	.bigg{
		width:50%;
		height:300px;
		text-align:center;
		border:1px solid #d8d8d8;
	}
	.bordown{
		border-bottom:1px solid #d8d8d8;
	}
	.borup{
		border-top:1px solid #d8d8d8;
	}
	.boright{
		border-right:1px solid #d8d8d8;
	}
</Style>
<fmt:parseNumber var="total_price" value="0"/>
<fmt:parseNumber var="total_point" value="0"/>
<form name="pur" action="pay.do" method="post">
	<table align="center" class="bigg">
	<input type="hidden" name="num" value="${num}">
		<tr>
			<td colspan=3 class="bordown">주문 물품</td>
		</tr>
	<c:forEach var="v" items="${v}">	
		<tr>
			<td class="boright"><img src="/upload/${v.thum_file}"></td>
			<td class="boright">${v.title }</td>
			<td>
				<fmt:formatNumber var="price" value="${v.price }"/>
				\ ${price}
			</td>
		</tr>
		<fmt:parseNumber var="total_price" value="${total_price + v.price}" integerOnly="true"/>
		<fmt:parseNumber var="total_point" value="${total_point + v.point}" integerOnly="true"/>
	</c:forEach>
		<tr>
			<td colspan=3 class="bordown borup">구매자 정보</td>
		</tr>
		<tr>
			<td class="boright">아이디</td>
			<td colspan=2>${session_id }</td>
		</tr>
		<tr>
			<td colspan=3 class="borup">결제정보</td>
		</tr>
		<c:choose>
			<c:when test="${m.point < 1000}">
				<tr>
					<td colspan=3 class="bordown borup">
						포인트는 1,000점 이상부터 사용이 가능합니다.<br>
						현재 ${m.name} 님의 포인트는 ${m.point}점 입니다.
					</td>
				</tr>
			</c:when>
			<c:otherwise>
				<tr>
					<td class="boright">사용 가능한 포인트</td>
					<input type="hidden" id="pp" value="${m.point}">
					<td colspan=2><input id="mypoint" name="mypoint" value="${m.point}" readonly="readonly"></td>
				</tr>
				<tr>
					<td class="boright">사용할 포인트</td>
					<td colspan=2>
						<input id="use_point" name="use_point">
						<input class="btn_use" type="button" onclick="pointU()" value="사용하기">
					</td>
				</tr>
			</c:otherwise>
		</c:choose>
		<tr>
		<input type="hidden" id="price" name="price" value="${total_price}" readonly="readonly">
		<fmt:formatNumber var="total_point" value="${total_point}"/>
			<td class="boright">총 금액</td>
			<td colspan=2>Total price: \ <input id="sub" name="sub" value="${total_price}" readonly="readonly"></td>
		</tr>
		<tr>
			<td class="boright">총 포인트</td>
			<td colspan=2>Total point : \ ${total_point}</td>
		</tr>
		<tr>
			<td class="boright">결제 방식</td>
			<td colspan=2>
			<input type="radio" id="pmethod" name="pmethod" value="mutongjang" onclick="mu(this)"<c:if test="${paymethod == 'mutongjang'}">checked</c:if> >무통장 
			<input type="radio" id="pmethod" name="pmethod" value="card" onclick="mu(this)"<c:if test="${paymethod == 'card'}">checked</c:if> >카드
			</td>
		</tr>
		<c:if test="${paymethod == 'mutongjang'}">
			<tr>
				<td colspan=3 class="bordown borup">
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
				<td colspan=3>예금주: 김지훈 <br>
					국민은행 1234-1234-1234-12
				</td>
			</tr>
		</c:if>
		<c:if test="${session_id == null || session_id == ''}">
			<tr>
				<td colspan=3 class="borup">비밀번호: <input type="password" name="pass" id="pass"></td>
			</tr>
		</c:if>
	</table>
	
	<table width=100%>
		<tr>
			<td height="30px"></td>
		</tr>
		<c:choose>
			<c:when test="${session_id == null}">
				<tr>
					<td align="center"><input class="btn_buy" type="button" value="결제하기" onclick="subb()"></td>
				</tr>
			</c:when>
			<c:otherwise>
				<tr>
					<td align="center"><input class="btn_buy" type="button" value="결제하기" onclick="subb_id()"></td>
				</tr>
			</c:otherwise>
		</c:choose>
	</table>
</form>

<%@ include file="/include/footer.jsp"%>