<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>

<style>
.mypage-frame{
	width:100%;
	height:800px;
	position:relative; 
}

.mycontent-box{
	width:60%;
	height:798px;
	align:center;
	position: absolute;
	left:20%
}

.my-head{
	width:40%;
	height:50px;
	align:center;
	border-bottom:1px solid #9d9aa0;
	position: absolute;
	top:30px;
	left:28%;
	text-align:center;
}

.my-head > a{
	font-size:30px;
	font-weight:600;
}

.my-info{
	width:40%;
	height:110px;
	align:center;
	border-bottom:1px solid #9d9aa0;
	position: absolute;
	top:100px;
	left:28%;
	text-align:center;
	line-height: 80px;
}



#session_name1{
	width:100%;
	height:50px;
	align:center;
	font-size:20px;
	font-weight:400;
	text-align:center;
	padding:5px;
}

#session_name2{
	width:100%;
	height:50px;
	align:center;
	font-size:20px;
	font-weight:400;
	text-align:center;
	padding:5px;
}

.my-gogo{
	width:40%;
	height:243px;
	align:center;
	border:1px solid #9f9f9f;
	position: absolute;
	top:230px;
	left:28%;
	text-align:center;
}

.mymodi{
	width:100%;
	height:58px;
	align:center;
	border-bottom:1px solid #9f9f9f;
	position: absolute;
	top:1px;
	left:0px;
	text-align:center;
	cursor: pointer;
	background-color:#eeeeee;
	display:flex;
}

.mymodi:hover{
	width:100%;
	height:58px;
	align:center;
	border-bottom:1px solid #9f9f9f;
	position: absolute;
	top:1px;
	left:0px;
	text-align:center;
	cursor: pointer;
	color:#FFFFFF;
    background-color:#0089d6;
}

.mymodi > a{
	font-size:20px;
	font-weight:400;
	position: absolute;
	top:15px;
	left:43%;
}

.myQ{
	width:100%;
	height:60px;
	align:center;
	border-bottom:1px solid #9f9f9f;
	position: absolute;
	top:62px;
	left:0px;
	text-align:center;
	cursor: pointer;
	background-color:#eeeeee;
}

.myQ:hover{
	width:100%;
	height:60px;
	align:center;
	border-bottom:1px solid #9f9f9f;
	position: absolute;
	top:61px;
	left:0px;
	text-align:center;
	cursor: pointer;
	color:#FFFFFF;
    background-color:#0089d6;
}

.myQ > a{
	font-size:20px;
	font-weight:400;
	position: absolute;
	top:15px;
	left:42%;
}

.buylistbt{
	width:100%;
	height:60px;
	align:center;
	border-bottom:1px solid #9f9f9f;
	position: absolute;
	top:123px;
	left:0px;
	text-align:center;
	cursor: pointer;
	background-color:#eeeeee;
}

.buylistbt:hover{
	width:100%;
	height:60px;
	align:center;
	border-bottom:1px solid #9f9f9f;
	position: absolute;
	top:123px;
	left:0px;
	text-align:center;
	cursor: pointer;
	color:#FFFFFF;
    background-color:#0089d6;
}

.buylistbt > a{
	font-size:20px;
	font-weight:400;
	position: absolute;
	top:15px;
	left:42%;
}

.jjimmokbt{
	width:100%;
	height:60px;
	align:center;
	border-bottom:1px solid #9f9f9f;
	position: absolute;
	top:184px;
	left:0px;
	text-align:center;
	cursor: pointer;
	background-color:#eeeeee;
}

.jjimmokbt:hover{
	width:100%;
	height:60px;
	align:center;
	border-bottom:1px solid #9f9f9f;
	position: absolute;
	top:184px;
	left:0px;
	text-align:center;
	cursor: pointer;
	color:#FFFFFF;
    background-color:#0089d6;
}

.jjimmokbt > a{
	font-size:20px;
	font-weight:400;
	position: absolute;
	top:15px;
	left:42%;
}


.goodbyebt{
	width:100%;
	height:60px;
	align:center;
	border-bottom:1px solid #9f9f9f;
	position: absolute;
	top:123px;
	left:0px;
	text-align:center;
	cursor: pointer;
	background-color:#eeeeee;
}

.goodbyebt:hover{
	width:100%;
	height:60px;
	align:center;
	border-bottom:1px solid #9f9f9f;
	position: absolute;
	top:123px;
	left:0px;
	text-align:center;
	cursor: pointer;
	color:#FFFFFF;
    background-color:#0089d6;
}

.goodbyebt > a{
	font-size:20px;
	font-weight:400;
	position: absolute;
	top:15px;
	left:42%;
}

.mybook-list{
	width:100%;
	height:60px;
	align:center;
	border-bottom:1px solid #9f9f9f;
	position: absolute;
	top:123px;
	left:0px;
	text-align:center;
	cursor: pointer;
	background-color:#eeeeee;
}

.mybook-list:hover{
	width:100%;
	height:60px;
	align:center;
	border-bottom:1px solid #9f9f9f;
	position: absolute;
	top:123px;
	left:0px;
	text-align:center;
	cursor: pointer;
	color:#FFFFFF;
    background-color:#0089d6;
}

.mybook-list > a{
	font-size:20px;
	font-weight:400;
	position: absolute;
	top:15px;
	left:42%;
}

.reservbt{
	width:100%;
	height:60px;
	align:center;
	position: absolute;
	top:184px;
	left:0px;
	text-align:center;
	cursor: pointer;
	background-color:#eeeeee;
	border-bottom:1px solid #9f9f9f;
}

.reservbt:hover{
	width:100%;
	height:60px;
	align:center;
	position: absolute;
	top:184px;
	left:0px;
	text-align:center;
	cursor: pointer;
	color:#FFFFFF;
    background-color:#0089d6;
}

.reservbt > a{
	font-size:20px;
	font-weight:400;
	position: absolute;
	top:15px;
	left:34%;
}
</style>

<div class="mypage-frame">
	<div class="mycontent-box">
		<div class="my-head">
			<a>MANAGE PAGE</a>
		</div>
		<div class="my-info">
			<div id="session_name1">'${session_name}' 님</div>
		</div>	
	<div class="my-gogo" >
		<div class="mymodi" onclick="location.href='/member/info_relog.jsp?id=${session_id}';">
			<div style="margin-left:25%;width:50%;line-height:58px;font-size:20px"><a><img src="/img/my.png"> 정보수정</a></div>
		</div>
		<div class="myQ" onclick="location.href='/member/myQ.do?id=${session_id}';">
			<div style="width:50%;line-height:58px;margin-left:25%;font-size:20px"><a><img src="/img/qna.png"> 나의 QnA</a></div>
		</div>
		<div class="mybook-list" onclick="location.href='/member/myG.do?lib_name=${session_name}';">
			<div style="width:50%;line-height:58px;margin-left:23%;font-size:20px"><a><img src="/img/list.png"> 책 목록</a></div>
		</div>
		<div class="reservbt" onclick="location.href='/library/SelectReserv.do?lib_name=${session_name}';">
			<div style="width:50%;line-height:58px;margin-left:30%;font-size:20px"><a><img src="/img/reserved.png"> 예약대기자 명단</a></div>
		</div>
	</div>
	</div>	
</div>

<%@ include file="/include/footer.jsp" %>