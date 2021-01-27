<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp"%>

<%-- <%
if(session_id== null && session_level==null){
      out.print("<script>alert('로그인후 이용가능합니다.');location.href='/index.jsp' </script>"); 	
}else{
	
}
%> --%>


<style>
	.listN-frame{
		width:100%;
		height:650px;
		position:relative;
	}
	
	.listN-content{
		width:60%;
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
		background-color:#cccccc;
		
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
		<c:forEach var="v" items="${v}">
		<div class="listN-body" onclick="location.href='view_n.do?uid=${v.uid}';">
			<span class="cell col1">${number }</span>
			<span class="cell col2">${v.title}</span>
			<span class="cell col3">${v.content}</span>
			<span class="cell col4">${v.name}</span>
		</div>	
		<c:set var="number" value="${number-1 }"/> 
		</c:forEach>
		<table width=50% align="center">
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
					<a href="/notice/SelectN?pageNum=${startPage - pageBlock }">[이전]</a>
				</c:if>
				
				<!-- 페이지 출력 -->
				<c:forEach var="i" begin="${startPage }" end="${endPage }">
					<a href="/notice/SelectN?pageNum=${i }">[${i }]</a>
				</c:forEach>
				
				<!-- 다음 링크 -->
				<c:if test="${endPage < pageCount}">
					<a href="/notice/SelectN?pageNum=${startPage + pageBlock }">[다음]</a>
				</c:if>
			</c:if>
		</td>
	</tr>
</table>
<table width=50% align="center">
	<tr>
		<td>
			<c:if test="${session_level == '5' || session_level == '10' }">
				<div align=right><a href="write_n.jsp">[글쓰기]</a></div>
			</c:if>
		</td>
	</tr>
</table>
	</div>
</div>


<%@ include file="/include/footer.jsp"%>