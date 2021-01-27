<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/admin/include/header.jsp" %>

<style>
	.aclist-frame{
		width:100%;
		min-height: 650px;
		position: relative;
	}
	
	.aclist-main{
		width:60%;
		min-height: 630px;
		position: absolute;
		top:10px;
		left:20%;
		border-left: 1px solid #dedede;
		border-right: 1px solid #dedede;
	}
	
	
	.aclist-head{
		width:75%;
		height:30px;
		position: absolute;
		top:15px;
		left:11%;
		border-top: 3px dashed #0074c8;
		border-bottom: 3px dashed #0074c8;
		
	}
	
	.aclist-bodyframe{
		width:75%;
		position: absolute;
		top:55px;
		left:11%;
		border-bottom: 3px dashed #0074c8;
		
	}
	
	.aclist-body{
		border-bottom: 1px solid #dedede;
	}
	
	
	.aclist-total{
		width:100%;
		text-align: center;
		border-top: 3px dashed #0074c8;
		margin-top: 5px;
		padding-top:2px; 
	}
	
	
	.cell3{
		display: table-cell; 
		padding: 3px; 
		width:170px;
		text-align: center;
	}
	
	
	.accol1{
		width:140px;
	}
	
	.accol2{
		width:220px;
	}
	
	.accol3{
		width:150px;
	}
	
	.accol4{
		width:150px;
	}
	
	.accol5{
		width:145px;
	}
	
</style>



<div class="aclist-frame"><!--aclist-frame  --><!--  -->
	<div class="aclist-main"><!--aclist-main  -->
		<div class="aclist-head"><!--aclist-head  -->
			<span class="cell3 accol1">아이디</span>
			<span class="cell3 accol2">상품번호</span>
			<span class="cell3 accol3">상품가격</span>
			<span class="cell3 accol4">입금자명</span>
			<span class="cell3 accol5">상태</span>
		</div>
		<div class="aclist-bodyframe">
			<fmt:parseNumber var="total_price" value="0" integerOnly="true"/>
			<c:forEach var="ov" items="${ov}">
				<c:choose>
					<c:when test="${ov.id == null || ov.id == ''}">
						<div class="aclist-body"><!--aclist-body  -->
							<span class="cell3 accol1">${ov.guest}</span>
							<span class="cell3 accol2">${ov.product_num}</span>
							<span class="cell3 accol3">${ov.price}</span>
							<span class="cell3 accol4">${ov.ipkumja}</span>
							<span class="cell3 accol5">${ov.state}</span>
						</div>
					</c:when>
				<c:otherwise>
						<div class="aclist-body"><!--aclist-body  -->
							<span class="cell3 accol1">${ov.id}</span>
							<span class="cell3 accol2">${ov.product_num}</span>
							<span class="cell3 accol3">${ov.price}</span>
							<span class="cell3 accol4">${ov.ipkumja}</span>
							<span class="cell3 accol5">${ov.state}</span>
						</div>
				</c:otherwise>
			</c:choose>
			<fmt:parseNumber var="total_price" value="${total_price + ov.price}" integerOnly="true"/>
			</c:forEach>
			<fmt:formatNumber var="total_price" value="${total_price}"/>
			<div class="aclist-total">Total: \ ${total_price}</div>
		</div>
		
	</div>
</div>


<%@include file="/admin/include/footer.jsp" %>