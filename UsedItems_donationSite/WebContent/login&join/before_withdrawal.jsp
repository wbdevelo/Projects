<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>

<style>
	input{
		border:1px solid gray;
		height:25px;
		width:200px;
	}
	.out_table{
		width:50%;
		height:400px;
		border-top:1px solid gray;
		border-bottom:1px solid gray;
	}
	.guelja{
		width:40%;
		font-size:12px;
		font-weight:bold;
		text-align:center;
		vertical-align:bottom;
	}
	.juso{
		border:1px solid gray;
		height:25px;
		background-color:#fbf7f2;
		width:65px;
		font-size:12px;
	}
	.gaip{
		background-color:#fbf7f2;
		border:1px solid black;
		width:240px;
        height:50px;
	}
	.ab{
		text-align:center;
		vertical-align:bottom;
	}
</style>

<script>
	function go_(){
		var fo = goto_;
		
		if(!fo.pass.value){
			alert("비밀번호를 입력해주세요.");
			fo.pass.focus();
			return;
		}
		if(!fo.pass_ok.value){
			alert("비밀번호 확인란을 입력해주세요.");
			fo.pass_ok.focus();
			return;
		}
		if(fo.pass.value==fo.session_pass.value && fo.pass_ok.value==fo.session_pass.value){
			location.href="info_change.jsp";
		}else{
			alert("비밀번호를 확인해주세요.");
			fo.pass_ok.focus();
			return;
		}
		fo.submit();
	}
</script>

<br><br><br><br>
<table class="out_table" align=center>
<form name="goto_" action="withdrawal.jsp" method="post">
	<tr>
		<td>
			<table width=80% height=100% align=center>
				<tr>
					<td class="guelja">비밀번호</td>
					<td class="ab"><input id="pass" name="pass" type="password" maxlength="10" ></td>
				</tr>
				<tr>
					<td class="guelja">비밀번호 확인</td>
					<td class="ab"><input onkeypress="if(event.keyCode==13){go_();return;}" id="pass_ok" name="pass_ok" type="password" ></td>
				</tr>
				<tr>
					<td colspan=2>
						<input type="hidden" id="session_pass" name="session_pass" value=<%=session_pass%>>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</form>
</table>
<br>
<table align=center height=200px>
	<tr>
		<td colspan=2>
			<button class="gaip" onclick="go_()">확인</button>
		</td>
	</tr>
</table>
<%@ include file="/include/footer.jsp" %>