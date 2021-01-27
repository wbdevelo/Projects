<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp"%>

<c:forEach var="v" items="${v }" begin="1" end="1">	
<h2 align="center">${v.writer } 작가의 다른책</h2>
</c:forEach>
	
<c:forEach var="v" items="${v }">
		<table >
			<tr>
				<td rowspan=5>
					<a href="view_e.do?uid=${v.uid}&writer=${v.writer }">
					<img src="/upload/${v.thum_file}">
					</a>
					<input type="hidden" value="${v.uid}">
				</td>
			</tr>
			<tr>
				<td>
					<table>
						<tr>
							<td>${v.title }</td>
						</tr>
						<tr>	
							<td>${v.pub_date }</td>
						</tr>
						<tr>	
							<td>${v.writer }</td>
						</tr>
						<tr>	
							<td>${v.price }</td>
						</tr>	
						<tr>
							<td>${v.content }</td>
						</tr>
					</table>
				</td>	
			</tr>
		</table>
<c:set var="number" value="${number-1 }"/> 
		</c:forEach>
	</table>
	<table width=50% border=1 align="center">
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
					<a href="view_writerBook.do?pageNum=${startPage - pageBlock }">[이전]</a>
				</c:if>
				
				<!-- 페이지 출력 -->
				<c:forEach var="i" begin="${startPage }" end="${endPage }">
					<a href="view_writerBook.do?pageNum=${i }">[${i }]</a>
				</c:forEach>
				
				<!-- 다음 링크 -->
				<c:if test="${endPage < pageCount}">
					<a href="view_writerBook.do?pageNum=${startPage + pageBlock }">[다음]</a>
				</c:if>
			</c:if>
		</td>
	</tr>
</table>





<%@ include file="/include/footer.jsp"%>