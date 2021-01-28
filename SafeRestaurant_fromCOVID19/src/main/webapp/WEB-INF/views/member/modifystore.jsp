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
	.modify-container{
        /* border: 1px solid black; */
        display: flex;
        justify-content: center;
        height: 700px;
        margin-top: 50px;
    }
    .modify-container > form{
        border: 1px solid black;
        width: 80%;
        text-align: center;
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        grid-auto-rows: minmax(auto, auto);
        grid-gap: 30px;
        align-items: center;
    }
    .modify-head-text{
        grid-column: 2 / 4;
    }
    .modify-text{
        grid-column: 2 / 3;
        text-align: right;
        font-size: 20px;
    }
    .modify-input{
        grid-column: 3 / 4;
    }
    .modify-input > input{
        width: 100%;
        height: 30px;
    }
    .modify-btn{
        grid-column: 2 / 4;
    }
    .modify-btn > button{
        width: 50%;
        cursor: pointer;
        height: 50px;
        font-size: 15px;
    }
</style>


<script>

	var msg = "${msg}";
	if(msg == null || msg == ""){
		
	}else{
		alert("수정이 완료되었습니다.");
	}

    $("#id").css({
        "backgroundColor" : "#EFEFEF",
        "border" : "1px solid #000"
    });
    
    function checkMemInfo(){
        fn = memModify;
        
        if(!fn.tel1.value){
        	alert("연락처1(개인)를 입력해주세요.");
        	fn.tel.focus();
        	return;
        }
        if(!fn.tel2.value){
        	alert("연락처2(가게)를 입력해주세요.");
        	fn.tel.focus();
        	return;
        }
        if(!fn.storename.value){
        	alert("연락처2(가게)를 입력해주세요.");
        	fn.tel.focus();
        	return;
        }
        if(!fn.sample6_address.value){
        	alert("주소를 입력해주세요.");
        	return;
        }
        fn.submit();
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



<div class="modify-container">
    <form name="memModify" method="post">
        <div class="modify-head-text">
            <h1>회 원 수 정</h1>
        </div>
        <div class="modify-text">
            가게 코드 : 
        </div>
        <div class="modify-input">
            <input id="storecode" name="storecode" type="text" value="${svo.storecode}" readonly="readonly" style="background-color: rgba(0,0,0,0.1); border: 1px solid rgba(0,0,0,0.1);">
        </div>
        <div class="modify-text">
            아 이 디 : 
        </div>
        <div class="modify-input">
            <input id="read" name="id" type="text" value="${svo.id}" readonly="readonly" style="background-color: rgba(0,0,0,0.1); border: 1px solid rgba(0,0,0,0.1);">
        </div>
        <div class="modify-text">
            연 락 처1(개인) : 
        </div>
        <div class="modify-input">
            <input type="text" id="tel1" name="tel1" value="${svo.tel1}">
        </div>
        <div class="modify-text">
            연 락 처2(가게) : 
        </div>
        <div class="modify-input">
            <input type="text" id="tel2" name="tel2" value="${svo.tel2}">
        </div>
        <div class="modify-text">
            상 호 명 : 
        </div>
        <div class="modify-input">
            <input type="text" id="storename" name="storename" value="${svo.storename}">
        </div>
        <div class="modify-text">
            주  소 : 
        </div>
        <div class="modify-input">
            <input type="text" name="address" id="sample6_address"  value="${svo.address}">
        </div>
		<input type="button" onclick="sample6_execDaumPostcode()" value="주소 검색" style="cursor: pointer; width: 30%; margin-top: 10px; height: 30px;">
        <div class="modify-btn">
            <button type="button" onclick="checkMemInfo()">정 보 수 정</button>
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
</script>

<%@ include file="/WEB-INF/views/include/footer.jsp"%>