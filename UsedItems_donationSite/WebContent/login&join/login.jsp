<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

	<style>
    
        .aa{
            border:0px;
        }
        .a_in{
            width:230px;
            height:40px;
            border: 0px;
            border-bottom: 1px solid black;
        }
        .login_button{
            width:240px;
            height:50px;
            background-color: white;
            border:1px solid black;
        }
        .gaip_button{
            width:240px;
            height:50px;
            background-color: black;
            border: 0px;
            color:white;
        }
        
    </style>
    
    <script>
    	function let_log(){
    		var fo = login_ok;
    		
    		if(!fo.id.value){
    			alert("아이디를 입력해주세요.");
    			fo.id.focus();
    			return;
    		}
    		if(!fo.password.value){
    			alert("비밀번호를 입력해주세요.");
    			fo.password.focus();
    			return;
    		}
    		if(!fo.kind.value){
    			alert("구분을 선택해주세요.");
    			fo.kind.focus();
    			return;	
    		}
    		fo.submit();
    	}
    </script>


<table width=100% height=650px>
	<tr>
		<td>
			<table class="aa" align=center>
			<form name="login_ok" action="login_ok.jsp" method="post">
				<tr>
					<td style="text-align:center;font-weight:bold;font-weight:bold;"><span style="border-bottom:2px solid gray">로그인</span></td>
					<td rowspan=8 style="width:50px;border-right:2px solid black"></td>
					<td rowspan=8 style="width:40px;"></td>
					<td style="text-align:center;font-weight:bold;"><span style="border-bottom:2px solid gray">회원가입</span></td>
				</tr>
				<tr>
					<td colspan=4 height=20px></td>
				</tr>
				<tr>
					<td style="height:20px;text-align:center; padding-bottom:5px;">
						<label><input type="radio" class="kind_input" id="kind" name="kind" value="recipient_mem">기관인</label>
						<label><input type="radio" class="kind_input" id="kind" name="kind" value="giver_mem">일반인</label>
					</td>
					<td rowspan=4 align=center>Let's join with us</td>
				</tr>
				<tr>
					<td><input id="id" name="id" placeholder="id" class="a_in"></td>
				</tr>
				<tr>
					<td style="height:10px"></td>
				</tr>
				<tr>
					<td>
						<input onkeypress="if(event.keyCode==13){let_log();return;}" type="password" id="password" name="password" maxlength="10" placeholder="password" class="a_in">
					</td>
				</tr>
				<tr>
					<td style="height:20px"></td>
				</tr>
				</form>
				<tr>
					<td align=center>
						<button class="login_button" onclick="let_log()">로그인</button>
					</td>
					<td align=center>
						<button class="gaip_button" onclick="location.href='join.jsp'">회원가입</button>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<table>
	<tr>
		<td height=45px></td>
	</tr>
</table>
<%@ include file="/include/footer.jsp" %>