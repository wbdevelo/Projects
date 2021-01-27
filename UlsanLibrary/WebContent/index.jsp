<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp"%>

<!-- 네이버 로그인 -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script type="text/javascript">
  var naver_id_login = new naver_id_login("cj8y24CMDmh_DVdu73HE", "http://localhost:8080/");
  // 접근 토큰 값 출력
  /* alert(naver_id_login.oauthParams.access_token); */
  // 네이버 사용자 프로필 조회
  naver_id_login.get_naver_userprofile("naverSignInCallback()");
  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
  function naverSignInCallback() {
    opener.location.href="/member/naverLogin.do?email="+naver_id_login.getProfileData('email')+"&name="+naver_id_login.getProfileData('name');
    close();
  }
</script>

<style>
	#seelect{
	}
	#seelect select{
		width:150px;
		height:70px;
		font-size:18px;
		border:0px;
		border:4px solid #7d9dfa;
	}
	#aSearch{
	}
	#aSearch input{
		width:600px;
		height:70px;
		font-size:18px;
		border-top:4px solid #7d9dfa;
		border-bottom:4px solid #7d9dfa;
		border-left:0px;
		border-right:0px;
	}
	#btn_search{
	}
	#btn_search input{
		width:100px;
		height:70px;
		font-size:18px;
		border:0px;
		background-color:#7d9dfa;
		color:white;
	}
	#oneFrame{
		width:49%;
		display:flex;
		padding-left:100px;
		padding-top:100px;
	}
	.plusA{
		font-size:30px;
		color:#d8d8d8;
		padding-left:8px;
		line-height:60px;
		text-decoration:none;
	}
	.sotitle{
		width:280px;
		font-size:18px;
		line-height:60px;
	}
	.mitjul{
		width:250px;
		height:40px;
		line-height:40px;
	}
	.jjinMitjul{
		display:flex;
		border-bottom:2px solid #d8d8d8;
		border-style:dashed;
		border-top:0px;
		border-left:0px;
		border-right:0px;
	}
	.Emitjul{
		width:400px;
		height:40px;
		line-height:40px;
	}
	.backg{
		height:500px;
		background-image:url('/img/book.jpg');
	}
</style>

<script>
	function allsearch(){
		fo = document.sk;
		
		if(!fo.allSearch.value){
			alert("검색어를 입력해주세요.");
			fo.allSearch.focus();
			return;
		}
		fo.submit();
	}
</script>


<div class="backg">
	<div style="height:25%"></div>
	<form name="sk" action="searchkind.do" method="get">
	<div style="height:49%;display:flex;">
		<div style="width:25%"></div>
		<div id="oneFrame">
			<div id="seelect">
				<select name="kind">
					<option value="gallery">소장자료</option>
					<option value="ebook">EBook</option>
				</select>
			</div>
			<div id="aSearch">
				<input id="allSearch" name="allSearch" placeholder="검색어를 입력하세요.">
			</div>
			<div id="btn_search">
				<input type="button" onclick="allsearch()" value="검색">
			</div>
		</div>
		<div style="width:25%"></div>
	</div>
	</form>
	<div style="height:25%"></div>
</div>

<div style="height:50px;"></div>

<div style="display:flex">
	<div style="width:30%"></div>
	<div style="width:39%;">
		<div style="border:1px solid #d8d8d8;display:flex;width:100%">
			<div style="width:50%;display:flex;border-right:1px solid #d8d8d8">
				<div style="width:10%"></div>
				<div style="width:79%;">
					<div style="height:60px;border-bottom:3px solid black;display:flex">
						<div class="sotitle"><b>공지사항</b></div>
						<div><a href="/notice/SelectN" class="plusA">+</a></div>
					</div>
					<c:forEach var="nv" items="${nv}">
						<div class="jjinMitjul"">
							<div class="mitjul">
								<li>
									<c:choose>
										<c:when test="${nv.title.length() > 8}">
											<a href="/notice/view_n.do?uid=${nv.uid}">
												${fn:substring(nv.title,0,8)} ...
											</a>
										</c:when>
										<c:otherwise>
											<a href="/notice/view_n.do?uid=${nv.uid}">${nv.title}</a>
										</c:otherwise>
									</c:choose>
								</li>
							</div>
							<div style="line-height:40px">${nv.name}</div>
						</div>
					</c:forEach>
					<div style="height:20px;"></div>
				</div>
				<div style="width:10%"></div>
			</div>
			<div style="width:50%;display:flex;">
				<div style="width:10%"></div>
				<div style="width:79%;">
					<div style="height:60px;border-bottom:3px solid black;display:flex">
						<div class="sotitle"><b>인기도서</b></div>
						<div><a href="/e_book/SelectE" class="plusA">+</a></div>
					</div>
					<c:forEach var="ev" items="${ev}">
						<div class="jjinMitjul" onclick="">
							<div class="Emitjul">
								<li>
									<c:choose>
										<c:when test="${ev.title.length() > 20}">
											<a href="/e_book/view_e.do?uid=${ev.uid}&writer=${ev.writer}">
												${fn:substring(ev.title,0,8)} ...
											</a>
										</c:when>
										<c:otherwise>
											<a href="/e_book/view_e.do?uid=${ev.uid}&writer=${ev.writer}">${ev.title}</a>
										</c:otherwise>
									</c:choose>
								</li>
							</div>
						</div>
					</c:forEach>
					<div style="height:20px;"></div>
				</div>
				<div style="width:10%"></div>
			</div>
		</div>
		<div></div>
	</div>
	<div style="width:30%"></div>
</div>

<%@ include file="/include/footer.jsp"%>