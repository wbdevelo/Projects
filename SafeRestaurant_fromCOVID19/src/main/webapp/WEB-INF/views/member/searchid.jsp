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
    <form class="search-frm" id="Searchmem">
        <div class="search-head-text">
            <h1>아이디 찾기</h1>
        </div>
        <div class="search-text" style="text-align: center; font-size: 20px;">
           <label style="cursor: pointer;"><input id="memSearch" type="radio" name="srarchSelect" checked="checked" onclick="changeSearch(1)">개인 회원</label>
        </div>
        <div class="search-text" style="grid-column: 3 / 4; text-align: center; font-size: 20px;">
            <label style="cursor: pointer;"><input type="radio" name="srarchSelect" onclick="changeSearch(2)">사업자</label>
        </div>
        <div class="search-text">
            연 락 처 :
        </div>
        <div class="search-input">
            <input type="text" name="tel" id="tel" style="width: 100%; height: 30px;" placeholder="'-'없이 입력해주세요.">
        </div>
        <div class="search-text">
            주 소 :
        </div>
        <div class="search-input">
            <input type="text" name="address" id="address" style="width: 100%; height: 30px;">
        </div>
        <div class="search-btn">
            <button type="button" onclick="SearchOpen()">아 이 디 찾 기</button>
        </div>
    </form>
    <form class="search-frm" name="storeMemSearch" id="storeMemSearch">
        <div class="search-head-text">
            <h1>아이디 찾기</h1>
        </div>
        <div class="search-text" style="text-align: center; font-size: 20px;">
           <label style="cursor: pointer;"><input type="radio" name="srarchSelect" onclick="changeSearch(1)">개인 회원</label>
        </div>
        <div class="search-text" style="grid-column: 3 / 4; text-align: center; font-size: 20px;">
            <label style="cursor: pointer;"><input id="stoSearch" type="radio" name="srarchSelect" checked="checked" onclick="changeSearch(2)">사업자</label>
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
            <input type="text" name="address" id="stoaddress" style="width: 100%; height: 30px;">
        </div>
        <div class="search-btn">
            <button type="button" onclick="SearchOpen1()">아 이 디 찾 기</button>
        </div>
    </form>
</div>

<script>
	$('#storeMemSearch').hide();
	
	function changeSearch(num){
		var mems = document.getElementById('memSearch');
		var smems = document.getElementById('stoSearch');
		
		if(num == 1){
			mems.checked = true;
			smems.checked = false;
			
			$('#Searchmem').show();
			$('#storeMemSearch').hide();
		}
		
		if(num == 2){
			mems.checked = false;
			smems.checked = true;
			
			$('#Searchmem').hide();
			$('#storeMemSearch').show();
		}
	}

	function SearchOpen1(){
		if(!$("#storecode").val()){
			alert("가게코드를 입력해주세요.");
			$("#storecode").focus();
			return;
		}
		if(!$("#storename").val()){
			alert("상호명을 입력해주세요.");
			$("#storename").focus();
			return;
		}
		if(!$("#stoaddress").val()){
			alert("주소를 입력해주세요.");
			$("#stoaddress").focus();
			return;
		}
		
		var code = $("#storecode").val();
		var storename = $("#storename").val();
		var address = $("#stoaddress").val();
		 
		$.ajax({
			type : "post",
			url : "/member/storesearchid",
			data : {
				"code" : code,
				"storename" : storename,
				"address" : address
			},
			success : function(data){
				
				if(data == "none"){
					$("#tel").val("");
					$("#address").val("");
					alert("없는 정보입니다.");
				}else{
					$("#tel").val("");
					$("#address").val("");
					alert(data);
				}
				
			}
		});
	}
	
	function SearchOpen(){
		var phone = /^[0-9]{11}$/;
		
		if(!$("#tel").val()){
			alert("연락처를 입력해주세요.");
			$("#tel").focus();
			return;
		}
		if(!$("#address").val()){
			alert("주소를 입력해주세요.");
			$("#address").focus();
			return;
		}
		if(!phone.test($("#tel").val())){
			alert("연락처 양식을 확인해주세요.");
			$("#tel").focus();
			return;
		}
		
		var userTel = $("#tel").val();
		var userAdd = $("#address").val();
		 
		$.ajax({
			type : "post",
			url : "/member/searchid",
			data : {
				"tel" : userTel,
				"addr" : userAdd
			},
			success : function(data){
				
				if(data == "none"){
					$("#tel").val("");
					$("#address").val("");
					alert("없는 정보입니다.");
				}else{
					$("#tel").val("");
					$("#address").val("");
					alert(data);
				}
				
			}
		});
		
	}
</script>

<%@ include file="/WEB-INF/views/include/footer.jsp"%>