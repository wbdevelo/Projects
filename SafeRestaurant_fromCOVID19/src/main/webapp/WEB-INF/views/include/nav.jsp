<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

	<!-- 폰트어썸 아이콘 -->
    <script src="https://kit.fontawesome.com/e9d65121b1.js" crossorigin="anonymous"></script>
    <!-- 제이쿼리 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    
<title>Insert title here</title>
</head>
<style>
    *{
        margin: 0;
        padding: 0;
    }
    .nav{
        width: 100%;
        display: flex;
        align-items: center;
        background: linear-gradient(to top, #ffffff 0%, #ccffcc 200%);
    }
    .logo{
        display: flex;
        justify-content: center;
        align-items: center;
        width: 20%;
    }
    .logo > a{
        color:black; 
        text-decoration: none;
    }
    .logo > a > span{
        font-size: 40px;
    }
    .main-menu{
        list-style: none;
        display: flex;
        justify-content:space-between;
        align-items: center;
        text-align: center;
        width: 60%;
    }
    .first-menu{
        padding: 20px;
        position: relative;
        cursor: pointer;
        width: 100%;
        font-weight: bold;
    }
    .first-menu:hover{
        background-color: rgba(0,0,0,0.2);
    }
    .menu-items{
        text-decoration: none;
        color: black;
        cursor: pointer;
    }
    .menu-items:hover{
        opacity: 0.5;
    }
    .member{
        width: 20%;
    }
    .before-login{
        display: flex;
        justify-content: space-around;
    }
    .after-login{
        display: flex;
        justify-content: space-around;
    }
    .member-items{
        text-decoration: none;
        color: black;
        font-weight: bold;
        font-size: 20px;
        
    }
    .member-items:hover{
        opacity: 0.5;
    }
    /* 드롭다운 */
    .drop-down{
        position: absolute;
        display: flex;
        flex-direction: column;
        width: 100%;
        top: 100;
        left: 0;
        margin-top: 20px;
        background: linear-gradient(to bottom, #ffffff 0%, #ccffcc 200%);
        border: 1px solid black;
        z-index: 1;
    }
    .sub-meun{
        padding: 30px;
    }
    .sub-meun:hover{
        background-color: rgba(0,0,0,0.2);
    }
    .sub-items{
        text-decoration: none;
        color: black;
    }
</style>
<body>
	<c:set var="session_id" value="${session_id}"/>
	<c:set var="session_level" value="${session_level}"/>
	<div class="nav">
        <div class="logo">
            <a href="/">
            	<img src="/resources/img/logo2.png" style="max-width: 100px;">
           	</a>
           	<a href="/">
                <span>
                    CLEAN FooD
                </span>
            </a>
        </div>
        <ul class="main-menu">
            <li class="first-menu">
                <div class="menu-items">카테고리</div>
                <ul class="drop-down">
                    <il class="sub-meun"><a href="/board/list?category=한식" class="sub-items">한식</a></il>
                    <il class="sub-meun"><a href="/board/list?category=중식" class="sub-items">중식</a></il>
                    <il class="sub-meun"><a href="/board/list?category=일식" class="sub-items">일식</a></il>
                    <il class="sub-meun"><a href="/board/list?category=서양식" class="sub-items">서양식</a></il>
                    <il class="sub-meun"><a href="/board/list?category=기타 음식점" class="sub-items">기타 음식점</a></il>
                </ul>
            </li>
            <li class="first-menu">
                <div class="menu-items">메뉴2</div>
                <ul class="drop-down">
                    <il class="sub-meun"><a href="" class="sub-items">서브메뉴1</a></il>
                    <il class="sub-meun"><a href="" class="sub-items">서브메뉴1</a></il>
                    <il class="sub-meun"><a href="" class="sub-items">서브메뉴1</a></il>
                </ul>
            </li>
            <li class="first-menu">
                <div class="menu-items">메뉴3</div>
                <ul class="drop-down">
                    <il class="sub-meun"><a href="" class="sub-items">서브메뉴1</a></il>
                    <il class="sub-meun"><a href="" class="sub-items">서브메뉴1</a></il>
                    <il class="sub-meun"><a href="" class="sub-items">서브메뉴1</a></il>
                </ul>
            </li>
            <li class="first-menu">
                <div class="menu-items">메뉴4</div>
                <ul class="drop-down">
                    <il class="sub-meun"><a href="" class="sub-items">서브메뉴1</a></il>
                    <il class="sub-meun"><a href="" class="sub-items">서브메뉴1</a></il>
                    <il class="sub-meun"><a href="" class="sub-items">서브메뉴1</a></il>
                </ul>
            </li>
            <li class="first-menu">
                <div class="menu-items">메뉴5</div>
                <ul class="drop-down">
                    <il class="sub-meun"><a href="" class="sub-items">서브메뉴1</a></il>
                    <il class="sub-meun"><a href="" class="sub-items">서브메뉴1</a></il>
                    <il class="sub-meun"><a href="" class="sub-items">서브메뉴1</a></il>
                </ul>
            </li>
        </ul>
        <div class="member">
	       <c:if test="${session_id == null}">
                <div class="before-login">
                    <a href="/member/login" class="member-items"><i class="fas fa-sign-in-alt"> 로그인</i></a>
                    <a href="/member/join" class="member-items"><i class="fas fa-user-lock"> 회원가입</i></a>
	            </div>
            </c:if>
            <c:if test="${session_id != null}">
                <div class="after-login">
                    <a href="/member/logout" class="member-items"><i class="fas fa-sign-out-alt"> 로그아웃</i></a>
                    <c:if test="${session_level eq 1}">
                    	<a href="/mypage/information" class="member-items"><i class="fas fa-user-cog"> 마이페이지</i></a>
                    </c:if>
                    <c:if test="${session_level eq 10}">
                    	<a href="/admin/index" class="member-items"><i class="fas fa-cog"> 관리자 페이지</i></a>
                    </c:if>
	            </div>
            </c:if>
        </div>           
    </div>
    
    <script>
	    $(".drop-down").css("display", "none");
	    $(".menu-items").click(function(){
	        $(".drop-down").stop(true).fadeToggle(500);
	    });
	</script>