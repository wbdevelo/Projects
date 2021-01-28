<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/include/nav.jsp"%>

<style>
.search-container{
       /*  border: 1px solid black; */
        display: grid;
        grid-template-columns: 1fr 1fr 1fr 1fr;
        grid-auto-rows: minmax(auto, auto);
        align-items: center;
        grid-gap: 30px;
        height: 700px;
    }
    .search-head-text{
        grid-column: 2 / 4;
        text-align: center;
        margin-top: 50px;
    }
    .search-text{
        grid-column: 2 / 3;
        text-align: right;
        font-size: 20px;
    }
    .search-input{
        grid-column: 3 / 4;
    
    }
    .search-btn{
        grid-column: 2 / 4;
        text-align: center;
        margin-bottom: 50px;
    }
    .search-btn > button{
        width: 50%;
        height: 50px;
        cursor: pointer;
        font-size: 15px;
    }
    .search-frm{
        border: 1px solid black;
        grid-column: 2 / 4;
        display: grid;
        grid-template-columns: 0.5fr 1fr 1fr 0.5fr;
        grid-auto-rows: minmax(auto, auto);
        grid-gap: 30px;
    }
</style>

<div class="search-container">
    <form name="searchPw" method="post" action="/member/searchpw" class="search-frm" id="searchMemPw">
        <div class="search-head-text">
            <h1>비밀번호 찾기</h1>
        </div>
        <div class="search-text" style="text-align: center;">
            <label style="cursor: pointer;"><input id="PwsearchMem" type="radio" checked="checked" onclick="changePwSearch(1)">개인 회원</label>
        </div>
        <div class="search-text" style="grid-column: 3 / 4; text-align: center;">
            <label style="cursor: pointer;"><input id="PwsearchStore" type="radio" onclick="changePwSearch(2)">사업자</label>
        </div>
        <div class="search-text">
            아 이 디 :
        </div>
        <div class="search-input">
            <input type="text" name="id" id="id" style="width: 100%; height: 30px;">
        </div>
        <div class="search-text">
            연 락 처 :
        </div>
        <div class="search-input">
            <input type="text" name="tel" id="tel" style="width: 100%; height: 30px;">
        </div>
        <div class="search-text">
            주 소 :
        </div>
        <div class="search-input">
            <input type="text" name="address" id="address" style="width: 100%; height: 30px;">
        </div>
        <div class="search-btn">
            <button type="button" onclick="SearchOpen()">비 밀 번 호 찾 기</button>
        </div>
    </form>
    <form name="searchPw" method="post" class="search-frm" id="StoresearchMemPw" action="/member/storesearchpw">
        <div class="search-head-text">
            <h1>비밀번호 찾기</h1>
        </div>
        <div class="search-text" style="text-align: center;">
            <label style="cursor: pointer;"><input id="aaa" type="radio" onclick="changePwSearch(1)">개인 회원</label>
        </div>
        <div class="search-text" style="grid-column: 3 / 4; text-align: center;">
            <label style="cursor: pointer;"><input id="PwsearchStore" type="radio" checked="checked" onclick="changePwSearch(2)">사업자</label>
        </div>
        <div class="search-text">
            아 이 디 :
        </div>
        <div class="search-input">
            <input type="text" name="id" id="storeid" style="width: 100%; height: 30px;">
        </div>
        <div class="search-text">
            가게 코드 :
        </div>
        <div class="search-input">
            <input type="text" name="storecode" id="storecode" style="width: 100%; height: 30px;">
        </div>
        <div class="search-text">
            상호명 :
        </div>
        <div class="search-input">
            <input type="text" name="storename" id="storename" style="width: 100%; height: 30px;">
        </div>
        <div class="search-text">
            주 소 :
        </div>
        <div class="search-input">
            <input type="text" name="address" id="address" style="width: 100%; height: 30px;">
        </div>
        <div class="search-btn">
            <button type="button" onclick="SearchOpen2()">비 밀 번 호 찾 기</button>
        </div>
    </form>
</div>

<c:if test="${cnt == 1 }">
	<script>
		var id = '${id}';
		window.open('/member/newpassword?id='+id,'','top=100, left=500, width=500, height=500');
	</script>
</c:if>
<c:if test="${cnt == '3' }">
	<script>
		var id = '${id}';
		window.open('/member/newpassword2?id='+id,'','top=100, left=500, width=500, height=500');
	</script>
</c:if>
<c:if test="${cnt == 0}">
	<script>
		alert('등록된 회원이 아닙니다.');
		window.reload();
	</script>
</c:if>

<script>
	$('#StoresearchMemPw').hide();
	
	function changePwSearch(num){
		var mp = document.getElementById('PwsearchMem');
		var sp = document.getElementById('PwsearchStore');
		var aa = document.getElementById('aaa');

		if(num == 1){
			mp.checked = true;
			sp.checked = false;
			$('#searchMemPw').show();
			$('#StoresearchMemPw').hide();
		}
		if(num == 2){
			aa.checked = false;
			mp.checked = false;
			$('#searchMemPw').hide();
			$('#StoresearchMemPw').show();
		}
	}

	function SearchOpen2(){
		var fn = document.getElementById('StoresearchMemPw');
		
		if(!fn.storeid.value){
			alert("아이디를 입력해주세요.");
			fn.id.focus();
			return;
		}
		if(!fn.storecode.value){
			alert("가게코드를 입력해주세요.");
			fn.storecode.focus();
			return;
		}
		if(!fn.storename.value){
			alert("가게이름을 입력해주세요.");
			fn.storename.focus();
			return;
		}
		if(!fn.address.value){
			alert("주소를 입력해주세요.");
			fn.address.focus();
			return;
		}
		fn.submit();
	}
	
	function SearchOpen(){
		var fn = document.getElementById('searchMemPw');
		
		if(!fn.id.value){
			alert("아이디를 입력해주세요.");
			fn.id.focus();
			return;
		}
		if(!fn.tel.value){
			alert("연락처를 입력해주세요.");
			fn.tel.focus();
			return;
		}
		if(!fn.address.value){
			alert("주소를 입력해주세요.");
			fn.address.focus();
			return;
		}
		fn.submit();
	}
</script>

<%@ include file="/WEB-INF/views/include/footer.jsp"%>