<%@page import="dao.CartDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%
	Date today = new Date();
	SimpleDateFormat cal = new SimpleDateFormat("yyyyMMddHHmmss");
	String signdate = cal.format(today);
	
	String session_guest = (String)session.getAttribute("guest");
	
	if(session_guest == null){
		session.setAttribute("guest", "guest_"+signdate);
	}
%>
<c:set var="session_guest" value="<%=session_guest%>"/>
<c:set var="session_id" value="${sessionScope.id}"/>
<c:set var="session_name" value="${sessionScope.name}"/>
<c:set var="session_level" value="${sessionScope.level}"/>
<c:set var="cart_count" value="${sessionScope.cart_count}"/>
<c:set var="recent" value="${sessionScope.recent}"/>


<%-- session_guest : ${session_guest} / 
session_id : ${session_id} / 
session_name : ${session_name} / 
session_level : ${session_level} / 
cart_count : ${cart_count} / 
recent : ${recent} /  --%>


<head>
<title>울산도서관만들기</title>
<link rel="stylesheet" href="/CSS/basic.css">
<style>

.frame{
	background-color: ;
    border-bottom: 1px solid #d4d4d4;
    width: 100%;
    height: 205px;
    position: relative;
}
.first-frame{
	background-color: ;
    border: 1px solid #d4d4d4;
    width: 100%;
    height: 205px;
    position: relative;
}
.first{
	position: absolute;
    top: 0%;
    left: 20%;
	background-color:;
    width: 60%;
    height: 101px;
    display:inline-table;
}

.logobox{
	width:128px;
	height:31px;
	margin-top:40px;
}

.sessionName{
	height:40px;
	margin-left:500px;
	position: absolute;
    top: 30%;
    left: 10%;
    line-height:40px;
    text-align:center;
    border-bottom:3px solid #5882fa;
    border-style:dashed;
    border-top:0px;
    border-left:0px;
    border-right:0px;
}

#uisanlogo{
	width:227px;
	height:30px;
}

.buttonbox{
	width:200px;
	height:71px;
	display: table-cell;
    vertical-align: middle;
    text-align: center;
}

#login_button{
	display: table-cell;
    vertical-align: middle;
    text-align: center;
    border-right:1px solid gray;
    margin-right::10px;
    padding:0px 5px;
    cursor:pointer;
    text-color:gray;
}

#join_button{
	display: table-cell;
    vertical-align: middle;
    text-align: center;
    cursor:pointer;
    padding:0px 0px 0px 5px;
}

#admindiv{
	display: table-cell;
    vertical-align: middle;
    text-align: center;
    border-right:1px solid gray;
    margin-right::10px;
    padding:0px 5px;
    cursor:pointer;
    text-color:gray;
    font-weight: 500; 
    font-size:14px;
	}
	
#my_button{
	display: table-cell;
    vertical-align: middle;
    text-align: center;
    border-right:1px solid gray;
    margin-right::10px;
    padding:0px 5px;
    cursor:pointer;
    text-color:gray;
    font-size:14px;
}

#logout_button{
	display: table-cell;
    vertical-align: middle;
    text-align: center;
    cursor:pointer;
    padding:0px 0px 0px 5px;
    font-size:14px;
}	

#cart_button{
	display: table-cell;
    vertical-align: middle;
    text-align: center;
    border-right:1px solid gray;
    margin-right::10px;
    padding:0px 5px;
    cursor:pointer;
    text-color:gray;
    font-size:14px;
}

#alarm_button{
	display: table-cell;
    vertical-align: middle;
    text-align: center;
    cursor:pointer;
    padding:0px 0px 0px 5px;
    font-size:14px;
}	

#view-buy{
	display: table-cell;
    vertical-align: middle;
    text-align: center;
    cursor:pointer;
    padding:0px 0px 0px 5px;
    font-size:14px;
}
.second{
	position: absolute;
    top: 49%;
    left: 20%;
	background-color:;
    width: 60%;
    height: 81px;
    display:inline-table;
}

.second_ten{
	position: absolute;
    top: 10%;
    left: 20%;
	background-color:;
    width: 60%;
    height: 81px;
    display:inline-table;
}

#gallerybox{
	display: table-cell;
    vertical-align: middle;
    text-align: center;
    border-right: 1px solid #d4d4d4;
    cursor:pointer;
    font-weight: 500; 
    font-size:24px;
}

#ebookbox {
	display: table-cell;
    vertical-align: middle;
    text-align: center;
    border-right: 1px solid #d4d4d4;
    cursor:pointer;
    font-weight: 500; 
    font-size:24px;
}
#noticebox {
	display: table-cell;
    vertical-align: middle;
    text-align: center;
    border-right: 1px solid #d4d4d4;
    cursor:pointer;
    font-weight: 500; 
    font-size:24px;
}
#qnabox {
	display: table-cell;
    vertical-align: middle;
    text-align: center;
    cursor:pointer;
    font-weight: 500; 
    font-size:24px;
}
.ac{
	font-weight:bold;
	color:red;	
}
</style>
</head>
<div class="frame"><!-- frame -->
		<div class="first"><!-- first head -->
		
			<div class="logobox"><!-- logo -->
				<a href="/index.do">
					<img id="uisanlogo" alt="울산도서관로고" src="/img/ulsanliblogo.png">
				</a>
			</div>
			
			<c:if test="${session_id != null}">
				<div class="sessionName">
					${session_name}님 환영합니다.
				</div>
			</c:if>
			
			<div class="buttonbox"><!-- button area -->
				<c:choose>
					<c:when test="${session_level != null && session_level == '10'}">
						<div OnClick="location.href ='/admin/index.jsp'" id="admindiv">
							총관리자
						</div>
					</c:when>
					<c:when test="${session_level != null && session_level == '5' }">
						<div OnClick="location.href ='/library/managePage.jsp'" id="admindiv">
							도서관리자
						</div>
					</c:when>
					<c:otherwise>
						
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${session_id != null}">
						<c:if test="${session_level == 1}">
							<div id="my_button" onclick="location.href='/member/mypage.do'"> 
								MY
							</div>
						</c:if>
						<div id="logout_button" onclick="location.href='/member/logout.do'">
							로그아웃
						</div>
						<br>
						<div id="cart_button" onclick="location.href='/cart/SelectC.do?id=${session_id}&guest=${session_guest}'">
							장바구니
						<c:if test="${cart_count >= 1}">
							(${cart_count})
						</c:if>
						</div>
						<c:if test="${session_level == 1}">
							<div id="alarm_button" onclick="location.href='/ReservationAlarm/SelectAlarm.do?id=${session_id}'">
								<img src="/img/bell.png">
							<c:if test="${alarm_count >= 1}">
								<span class="ac">${alarm_count}</span>
							</c:if>
						</c:if>
						<c:if test="${session_level == 5}">
							<div id="alarm_button" onclick="location.href='/library/SelectAlarm.do?lib_name=${session_name}'">
								<img src="/img/bell.png">
							<c:if test="${alarm_count >= 1}">
								<span class="ac">${alarm_count}</span>
							</c:if>
						</c:if>
						</div>
					</c:when>
					<c:otherwise>
						<div id="login_button"  onclick="location.href='/member/login.jsp'"> 
							로그인
						</div>
						<div id="join_button" onclick="location.href='/member/join.jsp'">
							회원가입
						</div>
						<br>
						<div id="cart_button" onclick="location.href='/cart/SelectC.do?id=${session_id}&guest=${session_guest}'">
							장바구니
						<c:if test="${cart_count >= 1}">
							(${cart_count})
						</c:if>
						</div>
						<div id="view-buy" onclick="location.href='/b_member/chk_num.jsp'">
							<c:if test="${session_id == '' || session_id == null}">
							구매조회
							</c:if>	
						</div>
					</c:otherwise>	
				</c:choose>	
			</div>
		</div>
		
		<c:choose>
			<c:when test="${session_level == '10'}">
				<div class="second_ten"><!-- second head(menu) -->
					<div id="gallerybox" onclick="location.href='/gallery/SelectG'">도서  </div>
					<div id="ebookbox" onclick="location.href='/e_book/SelectE'">EBOOK</div>
					<div id="noticebox" onclick="location.href='/notice/SelectN'">NOTICE</div>
					<div id="qnabox" onclick="location.href='/qna/SelectQ'">  QNA</div>
				</div>
			</c:when>
			<c:otherwise>
				<div class="second"><!-- second head(menu) -->
					<div id="gallerybox" onclick="location.href='/gallery/SelectG'">도서  </div>
					<div id="ebookbox" onclick="location.href='/e_book/SelectE'">EBOOK</div>
					<div id="noticebox" onclick="location.href='/notice/SelectN'">NOTICE</div>
					<div id="qnabox" onclick="location.href='/qna/SelectQ'">  QNA</div>
				</div>
			</c:otherwise>
		</c:choose>
</div>
<div style="height:30px;"></div>














