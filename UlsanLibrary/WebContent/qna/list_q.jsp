<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp"%>

<style>
	.listN-frame{
		width:100%;
		height:650px;
		position:relative;
	}
	
	.listN-content{
		width:53%;
		height:100%;
		position: absolute;
		top:0px;
		left:20%;
		display: table;
	}
	
	.listN-head{
		margin-top:10px;
		border-bottom:2px solid #515658;
		border-top:3px solid #515658;
		display: row;
		background-color:#5882fa;
		color:white;
		font-weight:bold;
		
	}
	
	.listN-body{
		border-bottom:1px solid #515658;
		cursor: pointer;
		display: row;
	}
	
	.listN-body:hover{
		border-bottom:1px solid #515658;
		cursor: pointer;
		display: row;
		background-color:#1aa3e8;
		color: white;
	}
	
	.cell{
		display: table-cell; 
		padding: 3px; 
		border-bottom:1px solid #515658;
	}
	
	.col1{
		width: 100px;
	}
	.col2{
		width: 200px;
	}
	.col3{
		width: 650px;
	}
	.col4{
		width: 160px;
	}
	.btn_write{
		 width:100px;
		 height:30px;
		 border:0px;
		 color:white;
		 background-color:#6f9dcb;
	}
</style>

<div class="listN-frame"><!-- listN-frame -->
	<div class="listN-content"><!-- listN-content -->
		<div class="listN-head">
			<span class="cell col1">No</span>
			<span class="cell col2">제목</span>
			<span class="cell col3">내용</span>
			<span class="cell col4">글쓴이</span>
		</div>
		
		<c:set var="number" value="${number }"/>
		<c:forEach var='v' items="${v}">
			<c:choose>
				<c:when test="${v.thread.length() > 1}">
					<div class="listN-body" onclick="location.href='view_q.do?uid=${v.uid}&pageNum=${pageNum}';">
						<span class="cell col1">
							<c:forEach begin="1" end="${v.thread.length()}" >
								&nbsp;
							</c:forEach>
							<img src="/img/icon_reply.gif">
						</span>
						<span class="cell col2">${v.title}</span>
						<span class="cell col3">${v.content}</span>
						<span class="cell col4">${v.name}</span>
					</div>	
					<c:set var="number" value="${number-1 }"/> 	
				</c:when>
				<c:otherwise>
					<div class="listN-body" onclick="location.href='view_q.do?uid=${v.uid}&pageNum=${pageNum}';">
						<span class="cell col1">${number }</span>
						<span class="cell col2">${v.title}</span>
						<span class="cell col3">${v.content}</span>
						<span class="cell col4">${v.name}</span>
					</div>		
					<c:set var="number" value="${number-1 }"/> 
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<div style="height:20px;"></div>
		<div align=right>
			<input type="button" class="btn_write" value="글쓰기" onclick="write_q.jsp">
		</div>
	</div>
</div>

<c:if test="${count > 0}">
	<fmt:parseNumber var="startPage" value="1" integerOnly="true"/>
	<fmt:parseNumber var="pageCount" value="${count / sizePerPage + (count % sizePerPage != 0 ? 1 : 0)}" integerOnly="true"/>
	
	<c:if test="${pageNum > pagePerBlock}">
		<fmt:parseNumber var="pageNumBlock" value="${pageNum / pagePerBlock - (pageNum % pagePerBlock == 0 ? 1 : 0)}" integerOnly="true"/>
		<fmt:parseNumber var="startPage" value="${pageNumBlock * pagePerBlock + 1}" integerOnly="true"/>
	</c:if>
	
	<fmt:parseNumber var="endPage" value="${startPage + pagePerBlock - 1}" integerOnly="true"/>
	<c:if test="${endPage > pageCount}">
		<fmt:parseNumber var="endPage" value="${pageCount}" integerOnly="true"/>
	</c:if>
	
	<c:if test="${startPage > pagePerBlock}">
		<a href="SelectQ?pageNum=${startPage - pagePerBlock}">[이전]</a>
	</c:if>
	
	<c:if test="${startPage > 1}">
		<c:forEach var="i" begin="${startPage}" end="${endPage}">
			<a href="SelectQ?pageNum=${i}">[${i}]</a>
		</c:forEach>
	</c:if>
	
	<c:if test="${endPage < pageCount}">
		<a href="SelectQ?pageNum=${startPage + pagePerBlock}">[다음]</a>
	</c:if>
</c:if>

<%@ include file="/include/footer.jsp"%>