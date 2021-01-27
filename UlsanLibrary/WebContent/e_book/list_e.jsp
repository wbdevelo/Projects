<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/include/header.jsp"%>


<style>
	.bsellerTitle{
		width:90%;
		text-align:center;
		font-size:30px;
		font-weight:bold;
		height:50px;
	}
	.bsellerFrame{
		display:flex;
		justify-content:space-around;
	}
	#ca ul {
		padding:0; 
		margin:0;
	}
	#ca ul li{
		margin:0;
		list-style:none;
		height:40px;
		border-top:1px solid #d8d8d8;
	}
	#ca a{
		display:block;
		text-decoration:none;
		line-height:40px;
	}
	.eb{
		background-color:#5882FA;
		color:white;
		height:34px;
		vertical-align:center;
		font-size:30px;
	}
	#ca li a{
		color:#5882FA;
		font-weight:bold;
	}
	#ca li a:hover{
		color:white;
		background-color:#5882FA;
	}
	.rank{
		background-color:#7d9dfa;
		color:white;
		font-size:30px;
		font-weight:bold;
		width:40px;
		height:40px;
		text-align:center;
		vertical-align:middle;
	}
	.btn_cart{
		width:100px;
		height:30px;
		background-color:#8777e3;
		color:white;
		border:0px;
	}
	.btn_ba{
		width:100px;
		height:30px;
		background-color:#60a9f2;
		color:white;
		border:0px;
	}
	.btn_write{
		 width:100px;
		 height:30px;
		 border:0px;
		 color:white;
		 background-color:#6f9dcb;
	}
	
	#go-eview{
		cursor: pointer;
	}
	
	#go-eview:hover{
		cursor: pointer;
		background-color: #dedede;
		
	}
</style>

<!-- 카테고리 -->
<div style="width:9%;position:fixed">
	<div id="ca" style="width:100%;border:2px solid #d8d8d8;">
		<ul>
			<li class="eb">eBook</li>
			<li><a href="SelectE">전체</a></li>
			<li><a href="SelectE?category=domestic">국내소설</a></li>
			<li><a href="SelectE?category=foreign">외국소설</a></li>
			<li><a href="SelectE?category=none">비소설</a></li>
			<li><a href="SelectE?category=poem">시</a></li>
			<li><a href="SelectE?category=economy">경제경영</a></li>
			<li><a href="SelectE?category=child">어린이</a></li>
			<li><a href="SelectE?category=science">인문과학</a></li>
			<li><a href="SelectE?category=language">외국어</a></li>
			<li><a href="SelectE?category=IT">IT</a></li>
			<li><a href="SelectE?category=study">수험</a></li>
		</ul>
	</div>
</div>

<div style="width:100%;">
	<div style="display:flex;">
		<div style="width:450px;"></div>
		<div style="width:1500px;">
			<c:choose>
				<c:when test="${category eq 'domestic'}">
					<h2 style="color:#5882FA; border-bottom:1px solid #d8d8d8;height:50px;">국내소설</h2>
				</c:when>
				<c:when test="${category eq 'foreign'}">
					<h2 style="color:#5882FA; border-bottom:1px solid #d8d8d8;">외국소설</h2>
				</c:when>
				<c:when test="${category eq 'none'}">
					<h2 style="color:#5882FA; border-bottom:1px solid #d8d8d8;">비소설</h2>
				</c:when>
				<c:when test="${category eq 'poem'}">
					<h2 style="color:#5882FA; border-bottom:1px solid #d8d8d8;">시</h2>
				</c:when>
				<c:when test="${category eq 'economy'}">
					<h2 style="color:#5882FA; border-bottom:1px solid #d8d8d8;">경제경영</h2>
				</c:when>
				<c:when test="${category eq 'child'}">
					<h2 style="color:#5882FA; border-bottom:1px solid #d8d8d8;">어린이</h2>
				</c:when>
				<c:when test="${category eq 'science'}">
					<h2 style="color:#5882FA; border-bottom:1px solid #d8d8d8;">인문과학</h2>
				</c:when>
				<c:when test="${category eq 'language'}">
					<h2 style="color:#5882FA; border-bottom:1px solid #d8d8d8;">외국어</h2>
				</c:when>
				<c:when test="${category eq 'IT'}">
					<h2 style="color:#5882FA; border-bottom:1px solid #d8d8d8;">IT</h2>
				</c:when>
				<c:when test="${category eq 'study'}">
					<h2 style="color:#5882FA; border-bottom:1px solid #d8d8d8;">수험</h2>
				</c:when>
				<c:otherwise>
					<h2 style="border:0px"></h2>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	
	<c:if test="${category == null || category == ''}">
		<div class="bsellerTitle">Best Seller</div>
		<div style="width:100%;display:flex;">
		<div style="width:10%"></div>
		<div style="border:2px solid #d8d8d8;width:70%">
			<div style="height:20px;"></div>
			<div class="bsellerFrame">
				<fmt:parseNumber var="rank" value="1"/>
				<c:forEach var="ev" items="${ev}">
					<div style="display:flex;">
						<div class="rank">${rank}</div>
						<div style="width:20px;"></div>
						<div>
							<a href="view_e.do?uid=${ev.uid}&writer=${ev.writer}"><img src="/upload/${ev.thum_file}"></a><br>
							제목: ${ev.title}<br>
							작가: ${fn:substring(ev.writer,0,15)} <c:if test="${ev.writer.length() > 15}">...</c:if>
						</div>
					</div>
				<fmt:parseNumber var="rank" value="${rank+1}"/>
				</c:forEach>
			</div>
		</div>
		<div style="width:10%"></div>
		</div>
	</c:if>
	
	<div style="width:100%; height:50px;"></div>
	
	<form action="SelectE" method="post">
		<div style="display:flex;">
			<input type="hidden" name="category" value="${category}">
			<div style="width:750px;"></div>
			<div style="display:flex;">
				<div style="width:402px;border:4px solid #5882FA">
					<input style="height:30px;width:400px;border:0px" name="search" value="${search}">
				</div>
				<div style="width:50px;text-align:center;background-color:#5882FA">
					<input type="image" src="/img/searchtab.png">
				</div>
			</div>
		</div>
	</form>
	
	<c:if test="${session_level == '5' || session_level == '10'}">
		<div style="width:74%;text-align:right">
			<div align=right>
				<input class="btn_write" type="button" onclick="location.href='write_e.jsp'" value="글쓰기">
			</div>
		</div>
	</c:if>
	
	<div style="font-size:13px;display:flex;">
		<div style="width:850px"></div>
		<div style="width:300px;">
			<a href="SelectE?category=${category}">기본순</a> | 
			<a href="SelectE?category=${category}&ord=sell">판매량순</a> |  
			<a href="SelectE?category=${category}&ord=priceL">최저가순</a> | 
			<a href="SelectE?category=${category}&ord=priceH">최고가순</a>
		</div>
	</div>
	
	<div style="width:100%; height:50px;"></div>
	
	<table width=1000px style="margin-left:450px;">
	<c:forEach var="v" items="${v}">
		<tr>
			<td >
				<table width=100%>
					<tr>
					<td width=25%>
						<a href="view_e.do?uid=${v.uid}&writer=${v.writer}&category=${category}">
							<img src="/upload/${v.thum_file}">
						</a>
					</td>
					<td  width=65% >
						<table width=100% id="go-eview" onclick="location.href='view_e.do?uid=${v.uid}&writer=${v.writer}&category=${category}';">
							<tr>
								<td style="font-size:18px;font-weight:bold;">
									<a>
										제목: ${v.title}
									</a>
								</td>
							</tr>
							<tr>
								<td style="font-size:15px;color:#999999">
									<span style="color:black;">
										작가: ${fn:substring(v.writer,0,15)}
										<c:if test="${v.writer.length() > 15}">...</c:if>
									</span> | 출판일: ${v.pub_date}
								</td>
							</tr>
							<tr>
								<td style="font-size:15px;">
									가격: <span style="font-size:20px;font-weight:bold;">${v.price}</span>원&nbsp;&nbsp;
									<img src="/img/coins.png"> ${v.point}p
								</td>
							</tr>
						</table>
					</td>
					<td>
						<table width=100% height=100%>
							<tr>
								<td height=40px>
									<c:if test="${session_id != null}">
										<c:forEach var="jv" items="${jv}">
											<c:if test="${v.uid == jv.title_uid}">
												<c:choose>
													<c:when test="${jv.jjim_v == '0'}">
														<a href="jjim.do?id=${jv.id}&heart=1&title_uid=${jv.title_uid}&category=${category}">
															<img src="/img/heart.png">
														</a>
													</c:when>
													<c:otherwise>
														<a href="jjim.do?id=${jv.id}&heart=0&title_uid=${jv.title_uid}&category=${category}">
															<img src="/img/full_heart.png">
														</a>
													</c:otherwise>
												</c:choose>
											</c:if>
										</c:forEach>
									</c:if>
								</td>
							</tr>
							<tr>
								<td height=40px>
									<button class="btn_cart" onclick="location.href='/cart/cartSI?id=${session_id}&guest=${session_guest}&uid=${v.uid}'">
										장바구니
									</button>
								</td>
							</tr>
							<tr>
								<td height=40px>
									<button class="btn_ba" onclick="location.href='/e_book/BuyPass.do?uid=${v.uid}&guest=${session_guest}&id=${session_id}'">
										바로구매
									</button>
								</td>
							</tr>
						</table>
					</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height=50px;><hr></td>
		</tr>
	</c:forEach>
	</table>
	
	<div>
		<c:if test="${count > 0}">
			
			<fmt:parseNumber var="pageCount" value="${count / pagePerSize + (count % pagePerSize != 0 ? 1 : 0)}" integerOnly="true"/>
			<c:set var="startPage" value="1"/>
			
			<c:if test="${pageNum > pagePerBlock}">
				<fmt:parseNumber var="pageNumBlock" value="${pageNum / pagePerBlock - (pageNum % pagePerBlock == 0 ? 1 : 0)}" integerOnly="true"/>
				<fmt:parseNumber var="startPage" value="${pageNumBlock * pagePerBlock + 1}" integerOnly="true"/>
			</c:if>
			
			<fmt:parseNumber var="endPage" value="${startPage + pagePerBlock - 1}" integerOnly="true"/>
			<c:if test="${endPage > pageCount}">
				<fmt:parseNumber var="endPage" value="${pageCount}" integerOnly="true"/>
			</c:if>
			
			<c:if test="${startPage > pagePerBlock}">
				<a href="SelectE?pageNum=${startPage - pagePerBlock}">[이전]</a>
			</c:if>
			
			<c:if test="${startPage > 1}">
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					<a href="SelectE?pageNum=${i}">[${i}]</a>
				</c:forEach>
			</c:if>
			
			<c:if test="${endPage < pageCount}">
				<a href="SelectE?pageNum=${endPage + 1}">[다음]</a>
			</c:if>
		</c:if>
	</div>
</div>

<div style="border:1px solid #5882fa; width:350px;position:fixed;top:350;right:30;">
	<div style="height:50px;background-color:#5882fa;line-height:50px;text-align:center;color:white">오늘 본 상품</div>
	<c:choose>
		<c:when test="${rev == '[]'}">
			<div style="height:20px;"></div>
			<div style="text-align:center">
				<img src="/img/no2.png"><br>
				오늘 보신 상품이 없습니다.
			</div>
			<div style="height:20px;"></div>
		</c:when>
		<c:otherwise>
			<table>
				<c:forEach var="rev" items="${rev}">
					<tr>
						<td height=10px colspan=3><hr style="background-color:#d8d8d8;"></td>
					</tr>
					<tr>
						<td style="width:100px;height:130px;"><img style="width:100px;height:150px;" src="/upload/${rev.thum_file}"></td>
						<td width=20px></td>
						<td>${rev.title}</td>
					</tr>
					<tr>
						<td height=10px colspan=3></td>
					</tr>
				</c:forEach>
			</table>
		</c:otherwise>
	</c:choose>
</div>

<%@ include file="/include/footer.jsp"%>