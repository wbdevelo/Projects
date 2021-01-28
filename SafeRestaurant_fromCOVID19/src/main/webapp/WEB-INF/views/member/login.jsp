<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/nav.jsp"%>

<style>
	.login-container{
        display: flex;
        justify-content: center;
        align-items: center;
        text-align: center;
        height: 700px;
    }
    .login-logo{
    
    }
    .login-items{
        
    }
    .login-items > input{
        width: 500px;
        height: 50px;
        margin-top: 30px;
    }
    .login-btn{
        
    }
    .login-btn > button{
        width: 500px;
        height: 50px;
        margin-top: 30px;
        cursor: pointer;
    }
    .login-search{
        display: flex;
        justify-content: space-between;
        margin-top: 30px;
    }
    .id-search{
        width: 50%; 
    }
    .pw-search{
        width: 50%;
    }
    .search-btn{
        width: 100%;
        height: 50px;
        cursor: pointer;
    }
    .selectLogin{
    	display: flex;
    	justify-content: space-around;
    	font-size: 20px;
    }
</style>

<div class="login-container">
    <form id="memLogin" name="memLogin" method="post">
        <div class="login-logo">
        	<a href="/" style="text-decoration: none; color:black;">
	            <img alt="" src="/resources/img/logo2.png" style="max-width: 100%; max-height: 200px;">
            </a>
        </div>
        <div class="selectLogin">
            <label style="cursor: pointer;"><input type="radio" name="loginselect" id="memberlogin" checked="checked" onclick="changLogin(1)">일반회원</label>
            <label style="cursor: pointer;"><input type="radio" name="loginselect" onclick="changLogin(2)">사업자</label>
        </div>
        <div class="login-items">
            <input type="text" name="id" id="userId" placeholder="아 이 디" onkeyup="enter()">
        </div>
        <div class="login-items">
            <input type="password" name="password" id="userPw" placeholder="비 밀 번 호" onkeyup="enter()">
        </div>
        <div class="login-btn">
            <button type="button" onclick="bLog()">로 그 인</button>
        </div>
        <div class="login-search">
            <div class="id-search">
                <button class="search-btn" type="button" onclick="location.href='/member/searchid'">아이디 찾기</button>
            </div>
            <div style="width: 5%;"></div>
            <div class="pw-search">
                <button class="search-btn" type="button" onclick="location.href='/member/searchpw'">비밀번호 찾기</button>
            </div>
        </div>
        <div class="login-btn">
            <button type="button" onclick="AnsimStoreChk()">내 가게 안심식당 등록 확인</button>
        </div>
    </form>
    
    <!-- 사업자 로그인  -->
    <form id="stoLogin" name="stoLogin" method="post" action="/member/stoLogin">
        <div class="login-logo">
        	<a href="/" style="text-decoration: none; color:black;">
	            <img alt="" src="/resources/img/logo2.png" style="max-width: 100%; max-height: 200px;">
            </a>
        </div>
        <div class="selectLogin">
            <label style="cursor: pointer;"><input type="radio" name="loginselect" onclick="changLogin(1)">일반회원</label>
            <label style="cursor: pointer;"><input type="radio" name="loginselect" id="storelogin" checked="checked" onclick="changLogin(2)">사업자</label>
        </div>
        <div class="login-items">
            <input type="text" name="storecode" id="stocode" placeholder="가 게 코 드" >
        </div>
        <div class="login-items">
            <input type="text" name="id" placeholder="아 이 디">
        </div>
        <div class="login-items">
            <input type="password" name="password" placeholder="비 밀 번 호">
        </div>
        <div class="login-btn">
            <button type="button" onclick="sLog()">로 그 인</button>
        </div>
        <div class="login-search">
            <div class="id-search">
                <button class="search-btn" type="button" onclick="location.href='/member/searchid'">아이디 찾기</button>
            </div>
            <div style="width: 5%;"></div>
            <div class="pw-search">
                <button class="search-btn" type="button" onclick="location.href='/member/searchpw'">비밀번호 찾기</button>
            </div>
        </div>
        <div class="login-btn">
            <button type="button" onclick="AnsimStoreChk()">내 가게 안심식당 등록 확인</button>
        </div>
    </form>
</div>


<script>
	$(function(){
		$('#stoLogin').hide();
	});
	
	function changLogin(num){
		var lomem = document.getElementById('memberlogin');
		var stmem = document.getElementById('storelogin');
		
		if(num == 1){
			
			lomem.checked = true;
			
			$('#memLogin').show();
			$('#stoLogin').hide();
		}
		if(num == 2){

			stmem.checked = true;
			
			$('#memLogin').hide();
			$('#stoLogin').show();
		}
		
	}
	
	var msg = "${msg}";
	
	if(msg == null || msg == ""){
		
	}else{
		
		if(msg == "no"){
			alert("아이디와 비밀번호를 확인해주세요.");
		} else if(msg == "sno"){
			alert("가게코드 및 아이디와 비밀번호를 확인해주세요.");
		}
		
	}
	function enter(){
		if(window.event.keyCode == 13){
			bLog();
		}	
	}
	function bLog(){
		var fn = memLogin;
		
		if(!fn.userId.value){
			alert("아이디를 입력해주세요.");
			fn.userId.focus();
			return;
		}
		if(!fn.password.value){
			alert("비밀번호를 입력해주세요.");
			fn.password.focus();
			return;
		}
		fn.submit();
	}
	
	function sLog(){
		var fn = stoLogin;

		if(!fn.stocode.value){
			alert("가게코드를 입력해주세요.");
			fn.stocode.focus();
			return;
		}
		if(!fn.id.value){
			alert("아이디를 입력해주세요.");
			fn.userId.focus();
			return;
		}
		if(!fn.password.value){
			alert("비밀번호를 입력해주세요.");
			fn.password.focus();
			return;
		}
		fn.submit();
	}
	
	
	function AnsimStoreChk(){
		window.open("/member/chkStoreAnsim","","top=100, left=600, width=500px, height=450px")
	}
	
</script>

<%@ include file="/WEB-INF/views/include/footer.jsp"%>