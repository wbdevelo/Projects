<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>

<style>
	input{
		border:1px solid gray;
		height:20px;
		width:160px;
	}
	.out_table{
		width:50%;
		height:500px;
		border-top:1px solid gray;
		border-bottom:1px solid gray;
	}
	.guelja{
		width:35%;
		font-size:12px;
		font-weight:bold;
	}
	.juso{
		border:1px solid gray;
		height:25px;
		background-color:#fbf7f2;
		width:65px;
		font-size:12px;
	}
	.gaip{
		background-color:white;
		border:2px solid black;
		width:240px;
        height:50px;
	}
	.email_input{
		height:23px;
		width:100px;
	}
	.aa{
		font-size:12px;
		font-weight:bold;
		cursor:pointer;
	}
	 .hwackin{	
		border:0px;
		font-size:15px;
	} 
	.kind_input{
		width:15px;
		height:13px;
	}
</style>

<script> //빈칸 있을 경우 알림.
	function gaip_do(){
		var fo = information;
		
		if(!fo.kind.value){
			alert("구분을 선택해주세요.");
			fo.kind.focus();
			return;
		}
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
		if(fo.pass.value != fo.pass_ok.value){
			alert("비밀번호를 다시 확인해주세요.");
			fo.pass_ok.focus();
			return;
		}
		if(!fo.email.value){
			alert("이메일을 입력해주세요.");
			fo.email.focus();
			return;
		}
		if(!fo.email_address.value){
			alert("이메일 입력을 완료해주세요.");
			fo.email_address.focus();
			return;
		}
		if(!fo.phone.value){
			alert("휴대폰 번호를 입력해주세요.");
			fo.phone.focus();
			return;
		}
		if(!fo.zip1.value){
			alert("주소를 입력해주세요.");
			fo.chatki.focus();
			return;
		}
		if(!fo.check_same.value){
			alert("아이디 중복확인을 해주세요.");
			return;
		}
		if(fo.check_same.value == "사용 불가"){
			alert("아이디를 다시 설정해주세요.");
			fo.id.focus();
			return;
		}
		if(!fo.check_nick.value){
			alert("닉네임 중복확인을 해주세요.");
			return;
		}
		if(fo.check_nick.value == "사용 불가"){
			alert("닉네임을 다시 설정해주세요.");
			fo.nickname.focus();
			return;
		}
		
		fo.submit();	
	}
	
	function id_check(){
		var id2 = information.id.value;
		var kind2 = information.kind.value;
		
		if(!kind2){
			alert("구분을 선택해주세요.");
			information.kind.focus();
			return;
		}
		if(!id2){
			alert("아이디를 먼저 입력해주세요.");
			information.id.focus();
			return;
		}
		
		window.open("id_check.jsp?id_value="+id2+"&kind_value=" + kind2 + "","hiddenframe1","width=300,height=200");
	}
	
	function nickname_check(){
		var nick2 = information.nickname.value;
		var kind2 = information.kind.value;
		
		if(!kind2){
			alert("구분을 선택해주세요.");
			information.kind.focus();
			return;
		}
		if(!nick2){
			alert("닉네임을 먼저 입력해주세요.");
			information.nickname.focus();
			return;
		}
		
		window.open("nick_check.jsp?nick_value="+nick2+"&kind_value=" + kind2 + "","hiddenframe1","width=300,height=200");
	}

</script>

<br><br>
<div align=center><b>회원가입</b></div>
<br>
<br>
<iframe width=0 height=0 name="hiddenframe1" style="display:none;"></iframe>
<table class="out_table" align=center>
	<form name="information" action="/login&join/join_ok.jsp" method="post">
		<tr>
			<td>
				<table width=80% height=100% align=center>
					<tr>
						<td class="guelja">구분</td>
						<td>
							<table>
								<tr>
									<td style="font-size:15px;">
										<label><input type="radio" class="kind_input" id="kind" name="kind" value="recipient_mem">기관인</label>
									</td>
									<td style="font-size:15px">
										<label><input type="radio" class="kind_input" id="kind" name="kind" value="giver_mem">일반인</label>
									</td>
									<td width=20px></td>
									<td>
										<img src="/img/information.png" onmouseover="src='/img/alarm.PNG'" onmouseout="src='/img/information.png'">
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="guelja">아이디</td>
						<td>
							<input id="id" name="id" placeholder="12자 이내">
							<a class="aa" onclick="id_check()">중복확인</a>
							<input class="hwackin" id="check_same" name="check_same" tabindex="-1" readonly>
						</td>
					</tr>
					<tr>
						<td class="guelja">닉네임 또는 기관이름</td>
						<td>
							<input id="nickname" name="nickname" placeholder="10자 이내">
							<a class="aa" onclick="nickname_check()">중복확인</a>
							<input class="hwackin" id="check_nick" name="check_nick" tabindex="-1" readonly>
						</td>
					</tr>
					<tr>
						<td class="guelja">비밀번호</td>
						<td><input id="pass" name="pass" type="password" maxlength="10" placeholder="10자 이내"></td>
					</tr>
					<tr>
						<td class="guelja">비밀번호 확인</td>
						<td><input id="pass_ok" name="pass_ok" type="password" ></td>
					</tr>
					<tr>
						<td class="guelja">이메일</td>
						<td>
							<input id="email" name="email"> @
							<input id="email_address" name="email_address">
							<select class="email_input" onchange="email_address.value = this.value">
								<option value="">직접입력</option>
								<option value="naver.com">naver.com</option>
								<option value="gmail.com">gmail.com</option>
								<option value="daum.net">daum.net</option>
								<option value="hanmail.net">hanmail.net</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="guelja">휴대폰 번호</td>
						<td><input id="phone" name="phone"></td>
					</tr>
					<tr>
						<td class="guelja">주소</td>
						<td>
							<table>
								<tr>
									<td>
										<input type="text" style="width:100%" id="sample6_postcode" name="zipcode" placeholder="우편번호" readonly>
									</td>
									<td width=5px></td>
									<td>
										<input type="button" id="chatki" class="juso" onclick="sample6_execDaumPostcode()" value="주소찾기">
									</td>
								</tr>
								<tr>
									<td colspan=3><input type="text" style="width:100%" id="sample6_address" name="zip1" placeholder="주소" readonly></td>
								</tr>
								<tr>
									<td colspan=3><input type="hidden" style="width:100%" id="sample6_detailAddress" name="zip2"></td>
								</tr>
								<tr>
									<td colspan=3><input type="hidden" style="width:100%" id="sample6_extraAddress" name="zip3"></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</form>
</table>


<br>
<table align=center>
	<tr>
		<td colspan=2>
			<button class="gaip" onclick="gaip_do()">회원가입</button>
		</td>
	</tr>
</table>
<br><br>
<!--주소 찾기-->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>

<%@ include file="/include/footer.jsp" %>