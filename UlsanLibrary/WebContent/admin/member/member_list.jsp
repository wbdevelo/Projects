<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file ="/admin/include/header.jsp"%>

<style>
	.admemlist-frame{
		width:100%;
		min-height:650px;
		position: relative;
		
	}
	
	.admemlist-main{
		width:65%;
		min-height:650px;
		position: absolute;
		left:17%;
	}
	
	.admemlist-first{
		height:20px;
		padding-top:5px; 
	}
	
	.tjdiv{
		width:100px;
		text-align: center;
	}
	
	#admemtotal{
		
	}
	
	#admemjoin{
		margin-left: 1122px;
		margin-top: -23px;
		cursor: pointer;
		background-color:#008aee; 
	}
	
	#admemjoin:hover{
		margin-left: 1122px;
		margin-top: -23px;
		cursor: pointer;
		background-color:#008aee; 
		color:white;
	}
	
	.admemlist-head{
		margin-top:10px;
		border-bottom:2px solid #515658;
		border-top:3px solid #515658;
		display: row;
		background-color:#dedede;
		text-align: center;
	}
	
	.admemlist-body{
		border-bottom:1px solid #515658;
		display: row;
		text-align: center;
	}
	
	.admemlist-body:hover{
		border-bottom:1px solid #515658;
		display: row;
		background-color:#1aa3e8;
		color: white;
	}
	
	.cell2{
		display: table-cell; 
		padding: 3px; 
		border:1px solid #515658;
	}
	.coll1{
		width: 5%;
	}
	.coll2{
		width: 15%;
	}
	.coll3{
		width: 10%;
	}
	.coll4{
		width: 13%;
	}
	.coll5{
		width: 7%;
	}
	.coll6{
		width: 17%;
	}
	.coll7{
		width: 5%;
	}
	.coll8{
		width: 120px;
	}
	.coll9{
		width: 18%;
	}
	
	
	#coll99:hover{
		width: 18%;
		background-color:#0047ca;
		color:white;
		cursor: pointer;
	}
	
	.admemlist-fourth{
		min-height:30px;
		margin-top:3px;
	}
	
	.admem-fifth{
	
	}
	
	
</style>
<h3 align="center">회원관리 페이지</h3>
<div class="admemlist-frame"><!-- admemlist-frame -->
	<div class="admemlist-main"><!-- admem-main -->
		<div class="admemlist-first"><!-- admem-first -->
			<div class="tjdiv" id="admemtotal">Total : ${count }</div>
			<div class="tjdiv" id="admemjoin" onclick="location.href='member_join.jsp';">
				회원가입
			</div>
		</div>
		<div class="admemlist-head"><!-- admem-second -->
			<span class="cell2 coll1">No</span>
			<span class="cell2 coll2">이름</span>
			<span class="cell2 coll3">아이디</span>
			<span class="cell2 coll4">비밀번호</span>
			<span class="cell2 coll5">나이</span>
			<span class="cell2 coll6">메일</span>
			<span class="cell2 coll7">레벨</span>
			<span class="cell2 coll8">가입/탈퇴여부</span>
			<span class="cell2 coll9">수정/삭제</span>
		</div>
	<c:set var="number" value="${number }"/>
	<c:forEach var="list" items="${v }">
		<div class="admemlist-body"><!-- admem-third -->
			<span class="cell2 coll1">${number }</span>
			<span class="cell2 coll2">${list.name }</span>
			<span class="cell2 coll3">${list.id }</span>
			<span class="cell2 coll4">${list.pass }</span>
			<span class="cell2 coll5">${list.age }</span>
			<span class="cell2 coll6">${list.email }</span>
			<span class="cell2 coll7">${list.level }</span>
			<span class="cell2 coll8">${list.state }</span>
			<span class="cell2 coll9" id="coll99" onclick="location.href='member_modify.do?id=${list.id }';">수정</span>
		</div>
	<c:set var="number" value="${number-1 }"/> 
	</c:forEach>
		<div class="admemlist-fourth"><!-- admem-fourth -->
			<table width=30% border=0 align="center">
					<tr>
						<td align="center">
						<!-- 페이징 처리 -->		
						<c:if test="${count  > 0}">
							<c:set var="pageCount" value="${count / pageSize + (count % pageSize == 0 ? 0 : 1) }" />
							<fmt:parseNumber var="pageCount" value="${pageCount }" integerOnly="true"/>
							
							<!-- 2개의 변수 초기화 -->
							<c:set var="startPage" value="${1 }"/>
							<c:set var="pageBlock" value="${5 }"/>
							
							<!-- 다음 페이지 블럭이 존재 할 경우 startPage 값 변경 부분 -->
							<c:if test="${pageNum > pageBlock }">
								<!-- 결과 값을 정수형으로 리턴 받아야 하기 때문에 fmt 처리 -->
								<fmt:parseNumber var="result" value="${pageNum / pageBlock - (pageNum % pageBlock == 0 ? 1 : 0) }" integerOnly="true"/>
								<c:set var="startPage" value="${result * pageBlock + 1 }"/>
							</c:if>
							
							<!-- endPage 설정 -->
							<c:set var="endPage" value="${startPage + pageBlock - 1 }"/>
							<c:if test="${endPage > pageCount }">
								<c:set var="endPage" value="${pageCount }"/>
							</c:if>
							
							<!-- 이전 링크 -->
							<c:if test="${startPage > pageBlock }">
								<a href="member_list.do?pageNum=${startPage - pageBlock }">[이전]</a>
							</c:if>
							
							<!-- 페이지 출력 -->
							<c:forEach var="i" begin="${startPage }" end="${endPage }">
								<a href="member_list.do?pageNum=${i }">[${i }]</a>
							</c:forEach>
							
							<!-- 다음 링크 -->
							<c:if test="${endPage < pageCount}">
								<a href="member_list.do?pageNum=${startPage + pageBlock }">[다음]</a>
							</c:if>
						</c:if>
					</td>
				</tr>
			</table>
		</div>
		<div class="admem-fifth"><!-- admem-fifth -->
			<table align="center">
				<form action="member_list.do" method="post">
					<tr>
						<td align="center" width=20%>
							<input name="search" size="40" >
							<input type="image" src="/img/search.png">
						</td>
					</tr>
				</form>
			</table>
		</div>
	</div>
</div>


	

<%@ include file="/admin/include/footer.jsp" %>
