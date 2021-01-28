<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
	/* 컨텐츠 */
    .content-container{
        display: flex;
        width: 100%;
        margin-top: 50px;
    }
    .content-null{
        width: 20%;
    }
    .content{
        width: 60%;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .content-select{
    	width: 60%;
        display:flex;
    }
    .content-select > select{
		width: 40%;
		height: 34px;
    }
    #selgu{
    	margin-left: 20px;
    }
    .select-btn{
    	cursor: pointer;
    	height: 100%;
    	width: 30px;
    	background-color: white;
    	border: 0;
    }
    .select-btn:hover{
		opacity: 0.5;
    }
    .search{
        width: 40%;
        text-align: right;
        position: relative;
    }
    .search > input{
    	width: 300px;
    	height: 30px;
    	
    }
    .search > span{
    	border-left: 1px solid black;
    	height: 100%;
		position: absolute;
		top: 50%;
		right: 0;
		transform: translateY(-50%);
		line-height: 36px;
		width: 35px;
		text-align: center;
		cursor: pointer;
    }
    .search > span:hover{
        opacity: 0.5;
    }
   
   	/* 맵(지도) */
    .map-container{
        margin-top: 50px;
        display: flex;
        height: 500px;
    }
    .map-null{
    	width: 5%;
    }
    .map-item{
        border: 1px solid black;
        width: 70%;
    }
    .rank{
    	border:1px solid black;
        width: 20%;
        margin-left: 20px;
        display: flex;
        flex-direction: column;
    }
    .rank-star{
        text-align: center;
    }
    .rank-star > select{
        height: 30px; 
        width: 50%; 
        margin: 10px auto 0 10px;
    }
    .rank-item{
        border-top: 1px solid black; 
        border-bottom: 1px solid black; 
        height: 10%; 
        margin-top: 10px; 
        position: relative;
    }
    .rank-item:last-child{
    	border-bottom: 0; 
    }
    .rank-num{
        border-right: 1px solid black; 
        text-align: center;
        position: absolute; 
        height: 100%; 
        line-height:200%; 
        width: 10%; 
        left: 0;
    }
    .rank-text{
        position: absolute; 
        left: 10%;
        padding-left: 10px;
        width: 90%; 
        height: 100%;
        line-height: 34px;
    }
    
    /* 리스트 */
    .list-container{
        /*border: 1px solid black;*/
        margin-top: 50px;
        display: grid;
        grid-template-columns: repeat(12, 1fr);
        grid-auto-rows: minmax(auto, auto);
    }
    .list-null1{
        grid-column: 1/2;
        /*border: 1px solid black;*/
        text-align: center;
    }
    .list-null2{
        grid-column: 12/13;
        /*border: 1px solid black;*/
        text-align: center;
    }
    .list-content{
        grid-column: 2/12;
        /*border: 1px solid black;*/
        text-align: center;
        display: flex;
        margin-top: 30px;
        flex-wrap: wrap;
        justify-content: space-between;
    }
    .list-content-items{
    	border: 1px solid black;
        width: 32%;
        position: relative; 
        min-height: 200px;
        margin-bottom: 30px;
    }
    .items-imgs{
    	border-right: 1px solid black;
        width: 40%;
        height: 100%;
        position: absolute;
        left: 0;
        cursor: pointer;
    }
  	.items-text{
        padding-left: 10px;
        width: 60%;
        position: relative;
        left: 40%;
        text-align: left;
        font-size: 15px;
        line-height: 34px;
     }
    .paging{
        width: 100%; 
        display: flex; 
        margin: 30px auto 30px auto;
    }
    .paging-null{
        width: 40%;
    }
    .paging-number{
        width: 20%; 
        display: flex; 
        justify-content: space-around;
    }
    .nowPage{
    	cursor: pointer;
    }
    .goNext{
    	cursor: pointer;
    }
    .goPre{
    	cursor: pointer;
    }
    .ment{
    font-size:30px;
    margin-left:40px;
    margin-top:180px;
    }
    a{
    	text-decoration: none;
    	color: black;
    }
</style>

<div class="content-container">
    <div class="content-null"></div>
    <div class="content">
        <div class="content-select">
            <select id="sido" onchange="selectSearch(this.value)">
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
            <select id="selgu">
            	<option value="">시 / 구 / 군 선택하기</option>
            </select>
            <div>
                <button class="select-btn" onclick="clearSearch(); selectSearchClick();">
                	<i class="fas fa-search" style="font-size: 20px;"></i>
               	</button>
            </div>
        </div>
        <div class="search">
            <input type="text" id="searchWord" maxlength=20>
            <span onclick="clearSi(); selectSearchClick();"><i class="fas fa-search" style="font-size: 20px;"></i></span>
        </div>
    </div>
    <div class="content-null"></div>
</div>
<!-- 지도 -->
<!-- 인증키 스크립트 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b297bd3af18e3bd3bc6fb0e7c1c36ddb&libraries=services"></script>
<div class="map-container">
    <div class="map-null"></div>
    <div class="map-item" id="map">
    </div>
    <div class="rank">
        <div class="rank-star">
        	맛집 랭킹 : 
            <select id="byeolSi" onchange="byeolRank(this.value)">
                <option value="basic">광역시 / 도 선택하기</option>
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
        </div>
        <div class="ment">
        	지역을 선택해주세요.
        </div>
    </div>
    <div class="map-null"></div>
</div>
<!-- 리스트 -->
<div class="list-container">
    <div class="list-null1"></div>
    <div class="list-content">
        <div class="paging">
           <div class="paging-null"></div> 
           <div class="paging-number">
           </div>
           <div class="paging-null"></div>
        </div>  
    </div>
    <div class="list-null2"></div>    
</div>

<script>

	var session_id = "${session_id}";
	
	$(function(){
		console.log(sessionStorage.getItem("si")+", "+sessionStorage.getItem("gu"));
		if(sessionStorage.getItem("si") != '' || sessionStorage.getItem("gu") != ''){
			
			var si = sessionStorage.getItem("si");
			var gu = sessionStorage.getItem("gu");
			
			$("#sido").val(si).prop("selected", true);
			selectSearch(si);
			selectSearchClick(1);
			
		}
		
		
	});
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div
	
	mapOption = {
	    center: new kakao.maps.LatLng(37.56680618275856, 126.97865226396553), // 지도의 중심좌표
	    level: 9 // 지도의 확대 레벨
	};  

	//지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	var markers = [];

	
	function selectSearch(str){
		var si;
		var gu = sessionStorage.getItem("gu");
		
		if(str == ''){
			si = $('#sido').val();
		} else{
			si = str;
		}
		
		$.ajax({
			type : "GET",
			url : "/ajax/selsido",
			data : {
				"sido" : si
			},
			success : function(data){
				
				if(data != ""){
					$('#selgu').empty();
				}
				
				for(var i=0; i<data.length; i++){
					$('#selgu').append("<option>"+data[i]+"</option>");
				}
				
				if(sessionStorage.getItem("si") == str ){
					$("#selgu").val(gu).prop("selected", true);
				}
			}
		});
	}
	
	function selectSearchClick(nowPage) {
		var si;
		var gu;
		
		if(sessionStorage.getItem("si") != '' || sessionStorage.getItem("gu") != ''){
			si = sessionStorage.getItem("si");
			gu = sessionStorage.getItem("gu");
		}
		
		si = $('#sido').val();
		gu = $('#selgu').val();
		
		if(gu == "" || gu == null){
			gu = sessionStorage.getItem("gu");
		}
		
		
		
		var searchWord = $('#searchWord').val();
		
		$.ajax({
			type : "GET",
			url : "/ajax/selsidogu",
			data : {
				"sido" : si,
				"selgu" : gu,
				"nowPage" : nowPage,
				"searchWord" : searchWord
			},
			success : function(data){
				
				sessionStorage.setItem("si", si);
				if(sessionStorage.getItem("si") != ''){
					sessionStorage.setItem("gu", gu);
				};
				console.log(sessionStorage.getItem("si")+", "+sessionStorage.getItem("gu"));
				//주소-좌표 변환 객체를 생성합니다
				var geocoder = new kakao.maps.services.Geocoder();
				if(data[0] === "x"){
					
				}else{
					if(data == "" || data == null){
						alert('검색결과가 없습니다.');
						$('.paging-number').empty();
						
						// 주소로 좌표를 검색합니다
						geocoder.addressSearch("서울특별시 중구 세종대로 110", function(result, status) {
						    // 정상적으로 검색이 완료됐으면
						     if (status === kakao.maps.services.Status.OK) {
	
						        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
						        map.setCenter(coords);
						    } 
						});
						
					}
					
					$('.list-content-items').remove();
					
					if(data != null || data != ""){
						
						var ind = 0;
						var dni = 0;
						
						$.each(data, function(index, item) {
							$('.nowPage').remove();
							$('.goPre').remove();
							$('.goNext').remove();
							
							var totalPerPage = 9;
							var nowPage = parseInt(this['nowPage']);
							var startIndex = totalPerPage*(nowPage-1);
							var endIndex = startIndex+(totalPerPage-1);
							
							if(index>=startIndex && index<=endIndex){
								var resName = this['RELAX_RSTRNT_NM'];
								if(resName.length > 8){
									resName = resName.substring(0,8)+"...";
								}
								var str = '<div class="list-content-items">';
							    str += "<a href='/board/detailpage?code="+ this['RELAX_SEQ']+"'><img class='items-imgs' src='resources/img/burger-4955630_1280.png'></a>"
							    +"<div class='items-text'>업종 : "+this['RELAX_GUBUN']+"</div>"
							    +"<div class='items-text'>대표자명 : "+this['RELAX_RSTRNT_REPRESENT']+"</div>"
							    +"<div class='items-text'>업종상세 : "+this['RELAX_GUBUN_DETAIL']+"</div>"
							    +"<div class='items-text'>전화번호 : "+this['RELAX_RSTRNT_TEL']+"</div>"
							    +"<div class='items-text'>가게명 : <span>"+resName+"</span></div>"
							    +"<div class='items-text'>안심식당 지정일 : "+this['date']+"</div>";
								
							    if(session_id != ""){
							    	if(this['like'] == 0){
								    	str += "<div id='un-like"+this['RELAX_SEQ']+"' style='cursor: pointer; position: absolute; right: 10px; bottom: 10px;'><i class='far fa-heart' onclick='likejim("+this['RELAX_SEQ']+","+JSON.stringify(this['date'])+")'></i></div>"
								    		 + "<div id='like"+this['RELAX_SEQ']+"' style='cursor: pointer; position: absolute; right: 10px; bottom: 10px; display : none'><i class='fas fa-heart' onclick='unLike("+this['RELAX_SEQ']+")'></i></div>";
								    }else{
								    	str += "<div id='un-like"+this['RELAX_SEQ']+"' style='cursor: pointer; position: absolute; right: 10px; bottom: 10px; display : none'><i class='far fa-heart' onclick='likejim("+this['RELAX_SEQ']+")'></i></div>"
							    		 + "<div id='like"+this['RELAX_SEQ']+"' style='color : red; cursor: pointer; position: absolute; right: 10px; bottom: 10px;'><i class='fas fa-heart' onclick='unLike("+this['RELAX_SEQ']+")'></i></div>";
								    }
							    }
							    
							    str += '</div>';
								
								$('.list-content').prepend(str).addClass('list-content');
								
								var storename = resName;
								// 주소로 좌표를 검색합니다
								geocoder.addressSearch(this['RELAX_ADD1'], function(result, status) {
									// 정상적으로 검색이 완료됐으면 
								     if (status === kakao.maps.services.Status.OK) {
									
								        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
								        
								        // 결과값으로 받은 위치를 마커로 표시합니다
								        var marker = new kakao.maps.Marker({
								            position: coords
								        });
		
								        if(markers.length == 9){
								        	for(var i=0; i<markers.length; i++){
								        		markers[i].setMap(null);
								        	}
								        	markers = [];
								        }
								        
								        markers.push(marker);
	
								        for(var i=0; i<markers.length; i++){
									        markers[i].setMap(map);
								        }
								       
								        //<div style="width:150px;text-align:center;padding:6px 0;"></div>
								     	// 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
								        var iwContent = '<a href="/board/goDetail?rname='+storename+'">'+storename+'</a>', 
								        	// 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
								        	iwRemoveable = true; // removeable 속성을 true 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다
										
										
								        // 인포윈도우를 생성합니다
								        var infowindow = new kakao.maps.InfoWindow({
								            content : iwContent,
								            removable : iwRemoveable
								        });
										
								         
								        // 마커에 클릭이벤트를 등록합니다
								        kakao.maps.event.addListener(marker, 'click', function() {
								              // 마커 위에 인포윈도우를 표시합니다
								              infowindow.open(map, marker);  
								        });
								        
								        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
								        if(dni == 0){
								        	map.setCenter(coords);
								        }
								        dni = dni + 1;
								    } 
								});
								ind = ind + 1;
							}
							
							var totalPerPage = 9;
							var totalCount = data.length;
							var pageCount;
							if(totalCount%totalPerPage == 0){
								pageCount = parseInt(totalCount / totalPerPage);
							}else{
								pageCount = parseInt(totalCount / totalPerPage) + 1;
							}
							
							var pageStr = "";
							var blockPerPage = 5;
							var blockCount;
							if(pageCount%blockPerPage == 0){
								blockCount = parseInt(pageCount / blockCount);
							}else{
								blockCount = parseInt(pageCount / blockCount) + 1;
							}
							var nowBlock;
							if(nowPage%blockPerPage == 0){
								nowBlock = parseInt(nowPage / blockPerPage);
							}else{
								nowBlock = parseInt(nowPage / blockPerPage) + 1;
							}
							var startPage = ((nowBlock-1)*blockPerPage) + 1;
							var endPage = nowBlock * blockPerPage;
							if(endPage > pageCount){
								endPage = pageCount;
							}
							
							
							if(startPage > blockPerPage){
								nowPage = startPage - blockPerPage;
								pageStr += "<span class='goPre' onclick='selectSearchClick("+nowPage+")'>&lt;&lt;</span>";
							}
							var i;
							for(i=startPage; i<=endPage; i++){
								if(nowPage == i){
									pageStr += "<span class='nowPage' style='font-weight:bold;color:red;' onclick='selectSearchClick("+i+")'>"+i+"</span>";
								}else{
									pageStr += "<span class='nowPage' onclick='selectSearchClick("+i+")'>"+i+"</span>";
								}
							}
							if(endPage < pageCount){
								nowPage = endPage + 1;
								pageStr += "<span class='goNext' onclick='selectSearchClick("+nowPage+")'>&gt;&gt;</span>";
							}
							
							$(".paging-number").append(pageStr);
						});
					}
				}
			}
		});
	}
	
	function clearSi(){
		$("#sido").val("");
		$("#selgu").empty();
		$("#selgu").append("<option value=''>시 / 구 / 군 선택하기</option>");
	}
	
	function clearSearch(){
		$("#searchWord").val("");
	}
	
	function byeolRank(si){
		var si = $("#byeolSi").val();
		
		$.ajax({
			type : "post",
			url : "/ajax/byeolRank",
			data : {
				"si" : si
			},
			success : function(data){
				$(".rank-item").remove();
				$(".ment").remove();
				
				var str = "";
				
				if(si == "basic"){
					str += "<div class='ment'>지역을 선택해주세요.</div>";
				}else{
					if(data.length < 10){
						str += "<div class='ment'>리뷰가 부족합니다.</div>";
					}else{
						$.each(data, function(index, item){
							str += '<div class="rank-item">'
									+'<span class="rank-num">'+(index+1)+'</span>'
									+'<div class="rank-text"><a href="/board/detailpage?code='+this['storecode']+'">'+this['storename']+'</a></div></div>';
						});
					}
				}

				$(".rank").append(str);
			}
		});
	}
	
	
	function likejim(aaa, date){
		var like = 0;
		var code = aaa;
		
		$.ajax({
			type : "GET",
			url : "/ajax/like",
			data : {
				"code" : code,
				"like" : like,
				"date" : date
 			},
			success : function(data){
				$.each(data, function(index, item) {
					if(this['likechk'] == 1){
						$('#un-like'+aaa).css('display', 'none');
						$('#like'+aaa).css({
							'display': 'block',
							'color' : 'red'	
						});
					}
				});
			}
		});
	}
	
	function unLike(bbb){
		var like = 1;
		var code = bbb;
		$.ajax({
			type : "GET",
			url : "/ajax/like",
			data : {
				"code" : code,
				"like" : like
			},
			success : function(data){
				$.each(data, function(index, item) {
					if(this['likechk'] == 0){
						$('#like'+bbb).css('display', 'none');
						$('#un-like'+bbb).css({
							'display': 'block'
						});
					}
				});
			}
		});
	}
	
</script>