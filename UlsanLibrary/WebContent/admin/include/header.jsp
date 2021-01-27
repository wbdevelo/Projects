<%@page import="dao.CartDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
String session_id = (String)session.getAttribute("id");
String session_name = (String)session.getAttribute("name");
String session_level = (String)session.getAttribute("level");

if(session_level !=null && session_level.equals("10")){
	
}else{
	%>
	<script>
	alert("잘못된 접근방식 입니다.");
	location.href="/";
	</script>
	<% 
}

%>

<c:set var="session_id" value="${sessionScope.id}"/>
<c:set var="session_name" value="${sessionScope.name}"/>
<c:set var="session_level" value="${sessionScope.level}"/>
<c:set var="cart_count" value="${sessionScope.cart_count}"/>

<%-- session_guest : ${session_guest} / 
session_id : ${session_id} / 
session_name : ${session_name} / 
session_level : ${session_level} / 
cart_count : ${cart_count} /  --%>


<head>
<title>울산도서관만들기</title>
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
	width:228px;
	height:31px;
	margin-top:40px;
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

#Member-mg{
	display: table-cell;
    vertical-align: middle;
    text-align: center;
    border-right: 1px solid #d4d4d4;
    cursor:pointer;
    font-weight: 500; 
    font-size:24px;
}

#Purchase-mg {
	display: table-cell;
    vertical-align: middle;
    text-align: center;
    border-right: 1px solid #d4d4d4;
    cursor:pointer;
    font-weight: 500; 
    font-size:24px;
}
#ebook-mg {
	display: table-cell;
    vertical-align: middle;
    border-right: 1px solid #d4d4d4;
    text-align: center;
    cursor:pointer;
    font-weight: 500; 
    font-size:24px;
}

#gogo-main {
	display: table-cell;
    vertical-align: middle;
    text-align: center;
    cursor:pointer;
    font-weight: 500; 
    font-size:24px;
}
</style>
</head>
<div class="frame"><!-- frame -->
		<div class="first"><!-- first head -->
		
			<div class="logobox"><!-- logo -->
				<a href="/admin/index.jsp">
					<img id="uisanlogo" alt="울산도서관로고" src="/img/ulsanliblogo.png">
				</a>
			</div>
			
			<div class="buttonbox"><!-- button area -->
				<c:choose>
					<c:when test="${session_level != null && session_level == '10'}">
						<div OnClick="location.href ='/admin/'" id="admindiv">
							총관리자
						</div>
					</c:when>
					<c:when test="${session_level != null && session_level == '5' }">
						<div OnClick="location.href ='/admin/'" id="admindiv">
							도서관리자
						</div>
					</c:when>
					<c:otherwise>
						
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${session_id != null}">
						<div id="logout_button" onclick="location.href='/member/logout.do'">
							로그아웃
						</div>
						<br>
						<div id="cart_button" onclick="location.href='/cart/SelectC.do?id=${session_id}&guest=${session_guest}'">
							
						<c:if test="${cart_count >= 1}">
							(${cart_count})
						</c:if>
						</div>
						<div id="alarm_button" onclick="location.href='/ReservationAlarm/SelectAlarm.do?id=${session_id}'">
							
						<c:if test="${alarm_count >= 1}">
							(${alarm_count})
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
		
		<div class="second"><!-- second head(menu) -->
			<div id="Member-mg" onclick="location.href='/admin/member/member_list.do'">회원관리  </div>
			<div id="Purchase-mg" onclick="location.href='/admin/pay/mu.do'">구매관리</div>
			<div id="ebook-mg" onclick="location.href='/admin/include/AdminBook_list.do'">전자도서 관리</div>
			<div id="gogo-main" onclick="location.href='/'">일반메인</div>
		</div>
</div>















