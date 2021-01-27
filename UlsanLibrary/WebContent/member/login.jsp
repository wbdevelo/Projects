<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>


<script>
	function sublg(){
		fo = document.lg;
		
		if(!fo.id.value){
			alert("아이디를 입력해주세요.");
			fo.id.focus();
			return;
		}
		if(!fo.pass.value){
			alert("비밀번호를 입력해주세요.");
			fo.pass.focus();
			return;
		}
		fo.submit();
	}
</script>


<style>
	.aa{
		width:100%;
		text-align:center;
		margin-top:80px;
	}
	.b{
		width:100%;
		height:50px;
		text-align:center;
	}
	.input_st {
		width:500px;
		height:50px;
	}
	.btn_lg{
		background-color:#5882fa;
		color:white;
		font-size:20px;
		font-weight:bold;
		width:500px;
		border:0px;
		height:40px;
	}
</style>

<div style="height:500px;">
	<h2 class="aa">로그인</h2>
	
	<div style="height:50px;"></div>
	
	<form name="lg" action="login_ok.do" method="post">
	<div>
		<p class="b"><input class="input_st" type="id" name="id" id="id" placeholder="아이디"></p>
		<p class="b"><input class="input_st" type="password" name="pass" id="pass" placeholder="비밀번호"></p>
		<p class="b"><input class="btn_lg" type="button" onclick="sublg()" value="로그인"></p>
	</div>
	</form>
	
	<!-- 네이버 로그인 -->
	<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
  	<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
	
	<!-- 네이버아이디로로그인 버튼 노출 영역 -->
	<div id="naver_id_login" style="text-align:center"></div>
	<!-- //네이버아이디로로그인 버튼 노출 영역 -->
	<script type="text/javascript">
		var naver_id_login = new naver_id_login("cj8y24CMDmh_DVdu73HE", "http://localhost:8080/");
		var state = naver_id_login.getUniqState();
		naver_id_login.setButton("green", 3,40);
		naver_id_login.setDomain("http://localhost:8080/member/login.jsp");
		naver_id_login.setState(state);
		naver_id_login.setPopup();
		naver_id_login.init_naver_id_login();
	</script>
	
	
	<div style="height:50px;"></div>
	
	<div align=center>
		<a href="search_i.jsp">아이디 찾기</a> | 
		<a href="search_p.jsp">비밀번호 찾기</a> | 
		<a href="join.jsp">회원가입</a>
	</div>
</div>

<%@ include file="/include/footer.jsp" %>