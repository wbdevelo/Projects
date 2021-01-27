<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp"%>
<style>
	.cart-frame{
		width:100%;
	}

	.cart-content{
		width:60%;
		height:100%;
	}
	.ccheck{
		width:100px;
		text-align:center;
		padding-top:70px;
	}
	.iimmgg{
		width:170px;
	}
	.Ctitle{
		width:600px;
		font-size:18px;
		padding-top:65px;
	}
	.prpoint{
		width:100px;
		padding-top: 50px;
	}
	.teduri{
	 	display:flex;
	 	border-bottom:2px solid #d8d8d8;
	 	height:180px;
	 }
	 .btn_gu{
	 	width:300px;
	 	height:50px;
	 	border:0px;
	 	background-color:#5882fa;
	 	color:white;
	 	border-radius: 5px 5px 5px 5px;
	 	font-size:18px;
	 	font-weight:bold;
	 }
	 .btn_sub{
	 	width:50px;
	 	height:30px;
	 	border:2px solid #5882fa;
	 	color:#5882fa;
	 	background-color:white;
	 	border-radius: 10px 10px 10px 10px;
	 }
</style>
<script>

	/* function noEvent() { // 새로 고침 방지
	    if (event.keyCode == 116) {
	        alert("새로고침을 할 수 없습니다.");
	        event.keyCode = 2;
	        return false;
	    } else if (event.ctrlKey && (event.keyCode == 78 || event.keyCode == 82)) {
	        return false;
	    }
	}
	document.onkeydown = noEvent; */
	
	

	function all_checked(a){
		var f = document.c;
		
		for(var i=0; i<f.length; i++){
			if(f.elements[i].name == "gumae[]"){
				f.elements[i].checked = a;
			}
		}
	}
	
	function send(f){
		var chk_count = 0;
		var chk_str = "";
		
		for(var i=0; i<f.length; i++){
			if(f.elements[i].name == "gumae[]" && f.elements[i].checked == true){
				chk_count++;
				chk_str += f.elements[i].value + ",";
			}
		}
		if(!chk_count){
			alert("게시물을 하나 이상 선택하세요.");
			return false;
		}
		
		if(document.a == "빼기"){
			if(!confirm("선택한 게시물을 정말 삭제하시겠습니까?")){
				return false;
			}
			f.action = "deleteC.do?num="+chk_str;
		}else{
			if(!confirm("선택한 게시물을 구매하시겠습니까?")){
				return false;
			}
			f.action = "/purchase/purchase.do?num="+chk_str; 
		}
		
		return true;
	}
</script>

<div style="display:flex">
	<div style="width:25%"></div>
	<div style="width:49%;">
		<div style="padding-left:40px;"><input type="checkbox" onclick="if (this.checked) all_checked(true); else all_checked(false);"></div>
		<fmt:parseNumber var="total_price" value="0"/>
		<fmt:parseNumber var="total_point" value="0"/>
		<form name="c" action="deleteC.do" onsubmit="return send(this);" method="post">
		<c:forEach var="v" items="${v}">
			<div style="height:20px;"></div>
			<div class="teduri">
				<div class="ccheck">
					<input type="checkbox" name="gumae[]" value="${v.product_num}">
				</div>
				<div class="iimmgg">
					<img style="width:140px;height:160px" src="/upload/${v.thum_file}">
				</div>
				<div class="Ctitle">
					${v.title}
				</div>
				<div class="prpoint">
					<div style="height:30px;">${v.price}원</div>
					<div><img src="/img/coins.png">${v.point}p</div>
				</div>
			<fmt:parseNumber var="total_price" value="${total_price + v.price}" integerOnly="true"/>
			<fmt:parseNumber var="total_point" value="${total_point + v.point}" integerOnly="true"/>
			</div>	
		</c:forEach>
		<fmt:formatNumber var="total_price" value="${total_price}"></fmt:formatNumber>
		<fmt:formatNumber var="total_point" value="${total_point}"></fmt:formatNumber>
		<div style="height:60px;padding-top:30px;">
			<input class="btn_sub" type="submit" name="sub" value="빼기" onclick="document.a=this.value">
		</div>
		<div style="display:flex;">
			<div>
				<b>총 금액 : </b><b style="font-size:20px">${total_price}원</b><br>
				<b>총 포인트 : </b><b style="font-size:20px">${total_point}p</b>
			</div>
			<div style="width:600px;text-align:right">
				<input class="btn_gu" type="submit" name="sub" value="구매하기" onclick="document.a=this.value">
			</div>
		</div>
		</form>
	</div>
	<div style="width:25%"></div>
</div>



<%@ include file="/include/footer.jsp"%>





