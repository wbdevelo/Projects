<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
.foot-frame{
	background-color:#f8f8f8 ;
    border-top: 1px solid #cdcdcd;
    width: 100%;
    height: 200px;
    position: relative;
}

.first-footer{
    width: 100%;
    position: absolute;
    top: 0%;
    left: 0%;
    background-color:#f8f8f8;
}
.link-menu{
	position: absolute;
    top: 0%;
    left: 0%;
    height: 70px;
    display:inline-table;
    width:60%;
    background-color:#f8f8f8;
}

#liblogo{
	width:200px;
	height:50px;
	margin-left: 10px;
}


#menu1{
	display: table-cell;
    vertical-align: middle;
    cursor:pointer;
    font-size:14px;
}


#menu2{
	display: table-cell;
    vertical-align: middle;
    cursor:pointer;
    font-size:14px;
    margin:10px;
}

#menu3{
	display: table-cell;
    vertical-align: middle;
    cursor:pointer;
    font-size:14px;
}

#menu4{
	display: table-cell;
    vertical-align: middle;
    cursor:pointer;
    font-size:14px;
}

#menu5{
	display: table-cell;
    vertical-align: middle;
    cursor:pointer;
    font-size:14px;
}


.second-footer{
	width: 100%;
    height: 30px;
    position: absolute;
    top: 37%;
    left: 0%;
    background-color:#f8f8f8;
}

.tool-bar{
	position: absolute;
    top: 0%;
    left: 20%;
	background-color:#f8f8f8;
    width: 20%;
    height: 30px;
    display:inline-table;
}

#Privacy-Statement{
	display: table-cell;
    vertical-align: middle;
    text-align: center;
    cursor:pointer;
    font-size:14px;
    color:#5882fa;
}

#way-to-come{
	display: table-cell;
    vertical-align: middle;
    text-align: center;
    cursor:pointer;
    font-size:14px;
    color:#404253;
}

#Terms-of-Use{
	display: table-cell;
    vertical-align: middle;
    text-align: center;
    cursor:pointer;
    font-size:14px;
    color:#404253;
}

#Cancellation-policy{
	display: table-cell;
    vertical-align: middle;
    text-align: center;
    cursor:pointer;
    font-size:14px;
    color:#404253;
}


.third-footer{
	width: 40%;
    height: 85px;
    position: absolute;
    top: 55%;
    left: 19%;
}

.copy{
	color:#4e4e4e;
	padding:15px;
	font-size:14px
}

.fourth-footer{
	width: 20%;
    height: 85px;
    position: absolute;
    top: 55%;
    left: 60%;
}

.logos{
	position: absolute;
    top: 10%;
    left: 30%;
}

.footerimg{
	padding:15px;
	margin-right:10px;
	
}


</style>    

<body>
	<div class="foot-frame"><!-- footer-frame -->
		<div class="first"><!-- first-footer -->
			<div class="link-menu"><!-- 도서관 링크 메뉴-->
				<div id="menu1"><a href="/"><img id="liblogo" alt="울산남부도서관로고" src="/img/NAM.PNG"></a></div>
				<div id="menu2"><a href="/"><img id="liblogo" alt="울산중부도서관로고" src="/img/JUNGGU.PNG"></a></div>
				<div id="menu3"><a href="/"><img id="liblogo" alt="울산동부도서관로고" src="/img/DONGGU.PNG"></a></div>
				<div id="menu4"><a href="/"><img id="liblogo" alt="울산북구도서관로고" src="/img/BUKGU.PNG"></a></div>
				<div id="menu5"><a href="/"><img id="liblogo" alt="울주군도서관로고" src="/img/uljugun.PNG"></a></div>
			</div>
		</div>
		<div class="second-footer"><!-- second-footer -->		
			<div class="tool-bar"><!-- 툴바 -->
				<div id="Privacy-Statement">개인정보취급방침 |</div>
				<div onclick="location.href='/waytocome.jsp'" id="way-to-come"> 오시는길 |</div>
				<div id="Terms-of-Use"> 이용약관 |</div>
				<div id="Cancellation-policy"> 취소 및 환불정책</div>
			</div>
		</div>
		<div class="third-footer">	<!-- third-footer -->
			<div class="copy"><!-- 카피라이터 -->
				<a>(44762)울산광역시 남구 꽃대나리로 140(여천동)</a>
				<a>대표전화 : 052-266-5670  FAX : 052-229-6809</a><br>
				<a>Copyright(c) ULSANLIBRARY. All rights reserved.</a>
			</div>
		</div>
		<div class="fourth-footer">	<!-- fourth-footer -->
			<div class="logos"><!-- 로고모음 -->
				<img class="footerimg" src="/img/ulsanfooterlogo.png">
				<img class="footerimg"  src="/img/UlsanBrandSloganblack.png">
			</div>
		</div>
	</div>
</body>
