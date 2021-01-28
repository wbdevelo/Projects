<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/nav.jsp"%>

<style>
	.join-container{
        /* border: 1px solid black; */
        display: grid;
        grid-template-columns: 1fr 1fr 1fr 1fr;
        grid-auto-rows: minmax(auto, auto);
        align-items: center;
        grid-gap: 10px;
        margin-top: 50px;
    }
    .join-head-text{
        grid-column: 2 / 4;
        text-align: center;
        margin-top: 30px;
    }
    .join-text{
        grid-column: 2 / 3;
        text-align: right;
        font-size: 20px;
    }
    .join-input{
        grid-column: 3 / 4;
    
    }
    .join-btn{
        grid-column: 2 / 4;
        text-align: center;
    }
    .join-btn > button{
        width: 50%;
        height: 50px;
        cursor: pointer;
    }
    .join-frm{
        border: 1px solid black;
        grid-column: 2 / 4;
        display: grid;
        grid-template-columns: 0.5fr 1fr 1fr 0.5fr;
        grid-auto-rows: minmax(auto, auto);
        grid-gap: 30px;
        height: 100%;
    }
</style>


<script>
	
	function idCheck(){
		var id = $("#id").val();
	
		$.ajax({
			type : "post",
			url : "/member/idCheck",
			data : {
				"userId" : id
			},
			success : function(data){
			
				var checkId = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{5,10}$/;
				
				if(data == ""){
					if(checkId.test(id) == true){
						$("#idResult").val("사용 가능한 아이디입니다.");
						$("#idResult").css("color","blue");

					}else{
						$("#idResult").val("양식을 확인해주세요.");
						$("#idResult").css("color","red");
					}
				}else{
					$("#idResult").val("사용 불가능한 아이디입니다.");
					$("#idResult").css("color","red");
				}
				
			}
		});
		
	}
	
	function StordCodeCheck(){
		var storecode = $('#storecode').val();
		
		$.ajax({
			type : "post",
			url : "/ajax/storecodeCheck",
			data : {
				"storecode" : storecode
			},
			success : function(data){
				console.log("data:"+data);
				if(storecode != data || data == ""){
					$("#storeResult").val('안심식당에 등록되지않았습니다.');
					$("#storeResult").css("color","red");
				}
				
				if(storecode == data){
					$("#storeResult").val('안심식당에 등록되었습니다.');
					$("#storeResult").css("color","blue");
				}
			}
		});
	}
	
	function bSub(){
		var fn = memJoin;
		var check = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{5,10}$/; //문자, 숫자 한 개 이상으로 총 5~10자.
		var phone = /^[0-9]{11}$/;
		
		if(!fn.id.value){
			alert("아이디를 입력해주세요.");
			fn.id.focus();
			return;
		}
		if(!check.test(fn.id.value)){
			alert("아이디 양식을 확인해주세요.");
			fn.id.focus();
			return;
		}
		if(idResult.value == "사용 불가능한 아이디입니다."){
			alert("다른 아이디를 입력해주세요.");
			fn.id.focus();
			return;
		}
		if(!fn.password.value){
			alert("비밀번호를 입력해주세요.");
			fn.password.focus();
			return;
		}
		if(!check.test(fn.password.value)){
			alert("비밀번호 양식을 확인해주세요.");
			fn.password.focus();
			return;
		}
		if(pwResult.value == "비밀번호가 일치하지 않습니다."){
			alert("다른 비밀번호를 입력해주세요.");
			fn.password.focus();
			return;
		}
		if(!fn.pwCheck.value){
			alert("비밀번호 확인을 입력해주세요.");
			fn.pwCheck.focus();
			return;
		}
		if(!fn.tel.value){
			alert("연락처를 입력해주세요.");
			fn.tel.focus();
			return;
		}
		if(!phone.test(fn.tel.value)){
			alert("연락처 양식을 확인해주세요.");
			fn.tel.focus();
			return;
		}
		if(!fn.sample6_address.value){
			alert("주소를 입력해주세요.");
			return;
		}
		fn.submit();
	}
	
	var msg = "${msg}";
	if(msg == null || msg == ""){
		
	}else{
		alert(msg);
		location.href="/";
	}
	
	var mag = "${mag}"
	if(mag == null || mag == ""){
		
	} else {
		alert(mag);
		location.href="/member/login";
	}
	
	function checkPw(){
		var pw1 = $("#password").val();
		var pw2 = $("#pwCheck").val();
		
		var checkPass = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{5,10}$/;

		if(pw1 == pw2){
			if(checkPass.test(pw1) == true){
				$("#pwResult").val("비밀번호가 일치합니다.");
				$("#pwResult").css("color", "blue");
			}else{
				$("#pwResult").val("양식을 확인해주세요.");
				$("#pwResult").css("color", "red");
			}
		}else{
			$("#pwResult").val("비밀번호가 일치하지 않습니다.");
			$("#pwResult").css("color", "red");
		}
		
	}
	
	function checkPw2(){
		var pw1 = $("#storepassword").val();
		var pw2 = $("#storepwCheck").val();
		
		var checkPass = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{5,10}$/;
		
		if(pw1 == pw2){
			if(checkPass.test(pw1) == true){
				$("#storepwResult").val("비밀번호가 일치합니다.");
				$("#storepwResult").css("color", "blue");
			}else{
				$("#storepwResult").val("양식을 확인해주세요.");
				$("#storepwResult").css("color", "red");
			}
		}else{
			$("#storepwResult").val("비밀번호가 일치하지 않습니다.");
			$("#storepwResult").css("color", "red");
		}
		
	}

	function JoinMemberChk(num){
		var achk = document.getElementById('aaa');
		var dchk = document.getElementById('ddd');
		
		if(num == 1){
			
			achk.checked = true;
			
			$('#OnlyMember').show();
			$('#StoreMember').hide();
		}
		
		if(num == 2){

			dchk.checked = true;
			
			$('#OnlyMember').hide();
			$('#StoreMember').show();
			
		}
	}
	
	$(function(){
		$('#StoreMember').hide();
	});
	
	function storeSub(){
		var stm = StorememJoin;
		
		if(stm.storecode.value == ""){
			alert('식당 코드를 입력해 주시기 바랍니다.');
			stm.storecode.focus();
			return;
		} else if(stm.id.value == ""){
			alert('아이디를 입력해 주시기 바랍니다.');
			stm.id.focus();
			return;
		} else if(stm.password.value == ""){
			alert('비밀번호를 입력해 주시기 바랍니다.');
			stm.password.focus();
			return;
		} else if(stm.pwCheck.value == ""){
			alert('비밀번호확인란을 입력해 주시기 바랍니다.');
			stm.pwCheck.focus();
		} else if(stm.tel1.value == ""){
			alert('연락처를 입력해 주시기 바랍니다.');
			stm.tel1.focus();
			return;
		} else if(stm.tel2.value == ""){
			alert('가게 연락처를 입력해 주시기 바랍니다.');
			stm.tel2.focus();
			return;
		} else if(stm.storename.value == ""){
			alert('가게명을 입력해 주시기 바랍니다.');
			stm.storename.focus();
			return;
		} else if(stm.address.value == ""){
			alert('가게 주소를 입력해 주시기 바랍니다.');
			stm.address.focus();
			return;
		} else{
			stm.submit();
		}
		

	}
</script>

<div id="joincont" class="join-container">
	<form id="OnlyMember" class="join-frm" name="memJoin" method="post">
	    <div class="join-head-text">
	        <h1>회원 가입</h1>
	    </div>
	    <div class="join-text" style="text-align: center;">
	    	<label style="cursor: pointer;"><input id="aaa" type="radio" name="memberchk" onclick="JoinMemberChk(1)" checked="checked">일반 회원 가입</label>
	    </div>
	    <div class="join-text" style="grid-column: 3 / 4; text-align: center;">
	    	<label style="cursor: pointer;"><input id="bbb" type="radio" name="memberchk" onclick="JoinMemberChk(2)">사업자 가입</label>
	    </div>
	    <div class="join-text">
	        아 이 디 :
	    </div>
	    <div class="join-input">
	        <input type="text" name="id" id="id" style="width: 100%; height: 30px;" onkeyup="idCheck()" placeholder="영문자, 숫자 각 1개 이상, 총 5~10자 입력">
	        <input id="idResult" style="border:0px" tabindex="-1" readonly="readonly">
	    </div>
	    <div class="join-text">
	        비 밀 번 호 :
	    </div>
	    <div class="join-input">
	        <input type="password" name="password" id="password" style="width: 100%; height: 30px;" placeholder="영문자, 숫자 각 1개 이상, 총 5~10자 입력">
	    </div>
	    <div class="join-text">
	        비밀번호 확인 :
	    </div>
	    <div class="join-input">
	        <input type="password" name="pwCheck" id="pwCheck" style="width: 100%; height: 30px;" oninput="checkPw()">
	        <input id="pwResult" style="border:0px;width:200px;" tabindex="-1" readonly="readonly"> <!-- new -->
	    </div>
	    <div class="join-text">
	        연 락 처 :
	    </div>
	    <div class="join-input">
	        <input type="text" name="tel" id="tel" style="width: 100%; height: 30px;" placeholder="'-'없이 숫자만 입력">
	    </div>
	    <div class="join-text">
	        주 소 :
	    </div>
	    <div class="join-input" style="text-align: right;">
			<input type="text" name="address" id="sample6_address" placeholder="주소" style="width: 100%; height: 30px;">
			<input type="button" onclick="sample6_execDaumPostcode()" value="주소 검색" style="margin-top: 10px; height: 30px;">
	    </div>
	    <div class="join-btn">
	        <button type="button" onclick="bSub()" style="margin-bottom: 30px;">회 원 가 입</button>
	    </div>
    </form>
    
    <!-- 여기서부터 사업자 가입 -->
    <form id="StoreMember" class="join-frm" name="StorememJoin" action="storeJoin" method="post">
	    <div class="join-head-text">
	        <h1>사업자 가입</h1>
	    </div>
	    <div class="join-text" style="text-align: center;">
	    	<label style="cursor: pointer;"><input id="ccc" type="radio" name="memberchk" onclick="JoinMemberChk(1)" >일반 회원 가입</label>
	    </div>
	    <div class="join-text" style="grid-column: 3 / 4; text-align: center;">
	    	<label style="cursor: pointer;"><input id="ddd" type="radio" name="memberchk" onclick="JoinMemberChk(2)" checked="checked">사업자 가입</label>
	    </div>
	    <div class="join-text">
	        가게 코드 : 
	    </div>
	    <div class="join-input">
	        <input type="text" name="storecode" id="storecode" style="width: 100%; height: 30px;" onkeyup="StordCodeCheck()">
	        <input id="storeResult" style="border:0px; width: 100%;" tabindex="-1" readonly="readonly" maxlength="50">
	    </div>
	    <div class="join-text">
	        아 이 디 :
	    </div>
	    <div class="join-input">
	        <input type="text" name="id" id="storeid" style="width: 100%; height: 30px;" onkeyup="idCheck()" placeholder="영문자, 숫자 각 1개 이상, 총 5~10자 입력">
	        <input id="storeidResult" style="border:0px" tabindex="-1" readonly="readonly">
	    </div>
	    <div class="join-text">
	        비 밀 번 호 :
	    </div>
	    <div class="join-input">
	        <input type="password" name="password" id="storepassword" style="width: 100%; height: 30px;" placeholder="영문자, 숫자 각 1개 이상, 총 5~10자 입력">
	    </div>
	    <div class="join-text">
	        비밀번호 확인 :
	    </div>
	    <div class="join-input">
	        <input type="password" name="pwCheck" id="storepwCheck" style="width: 100%; height: 30px;" oninput="checkPw2()">
	        <input id="storepwResult" style="border:0px;width:200px;" tabindex="-1" readonly="readonly"> <!-- new -->
	    </div>
	    <div class="join-text">
	        연 락 처 1(개인) :
	    </div>
	    <div class="join-input">
	        <input type="text" name="tel1" id="tel1" style="width: 100%; height: 30px;">
	    </div>
	    <div class="join-text">
	        연 락 처 2(가게) :
	    </div>
	    <div class="join-input">
	        <input type="text" name="tel2" id="tel2" style="width: 100%; height: 30px;">
	    </div>
	        <div class="join-text">
	       가 게 명 :
	    </div>
	    <div class="join-input">
	        <input type="text" name="storename" id="storename" style="width: 100%; height: 30px;">
	    </div>
	    <div class="join-text">
	        주 소 :
	    </div>
	    <div class="join-input" style="text-align: right;">
			<input type="text" name="address" id="sample7_address" placeholder="주소" style="width: 100%; height: 30px;">
			<input type="button" onclick="sample7_execDaumPostcode()" value="주소 검색" style="margin-top: 10px; height: 30px;">
	    </div>
	    <div class="join-btn">
	        <button type="button" onclick="storeSub()" style="margin-bottom: 30px;">회 원 가 입</button>
	    </div>
    </form>
</div>


<!-- 카카오 주소 -->	
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
                    /* document.getElementById("sample6_extraAddress").value = extraAddr; */
                
                } else {
                   /* document.getElementById("sample6_extraAddress").value = ''; */
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                /* document.getElementById('sample6_postcode').value = data.zonecode; */
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                /* document.getElementById("sample6_detailAddress").focus(); */
            }
        }).open();
    }
    
    function sample7_execDaumPostcode() {
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
                    /* document.getElementById("sample6_extraAddress").value = extraAddr; */
                
                } else {
                   /* document.getElementById("sample6_extraAddress").value = ''; */
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                /* document.getElementById('sample6_postcode').value = data.zonecode; */
                document.getElementById("sample7_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                /* document.getElementById("sample6_detailAddress").focus(); */
            }
        }).open();
    }
</script>




<%@ include file="/WEB-INF/views/include/footer.jsp"%>