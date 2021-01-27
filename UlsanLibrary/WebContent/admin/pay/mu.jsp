<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/admin/include/header.jsp"%>
    
<style>
	.admu-frame{
		width:100%;
		min-height: 650px;
		position: relative;
		
		
	}
	
	.admu-main{
		width:60%;
		min-height: 650px;
		position: absolute;
		left: 20%;
	}
	
	.admu-first{
		width:60%;
		position: absolute;
		top:3%;
		left: 20%;
	}

	.admu-second{
		width:76%;
		position: absolute;
		top:7%;
		left: 10%;
		padding-top: 10px;
		background-color: #82bbda;
	}
	
	.admu-big{
		width:100%;
		min-height:300px;;
		position: absolute;
		top:15%;
	}
	
	.admu-third{
		width:80%;
		margin-bottom: -40px;
		position: absolute;
		left:10%;
		
	}
	
	.cell3{
		display: table-cell; 
		border-right:1px solid #cccccc;
		text-align: center;
		height:25px;
		padding-top: 5px;
	}
	.colll1{
		width: 150px;
	}
	.colll2{
		width: 150px;
	}
	.colll3{
		width: 100px;
	}
	.colll4{
		width: 100px;
	}
	
	.colll5{
		width: 200px;
	}
	
	.colll6{
		width: 150px;
	}
	
	
	/* #colll66:hover{
		width: 18%;
		background-color:#0047ca;
		color:white;
		cursor: pointer;
	} */


	.admu-submit{
		width:100%;
		heught:100%;
		border:none;
		background-color: white;
		cursor: pointer;
	}
	
	.admu-submit:hover{
		background-color:#008aee;
		color:white;
		cursor: pointer;
	}
</style>

<script>
	function go(aa){
		location.href="/admin/pay/mu.do?gubun="+aa;
	}
</script>


<div class="admu-frame"><!-- admu-frame -->
	<div class="admu-main"><!-- admu-maincontent -->
	
		<div class="admu-first"><!-- admu-first -->
			<label><input type="radio" id="gubun" name="gubun" value="전체" onclick="go(this.value)" <c:if test="${gubun == null || gubun == '전체'}">checked</c:if>>전체</label>
			<label><input type="radio" id="gubun" name="gubun" value="gDaeki" onclick="go(this.value)" <c:if test="${gubun == 'gDaeki'}">checked</c:if>> 구매확정 대기목록</label>
			<label><input type="radio" id="gubun" name="gubun" value="cDaeki" onclick="go(this.value)" <c:if test="${gubun == 'cDaeki'}">checked</c:if>> 취소확정 대기목록</label>
			<label><input type="radio" id="gubun" name="gubun" value="o" onclick="go(this.value)" <c:if test="${gubun == 'o'}">checked</c:if>> 구매확정 목록</label>
			<label><input type="radio" id="gubun" name="gubun" value="c" onclick="go(this.value)" <c:if test="${gubun == 'c'}">checked</c:if>> 취소확정 목록</label>
		</div>
		
		<div class="admu-second"><!-- admu-second -->
			<span class="cell3 colll1">No</span>
			<span class="cell3 colll2">구분</span>
			<span class="cell3 colll3">아이디</span>
			<span class="cell3 colll4">가격</span>
			<span class="cell3 colll5">주문현황</span>
			<span class="cell3 colll6">취소여부</span>
		</div>
		<div class="admu-big">
			<c:forEach var="v" items="${v}">
			<form action="gumae_complete.do" method="post">
				<div class="admu-third" onclick="location.href='/admin/account/detail.do?id=${v.id}&guest=${v.guest}&product_num=${v.product_num}&state=${v.state}';"><!-- admu-third -->
				<!-- 비회원 -->
					<span class="cell3 colll1">${v.uid}</span>
				<c:choose>
					<c:when test="${v.id == '' || v.id == null}">	
						<span class="cell3 colll2">비회원</span>
						<span class="cell3 colll3">${v.guest}</span>
						<span class="cell3 colll4">${v.price}</span>
						<c:if test="${v.state eq '△'}">
							<span class="cell3 colll5">구매확정 대기</span>
							<span class="cell3 colll6" id="colll66"><input type="submit" value="확인"></span>
						</c:if>
						<c:if test="${v.state eq 'o'}">
							<span class="cell3 colll5">구매확정</span>
							<span class="cell3 colll6" id="colll66"><input type="submit" formaction="adminCancel.do" value="취소"></span>
						</c:if>
						<c:if test="${v.state eq 'cDaeki'}">
							<span class="cell3 colll5">구매취소 대기</span>
							<span class="cell3 colll6" id="colll66"><input type="submit" formaction="cancel_permit.do" value="취소"></span>
						</c:if>
						<c:if test="${v.state eq 'c'}">
							<span class="cell3 colll5">구매취소</span>
							<span class="cell3 colll6" id="colll66"></span>
						</c:if>
					</c:when>
					<c:otherwise>
					<!-- 회원 -->
						<span class="cell3 colll2">회원</span>
						<span class="cell3 colll3">${v.id}</span>
						<span class="cell3 colll4">${v.price}</span>
						<c:if test="${v.state eq '△'}">
							<span class="cell3 colll5">구매확정 대기</span>
							<span class="cell3 colll6" id="colll66"><input class="admu-submit" type="submit" value="확인"></span>
						</c:if>
						<c:if test="${v.state eq 'o'}">
							<span class="cell3 colll5">구매확정</span>
							<span class="cell3 colll6" id="colll66"><input class="admu-submit" type="submit" formaction="adminCancel.do" value="취소"></span>
						</c:if>
						<c:if test="${v.state eq 'cDaeki'}">
							<span class="cell3 colll5"> 구매취소 대기</span>
							<span class="cell3 colll6" id="colll66"><input class="admu-submit" type="submit" formaction="cancel_permit.do" value="취소"></span>
						</c:if>
						<c:if test="${v.state eq 'c'}">
							<span class="cell3 colll5">구매취소</span>
							<span class="cell3 colll6" id="colll66"></span>
						</c:if>
					</c:otherwise>
				</c:choose>	
				</div>
					<input type="hidden" name="product_num" value="${v.product_num}">
					<input type="hidden" name="id" value="${v.id}">
					<input type="hidden" name="guest" value="${v.guest}">
					<input type="hidden" name="uid" value="${v.uid}">
					<br>
					</form> 
			</c:forEach>
		</div>
		
	</div>
</div>

