<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("replaceChar", "\n"); %>

<%@ include file="/include/header.jsp" %>

<style>
	.gview-frame{
		width:100%;
		height:750px;
		position:relative;
	}
	
	.gview-main{
		border-right:1px solid #cccccc;
		border-left:1px solid #cccccc;
		width:60%;
		height:100%;
		position: absolute;
		top:5px;
		left:20%;
		
	}
	
	.gv-first{
		border-bottom:1px solid #83878a;
		text-align:center;
		font-size:30px;
		width:80%;
		position: absolute;
		top:0px;
		left:10%;
	}
	
	.gv-second{
		width:80%;
		height:225px;
		position: absolute;
		top:43px;
		left:10%;
	}
	
	
	.gv-thum{
		width:200px;
		height:200px;
		text-align:center;
		position: absolute;
		top:10px;
		left:7%;
	}
	
	.gv-info{
		width:500px;
		height:200px;
		position: absolute;
		top:10px;
		left:35%;
		
	}
	
	.gv-info-content{
		width:200px;
		height:30px;
		padding-left:30px;
	}
	
	.gv-third{
		width:865px;
		height:225px;
		position: absolute;
		top:280px;
		left:10%;
		padding:20px;
	}
	
	.gv-fourth{
		width:865px;
		height:125px;
		position: absolute;
		top:550px;
		left:10%;
		padding:20px;
	}
	
	#gv-writer{
		margin-bottom:20px;
	}
	
	#gv-pub{
		position: absolute;
		top:0px;
		left:47%;
	}
	
	#gv-isbn{
		margin-bottom:20px;
	}
	
	#gv-lib{
	}
	
	#gv-daechul{
		position: absolute;
		top:105px;
		left:47%;
	}
	
	
	.gv-content{
		width:820px;;
		height:80%;
		border:1px solid #cccccc;
		padding:20px;
	}
	
	.gv-reserv{
		border-top:1px solid #cccccc;
	}
	
	.gv-rsvcount{
		position: absolute;
		top:170px;
		left:4%;
		width:150px;
	}
	
	
	.gv-rsvinfo{
		position: absolute;
		top:170px;
		left:4%;
		width:250px;
	}
	
	.gv-rsvbt {
		position: absolute;
		top:170px;
		left:80%;
	}
	
	#gv-submit{
		background-color:#1aa3e8;
		color:white;
		cursor: pointer;
	}
	
	.gv-adminmodi{
		border:1px solid #d4d4d4;
		width:150px;
		height:25px;
		text-align:center;
      	cursor: pointer;
      	position: absolute;
		top:20px;
		left:40%;
		padding-top:5px;
		background-color:#1aa3e8;
		color:white;
	}
	
	.gv-admindele{
		border:1px solid #d4d4d4;
		width:150px;
		height:25px;
		text-align:center;
      	cursor: pointer;
      	position: absolute;
		top:20px;
		left:60%;
		padding-top:5px;
		background-color:#1aa3e8;
		color:white;
	}
	
	.go-glist{
		border:1px solid #d4d4d4;
		width:150px;
		height:25px;
		text-align:center;
      	cursor: pointer;
      	position: absolute;
		top:20px;
		left:80%;
		padding-top:5px;
		background-color:#1aa3e8;
		color:white;
	}
</style>
<div class="gview-frame"><!-- gview-frame -->
	<div class="gview-main"><!-- gview-main -->
		<c:forEach var="v" items="${v}">
		<form action="reserv.do" method="post">
		<input type="hidden" name="uid" value="${v.uid}">
		<input type="hidden" name="lib_name" value="${v.lib_name}">
		<div class="gv-first"><!-- gview-first -->
			<span>제목: ${v.title}</span>
		</div>
		<div class="gv-second"><!-- gview-second -->
			<div class="gv-thum"><img src="/upload/${v.thum_file}"></div>
			<div class="gv-info">
				<div class="gv-info-content" id="gv-writer">작가: ${v.writer}</div>
				<div class="gv-info-content" id="gv-pub">출판날짜: ${v.pub_date}</div>
				<div class="gv-info-content" id="gv-isbn">ISBN: ${v.ISBN}</div>
				<div class="gv-info-content" id="gv-lib">도서관: ${v.lib_name}</div>
				<div class="gv-info-content" id="gv-daechul">대출 가능여부: ${v.daechul}</div>
			<div class="gv-reserv">	
				<c:choose>
				<c:when test="${v.rowNum == 0}">
					<div class="gv-rsvcount">예약대기 수: ${v.reserv}</div>
				</c:when>
				<c:otherwise>
					<div class="gv-rsvinfo">예약대기 수 / 대기번호 : ${v.reserv} / ${v.rowNum}</div>
				</c:otherwise>
			</c:choose>
			<div class="gv-rsvbt"><input id="gv-submit" type="submit" value="예약하기"></div>
			</div>
			</div>		
		</div>
		<div class="gv-third"><!-- gv-third -->
			${fn:replace(paramVO.content, replaceChar, "<br/>")}
			<div class="gv-content">${v.content}</div>
		</div>
		<div class="gv-fourth"><!-- gv-fourth -->
			<c:if test="${session_level == '10' || session_name == v.lib_name}">
				<div class="gv-adminmodi" onclick="location.href='modify_gallery.do?uid=${v.uid}';">
					<a>수정</a>
				</div>	
				<div class="gv-admindele"  onclick="location.href='delete_gallery.do?uid=${v.uid}';">
					<a>삭제</a>
				</div>
			</c:if>
			<c:if test="${param.loc == null}">
				<div class="go-glist" onclick="location.href='SelectG';">
					<a>목록</a>
				</div>
			</c:if>
			<c:if test="${param.loc == 'lib'}">
				<div class="go-glist" onclick="location.href='/member/myG.do?lib_name=${session_name}';">
					<a>목록</a>
				</div>
			</c:if>
		</div>
		</form>
		</c:forEach>
	</div><!-- gview-main 끝-->
</div><!-- gview-frame 끝 -->




<%@ include file="/include/footer.jsp" %>