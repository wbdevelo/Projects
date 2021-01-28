<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	.container{
		border:1px solid black;
		width: 100%;
		display: flex;
		flex-direction: column;
		height: 400px;
		text-align: center;
	}
	.container > form{
		height: 200px;
		margin-top: 50px;
	}
	.newpw-head-text{
		
	}
	.newpw{
		display: flex;
		justify-content: center;
		align-items: center;
		height: 30%;
	}
	.newpw-text{
		width: 50%;
		text-align: right;
	}
	.newpw-input{
		width: 50%;
	}
	.newpw-input > input{
		width: 80%;
		height: 30px;
	}
	.newpw-btn{
		
	}
	.newpw-btn > button{
		height: 50px;
		width: 50%;
		cursor: pointer;
	}
</style>
<body>
	<div class="container">
		<form method="post" name="pwnew">
			<div class="newpw-head-text">
				<h3>새 비밀번호</h3>
			</div>
			<div class="newpw">
				<div class="newpw-text">
					새 비밀번호 입력 :
				</div>
				<div class="newpw-input" >
					<input name="password" type="password">
				</div> 
			</div>
			<div class="newpw">
				<div class="newpw-text">
					새 비밀번호 입력 확인:
				</div>
				<div class="newpw-input">
					<input name="passwordchk" type="password">
				</div> 
			</div>
		</form>
		<div class="newpw-btn">
			<button onclick="updateNewPw()">수정하기</button>
		</div>
	</div>
</body>

<script>
	function updateNewPw() {
		var uppw = pwnew;
		
		if(uppw.password.value == ""){
			alert('새로운 비밀번호를 입력해주시기 바랍니다.');
			uppw.password.foucs();
			return;
		} else if(uppw.password.value != uppw.passwordchk.value){
			alert('비밀번호가 일치하지 않습니다.');
			uppw.passwordchk.foucs();
			return;
		}
		uppw.submit();
	}
	
	var msg = "${msg}";
	if(msg == "ok"){
		alert("변경 되었습니다.");
		window.close();
	}
</script>
</html>