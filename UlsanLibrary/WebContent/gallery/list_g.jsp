<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp"%>

<style>
.glist-frame{
	width:100%;
	height:2000px;
	position:relative;
}

.glist-main{
	border-right:1px solid #d4d4d4;
	border-left:1px solid #d4d4d4;
	width:60%;
	height:97%;
	position:absolute;
	left:20%;
}

.g-first{
	width:99%;
	height:5%;
}

 .g-check{
 	margin-top:30px;
 	width:87%;
 	position:absolute;
 	top:6px;
	left:60px;
	border-bottom:1px solid #d4d4d4;
	padding-bottom:30px;
	padding-left:50px;
 }
 
 .g-book{
 	border-bottom:1px solid #d4d4d4;
 	width:95%;
 	margin-top:20px;
 	margin-bottom:5px;
 	margin-left:25px;
 	cursor: pointer;
 	position: relative;
 	height:230px;
 }
 
 .g-book:hover{
 	border-bottom:1px solid #d4d4d4;
 	width:95%;
 	margin-top:20px;
 	margin-bottom:5px;
 	margin-left:25px;
 	cursor: pointer;
 	position: relative;
 	height:230px;
 	background-color: #cccccc;
 }
 
 .G-writebt1{
	width:4%;
	height:1%;
	position:absolute;
	top:98%;
	left:75%;
	text-align:center;
	cursor:pointer;
	background-color:#40bfff;
	color:#83878a;
 }
 
 .G-writebt1:hover{
	width:4%;
	height:1%;
	position:absolute;
	top:98%;
	left:75%;
	text-align:center;
	cursor:pointer;
	background-color:#0074c8;
	color:#ffffff;
 }
 
 .G-writebt2{
	width:4%;
	height:1%;
	position:absolute;
	top:0%;
	left:76%;
	text-align:center;
	cursor:pointer;
	background-color:#40bfff;
	color:#83878a;
 }
 
 .G-writebt2:hover{
	width:4%;
	height:1%;
	position:absolute;
	top:0%;
	left:76%;
	text-align:center;
	cursor:pointer;
	background-color:#0074c8;
	color:#ffffff;
 }
 
 
 .g-imgbox{
 	width:140px;
 	height:200px;
 	position: absolute;
 	top:0px;
 	left:4%;
 }
 
 
 .g-img{
 	width:140px;
 	height:200px;
 }
 
 .gbook-info{
 	height:130px;
 	width:840px;
 	position: absolute;
 	top:0px;
 	left:18%;
 }
 
 
 #glist-title {
 	width:500px;
 	font-size:24px;
 	margin-bottom:5px;
 }
 #glist-writer {
 	width:180px;
 	margin-bottom:5px;
 }
 
 #glist-pub_date {
 	width:140px;
 	position: absolute;
 	top:34px;
 	left:210px;
 	color:#999999;
 	margin-top:5px;
 }
 
 #glist-ISBN {
 	width:200px;
 	margin-bottom:5px;
 }
 #glist-lib_name {
 	width:300px;
 	margin-bottom:5px;
 }

 #glist-content {
 	width:740px;
 	height:68px;
 }
 
 #glist-daechul {
 	width:140px;
 	height:40px;
 	line-height:40px;
 	position: absolute;
 	top:80px;
 	left:83%;
 	font-size:18px;
 }

  .gbook-content{
 	height:70px;
 	width:840px;
 	position: absolute;
 	top:131px;
 	left:18%;
 }
</style>


<div class="glist-frame"> <!-- gallery-list-frame -->
	<div class="glist-main"><!-- gallery-list-main  -->
		<div class="g-first"><!-- gallery-list-first-content -->
			<form name="sg" action="SelectG" method="get">
			<input type="hidden" name="a" value="yes">
				<div class="g-check">
					<label><input type="checkbox" name="lib" value="울산남부도서관" <c:forEach var="lv" items="${lib_value}"><c:if test="${lv eq '울산남부도서관'}">checked</c:if></c:forEach>>울산 남부 도서관</label>
					<label><input type="checkbox" name="lib" value="울산중부도서관" <c:forEach var="lv" items="${lib_value}"><c:if test="${lv eq '울산중부도서관'}">checked</c:if></c:forEach>>울산 중부 도서관</label>
					<label><input type="checkbox" name="lib" value="울산동부도서관" <c:forEach var="lv" items="${lib_value}"><c:if test="${lv eq '울산동부도서관'}">checked</c:if></c:forEach>>울산 동부 도서관</label>
					<label><input type="checkbox" name="lib" value="울산북구도서관" <c:forEach var="lv" items="${lib_value}"><c:if test="${lv eq '울산북구도서관'}">checked</c:if></c:forEach>>울산 북구 도서관</label>
					<label><input type="checkbox" name="lib" value="울주군도서관" <c:forEach var="lv" items="${lib_value}"><c:if test="${lv eq '울주군도서관'}">checked</c:if></c:forEach>>울주군 도서관</label>
					<input name="search">
					<input type="image" src="/img/search.png">
				</div>
			</form>
		</div>	
			<c:choose>
				<c:when test="${search_count == 0}">
					<div align=center>
						<img src="/img/no.png"><br>
						검색 결과가 없습니다.
					</div>
				</c:when>
				<c:otherwise>
					<c:forEach var="v" items="${v}">
						<div class="g-book" onclick="location.href='/gallery/view_g.do?uid=${v.uid}&title=${v.title}&lib_name=${v.lib_name}';"><!-- gallery-book 시작-->
							<div class="g-imgbox"><!-- gallery-thum-file -->
								<c:choose>
									<c:when test="${v.thum_file == null || v.thum_file == ''}">
										<img class="g-img" src="/img/image.png">
									</c:when>
									<c:otherwise>
										<img class="g-img" src="/upload/${v.thum_file}">
									</c:otherwise>
								</c:choose>
							</div>
							<div class="gbook-info">
								<div id="glist-title">${v.title}</div>	
								<div id="glist-writer">작가: ${v.writer}</div>
								<div id="glist-pub_date">출판일: ${v.pub_date}</div>	
								<div id="glist-ISBN">ISBN : ${v.ISBN}</div>	
								<div id="glist-lib_name">소장 도서관 : ${v.lib_name}</div>	
								<div id="glist-daechul"><span>대출여부: ${v.daechul}</span></div>
							</div>
							<div class="gbook-content">
								<div id="glist-content">${v.content}</div>
							</div>	
							
						</div><!-- gallery-book 끝-->
					</c:forEach>
				</c:otherwise>
			</c:choose>
	</div>
	<c:if test="${session_level == '5' || session_level == '10'}">
		<div class="G-writebt1" onclick="location.href='write_g.jsp'">
			글쓰기
		</div>	
	</c:if>
	
	<c:if test="${session_level == '5' || session_level == '10'}">
		<div class="G-writebt2" onclick="location.href='write_g.jsp'">
			글쓰기
		</div>		
	</c:if>
	
	
</div>


<%@ include file="/include/footer.jsp"%>