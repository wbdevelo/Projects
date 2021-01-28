<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/nav.jsp"%>

<style>
	.kindof_area{
		width:99%;
		height:40px;
		font-size:15px;
		font-weight:600;
		text-align:center;
		margin:0 auto;
	}
	.kindof{
		height:100%;
		width:950px;
		display:inline-block;
		text-align:left;
	}
	.kindof li{
		float: left;
		list-style: none;
		line-height: 39px;
	}
	a{
		text-decoration: none;
	}
	a:link{
		color:black;
	}
	a:visited{
		color:black;
	}
	.info{
		border-bottom: 2px solid #dc4300;
	}
	.activ{
		margin-left:30px;
	}
	.info a{
		color: #dc4300;
	}
	.pass-container{
        /* border: 1px solid black; */
        display: flex;
        justify-content: center;
        height: 700px;
        margin-top: 50px;
    }
    .pass-container > form{
        border: 1px solid black;
        width: 80%;
        text-align: center;
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        grid-auto-rows: minmax(auto, auto);
        grid-gap: 30px;
        align-items: center;
    }
    .pass-head-text{
        grid-column: 2 / 4;
    }
    .pass-text{
        grid-column: 2 / 3;
        text-align: right;
        font-size: 20px;
    }
    .pass-input{
        
    }
    .pass-input > input{
        width: 100%;
        height: 30px;
    }
    .pass-btn{
        grid-column: 2 / 4;
    }
    .pass-btn > button{
        width: 50%;
        cursor: pointer;
        height: 50px;
        font-size: 15px;
    }
    #checkResult{
    	border:0px;
    }
</style>


<script>

	var msg = "${msg}";
	if(msg == null || msg == ""){
		
	}else{
		if(msg == "ok"){
			alert("변경이 완료되어 로그아웃 됩니다.\n다시 로그인 해주세요.");
			location.href="/";
		}else{
			alert("현재 비밀번호를 다시 확인해주세요.");
		}
	}

    function checkMemInfo(){
        var fn = passChangeForm;
        var check = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{5,10}$/; //문자, 숫자 한 개 이상으로 총 5~10자.
        
        if(!fn.password.value){
        	alert("현재 비밀번호를 입력해주세요.");
        	fn.password.focus();
        	return;
        }
        if(!fn.newPass.value){
        	alert("새 비밀번호를 입력해주세요.");
        	fn.newPass.focus();
        	return;
        }
        if(!fn.newCheck.value){
        	alert("새 비밀번호 확인을 입력해주세요.");
        	fn.newCheck.focus();
        	return;
        }
        if(!check.test(fn.newPass.value)){
			alert("비밀번호 양식을 확인해주세요.");
			fn.newPass.focus();
			return;
		}
        if(fn.password.value == fn.newPass.value){
        	alert("현재 비밀번호와 새 비밀번호가 같습니다.\n 다르게 입력해주세요.");
        	fn.newPass.focus();
        	return;
        }
        fn.submit();
    }
    
    function checkNewpass(){
    	var np = $("#newPass").val();
    	var nc = $("#newCheck").val();
    	
    	if(np == nc){
    		$("#checkResult").val("일치합니다.");
    		$("#checkResult").css("color", "blue");
    	}else{
    		$("#checkResult").val("일치하지 않습니다.");
    		$("#checkResult").css("color", "red");
    	}
    }
</script>

<!-- 메뉴 -->
<c:choose>
	<c:when test="${session_storecode != null }">
		<c:set var="code" value="${session_storecode }"/>
		<div class="kindof_area">
			<ul class="kindof">
				<li class="info"><a href="/mypage/information">회원 정보</a></li>
				<li class="activ"><a href="/mypage/activity">활동 내역</a></li>
				<li class="activ"><a href="/board/detailpage?code=${code }">내 가게 관리</a></li>
			</ul>
		</div>
	</c:when>
	<c:otherwise>
		<div class="kindof_area">
			<ul class="kindof">
				<li class="info"><a href="/mypage/information">회원 정보</a></li>
				<li class="activ"><a href="/mypage/activity">활동 내역</a></li>
			</ul>
		</div>
	</c:otherwise>
</c:choose>



<div class="pass-container">
    <form name="passChangeForm" method="post">
        <div class="pass-head-text">
            <h1>비밀번호 변경</h1>
        </div>
        <div class="pass-text">
            현재 비밀번호 : 
        </div>
        <div class="pass-input">
            <input id="password" name="password" type="password">
        </div>
        <div class="pass-text">
            새 비밀번호 : 
        </div>
        <div class="pass-input">
            <input type="password" id="newPass" name="newPass" placeholder="문자, 숫자 한 개 이상으로 총 5~10자">
        </div>
        <div class="pass-text">
            새 비밀번호 확인 : 
        </div>
        <div class="pass-input">
            <input type="password" id="newCheck" name="newCheck" onkeyup="checkNewpass()">
        </div>
        <div class="pass-input">
            <input id="checkResult">
        </div>
        <div class="pass-btn">
            <button type="button" onclick="checkMemInfo()">변 경 하 기</button>
        </div>
    </form>
</div>

<%@ include file="/WEB-INF/views/include/footer.jsp"%>