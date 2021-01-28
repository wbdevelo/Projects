<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<!-- 제이쿼리 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<title>Insert title here</title>

<style>
	#ansimChk{
		border: 1px solid black;
		display: flex;
		flex-direction: column;
		justify-content: space-around;
		align-items: center;
		height: 400px;
	}
	#ansimChk > div{
		width: 100%;
		text-align: center;
	}
	#ansimChk > div > input{
		width: 90%;
		height: 30px;
		
	}
	#printstore{
		border: 1px solid black;
		display: flex;
		flex-direction: column;
		justify-content: space-around;
		align-items: center;
		height: 400px;
		visibility: hidden;
	}
</style>
</head>
<body>
	<form id="ansimChk">
		<div>
			<input name="sido" placeholder="광역시 / 도 를 입력해 주시기 바랍니다.">
		</div>
		<div>
			<input name="sigugun" placeholder="시 / 구 / 군 을 입력해 주시기 바랍니다.">
		</div>
		<div>
			<input name="address" placeholder="상세 주소를 입력해 주시기 바랍니다.">
		</div>
		<div>
			<input name="storename" placeholder="가게명을 입력해 주시기 바랍니다.">
		</div>
		<div>
			<button type="button" style="height: 40px; cursor: pointer;" onclick="StoreAnSimChk()">
				검색하기
			</button>
		</div>
	</form>
	<div id="printstore">	<!-- 등록정보 출력 영역 -->
	</div>
	
	<script>
		function StoreAnSimChk(){
			var frm = document.getElementById('ansimChk');
			
			if(frm.sido.value == ""){
				alert("광역시 / 도를 입력해주시기 바랍니다.");
				frm.sido.focus();
				return;
			} else if(frm.sigugun.value == ""){
				alert("시 / 구 / 군을 입력해주시기 바랍니다.");
				frm.sigugun.focus();
				return;
			} else if(frm.address.value == ""){
				alert("상세주소를 입력해주시기 바랍니다.");
				frm.address.focus();
				return;
			} else if(frm.storename.value == ""){
				alert("가게명을 입력해주시기 바랍니다.");
				frm.storename.focus();
				return;
			} else{
				$.ajax({
					type : "get",
					url : "/ajax/chkStoreAnsim",
					data : {
						"sido" : frm.sido.value,
						"sigugun" : frm.sigugun.value,
						"address" : frm.address.value,
						"storename" : frm.storename.value
					},
					success : function(data){
						
						if(data.relax_seq == null){
							alert('검색결과가 없습니다.');
							window.close();
						} else{
							$('#ansimChk').empty();
							$('#ansimChk').remove();
							
							var str =  '<div><b>식당 코드 : '+data.relax_seq+'</b></div>';
								str += '<div>광역시 / 도 :'+data.relax_si_nm+'</div>';
								str += '<div>시 / 구 / 군 :'+data.relax_sido_nm+'</div>';
								str += '<div>가게 이름 : '+data.relax_rstrnt_nm+'</div>';
								str += '<div>대표자명 : '+data.relax_rstrnt_represent+'</div>';
								str += '<div>주소 : '+data.relax_add1+'</div>';
								str += '<div>업종1 : '+data.relax_gubun+'</div>';
								str += '<div>업종2 : '+data.relax_gubun_detail+'</div>';
								str += '<div>전화번호 : '+data.relax_rstrnt_tel+'</div>';
								str += '<div><b>안심식당 지정일 : '+data.date+'</b></div>';
								str += '<div><b>사업자 가입을 하실경우 식당코드를 외워주시기 바랍니다.</b></div>';
								
							$('#printstore').append(str);
							$('#printstore').css("visibility", "visible");
						}
					}
				});
			}
		}
	</script>
</body>
</html>