<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/admin/include/header.jsp" %>

<style>
.dt-frame{
	width:100%;
	min-height:700px;
	position: relative;
}

.dt-main{
	border-left:1px solid #dedede;
	border-right:1px solid #dedede;
	width:60%;
	height:95%;
	position: absolute;
	left:20%;
	margin-top:20px;
	margin-bottom: 20px;
}

.dt-first{
	width:20%;
	height:50%;
	position: absolute;
	top:10%;
	left:25%;
	text-align: center;
	font-size: 20px;
}

.dt-second{
	width:30%;
	height:50%;
	position: absolute;
	top:10%;
	left:46%;
	text-align: center;
	font-size: 20px;
}

.dt-third{
	border:1px solid #dedede;
	width:10%;
	height:30px;
	padding-top:5px;
	position: absolute;
	top:60%;
	left:66%;
	text-align: center;
	font-size: 18px;
	background-color:#f0f0f0;
	color:;
	
}

.dt-third:hover{
	width:10%;
	height:5%;
	position: absolute;
	top:60%;
	left:66%;
	text-align: center;
	font-size: 18px;
	background-color:#0074c8;
	color:#ffffff;
}

.dt-index{
	border-bottom:2px solid #cdcdcd;
	width:100%;
	height:34px;
	padding-top: 10px;
}
</style>


<div class="dt-frame"><!-- dt-frame -->
	<div class="dt-main"><!-- dt-main -->
		<div class="dt-first"><!-- dt-first -->
			<div class="dt-index" id="">구매자 아이디</div>
			<div class="dt-index" id="">구매상품</div>
			<div class="dt-index" id="">상품번호</div>
			<div class="dt-index" id="">구매일</div>
			<div class="dt-index" id="">입금은행</div>
			<div class="dt-index" id="">입금자명</div>
			<div class="dt-index" id="">상품가격</div>
		</div>
		
		<div class="dt-second"><!-- dt-second -->
			<c:forEach var="cv" items="${cv}">
				<c:choose>
					<c:when test="${cv.id == null || cv.id == ''}"><!-- 비회원일때 -->
						<div class="dt-index" id="">${cv.guest}</div>
						<div class="dt-index" id="">${cv.title}</div>
						<div class="dt-index" id="">${cv.product_num}</div>
						<div class="dt-index" id="">${cv.date}</div>
						<div class="dt-index" id="">${cv.bank}</div>
						<div class="dt-index" id="">${cv.ipkumja}</div>
						<div class="dt-index" id="">${cv.price}</div>
					</c:when>
					<c:otherwise><!-- 회원일때 -->
						<div class="dt-index" id="">${cv.id}</div>
						<div class="dt-index" id="">${cv.title}</div>
						<div class="dt-index" id="">${cv.product_num}</div>
						<div class="dt-index" id="">${cv.date}</div>
						<div class="dt-index" id="">${cv.bank}</div>
						<div class="dt-index" id="">${cv.ipkumja}</div>
						<div class="dt-index" id="">${cv.price}</div>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
		<div class="dt-third"><!-- dt-third -->
			<c:choose>
				<c:when test="${state == 'o'}">
					<div onclick="location.href='SelectA.do';">목록</div>
				</c:when>
				<c:otherwise>
					<div onclick="location.href='SelectA.do';">목록</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>	
</div>






<%@include file="/admin/include/footer.jsp" %>