<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/include/nav.jsp"%>

<style>
	.category-container{
		margin-top: 50px;
		width: 100%;
		display: flex;
		justify-content: space-between;
	}
	.category-container-null{
		width: 20%;
	}
	.category-container-content{
		width: 60%;
	}
	.category-selectbox{
		display: flex;
		justify-content: center;
		align-items: center;
		width: 100%;
		height: 100px;
		border:1px solid black;
	}
	.category-selectbox > select{
		width: 30%;
		height: 50px;
	}
	.category-selectbox > button{
		height: 50px; 
		width: 5%; 
		cursor: pointer;
		background-color: white;
		border:0;
	}
	.category-selectbox > button:hover {
		opacity: 0.5;
	}
	.category-store{
		margin-top: 50px;
		display: grid;
		grid-template-columns: 1fr 1fr;
		grid-auto-rows: minmax(auto, auto);
		gap: 30px;
	}
	.category-store-list{
		border: 1px solid black;
		width: 100%;
		display: flex;
	}
	.category-store-list > a > img{
		border-right: 1px solid black;
		max-width: 100%;
	}
	.category-store-list-text{
		width: 100%;
		padding-left: 10px;
		display: flex;
		flex-direction: column;
		justify-content: space-around;
	}
	.paging-container{
		margin-top: 50px;
		display: flex;
	}
	.paging{
		width: 30%;
		display: flex;
		justify-content: space-around;
	}
	.paging-num{
		cursor: pointer;
		font-size: 15px;
	}
	.paging-num:hover {
		opacity: 0.5;
	}
}
</style>

<%-- <c:if test="${empty list}">
	<script>
		alert('검색 결과가 없습니다.');
		location.href="list?category="+'한식';
	</script>
</c:if> --%>

<div class="category-container">
	<div class="category-container-null"></div>
	<div class="category-container-content">
		<form class="category-selectbox" name="categoryselectbox" action="" method="post">
			<select id="sido" name="sido" style="margin-right: 20px;" onchange="selectSearch(this.value)">
				<option value="">광역시 / 도 선택하기</option>
                <option value="서울특별시">서울특별시</option>
                <option value="세종특별자치시">세종특별자치시</option>
                <option value="인천광역시">인천광역시</option>
                <option value="대전광역시">대전광역시</option>
                <option value="대구광역시">대구광역시</option>
                <option value="울산광역시">울산광역시</option>
                <option value="부산광역시">부산광역시</option>
                <option value="광주광역시">광주광역시</option>
                <option value="경기도">경기도</option>
                <option value="강원도">강원도</option>
                <option value="충청남도">충청남도</option>
                <option value="충청북도">충청북도</option>
                <option value="경상북도">경상북도</option>
                <option value="경상남도">경상남도</option>
                <option value="전라북도">전라북도</option>
                <option value="전라남도">전라남도</option>
                <option value="제주특별자치도">제주특별자치도</option>
			</select>
			<select id="selgu" name="sigugun">
				<option value="">시 / 구 / 군 선택하기</option>
			</select>
			<button type="button" onclick="categorySelect()">
				<i class="fas fa-search" style="font-size: 20px;"></i>
			</button>
		</form>
		<div style="margin: 50px auto; text-align: center">
			<h1>${param.category }</h1>
		</div>
		<div id="listCard" class="category-store">
		</div>
	</div>
	<div class="category-container-null"></div>
</div>
<!-- 보여줄 페이지 숫자 세팅 -->

<div class="paging-container">
	<div class="category-container-null" style="width: 35%"></div>
	<div id="pageing" class="paging">
	</div>
	<div class="category-container-null" style="width: 35%"></div>
</div>

<script>

	var category = '${category}';
	var sido = '${sido}';
	var sigugun = '${sigugun}';
	var indexpage = 1;

	if(sido != '' || sigugun != ''){
		$("#sido").val(sido).prop("selected", true);
		selectSearch(sido);
	}
	
	paging(indexpage);
	
	function paging(pagenum){
		
		// 게시물 출력
		var startIndex = 0;
		var endIndex = 20;
		var totalCnt = ${fn:length(list)};
		var printlist = 20;		// 출력 게시물 수
		
		if(pagenum != 1){
			startIndex = ((pagenum-1)*printlist);
			endIndex = (startIndex+printlist);
		}
		
		if(endIndex>totalCnt){
			endIndex = totalCnt;
		}
		$('#listCard').empty();
		var listCard = "";
			<c:forEach var="list" items="${list }" varStatus="status">
				if(startIndex<='${status.index}' && '${status.index}'<endIndex){
					listCard +=	'<div class="category-store-list">';
					listCard +=	'<a style="max-width: 40%;" href="/board/detailpage?code=${list.relax_seq }"><img alt="사진없음" src="/resources/img/logo3.png"></a>';
					listCard +=	'<div class="category-store-list-text">';
					listCard +=	'<span>광역시 / 도 : ${list.relax_si_nm}</span>';
					listCard +=	'<span>시 / 구 / 군 : ${list.relax_sido_nm}</span>';
					listCard +=	"<span>가게명 : ${list.relax_rstrnt_nm}</span>";
					listCard +=	"<span>전화번호 : ${list.relax_rstrnt_tel}</span>";
					listCard +=	"<span>업 종 : ${list.relax_gubun_detail}</span>";
					listCard +=	"<span>대 표 : ${list.relax_rstrnt_represent}</span>";
					listCard +=	'</div>';
					listCard +=	'</div>';
				}
			</c:forEach>
		$('#listCard').append(listCard);
			
		var startnum;
		var endnum;
		
		var viewnum = 10;
		var totalPage = Math.ceil(totalCnt/printlist);	// 총 페이지 수 구하는 식
		
		indexpage = pagenum.toFixed(1);
		console.log("인덱스 넘버 : "+indexpage);
		if(indexpage == 0 || indexpage == 1 || indexpage == null){
			startnum = 1;
			endnum = 10;
		} else{
			startnum = Math.floor((indexpage-0.1)/viewnum)*viewnum+1;
			endnum = Math.floor(startnum/viewnum+1)*viewnum;
		}
		
		if(endnum>totalPage){
			endnum = totalPage;
		}
		console.log("토탈페이지 : "+totalPage);
		console.log("스타트 넘버 : "+startnum);
		console.log("엔드 넘버 : "+endnum);
		$('#pageing').empty();
		var page = "";
			if(endnum>10){
				page += '<div id="prev" onclick="paging('+(startnum-1)+')" style="cursor: pointer;"> 이전 </div>';
			}
			for(var i=startnum; i<=endnum; i++){
				if(indexpage == i){
					page += '<div class="paging-num" style="cursor: pointer; color: red;" onclick="paging('+i+')">'+i+'</div>';
					continue;
				}
				page += '<div class="paging-num" style="cursor: pointer;" onclick="paging('+i+')">'+i+'</div>';
			}
			if(endnum < totalPage){
				page += '<div id="next" onclick="paging('+(endnum+1)+')" style="cursor: pointer;"> 다음 </div>';
			}
	
		$('#pageing').append(page);
	}
	
	function selectSearch(str){
		$.ajax({
			type : "GET",
			url : "/ajax/selsido",
			data : {
				"sido" : str
			},
			success : function(data){
				$('#selgu').empty();
				for(var i=0; i<data.length; i++){
					$('#selgu').append("<option>"+data[i]+"</option>");
				}
				if(sigugun!=''){
					$("#selgu").val(sigugun).prop("selected", true);
				}
			}
		});
	}
	
	function categorySelect() {
		var frm = categoryselectbox;
		
		if(frm.sido.value == ""){
			alert('광역시 / 도를 선택해주시기 바랍니다.');
			return;
		}
		
		if(confirm('선택한 지역을 검색하시겠습니까?')){
			frm.submit();
		}else{
			alert('취소하셨습니다.');
		}
	}
</script>
<%@include file="/WEB-INF/views/include/footer.jsp"%>