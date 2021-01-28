<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page isELIgnored="false" %>    
<%@ include file="/WEB-INF/views/include/nav.jsp"%>

<style>
	/* 디테일 페이지 */
	/* 가게 정보 */
	.head-text{
		margin-top: 100px;
		width: 100%; 
		text-align: center; 
	}
    .container{
        margin-top: 50px;
        width: 100%;
        display: flex;
    }
    .depa-null{
        width: 20%;
    }
    .depa-content{
        display: flex;
        width: 60%;
        align-items: center;
    }
    .depa-co-img{
    	width: 20%;
    }
    .depa-co-img > img{
    	max-width: 100%; 
    	border: 1px solid black;
    }
    .depa-co-info{
        width: 60%;
        height: 100%;
        display: flex;
        flex-direction: column;
        justify-content:space-around;  
    }
    .depa-co-de-text{
    	width: 100%;
    	padding-left: 20px;
    }
    .depa-co-btn{
        width: 20%;
        height: 100%;
        text-align: center;
    }
    .depa-co-btn > button{
        cursor: pointer;
        height: 30px;
        width: 100%;
        background-color: #FAFFFA;
        border-radius: 5px;
        box-sizing: border-box;
        box-shadow: 1px 1px 5px;
    }
    .depa-co-btn > button:active{
    	background-color: #F2D4FF;
    	color: white;
    	font-weight: bold;
    }
    .depa-co-btn-btns{
    	margin-top: 10px;
    	height: 40px;
    	display: flex;
    	flex-direction: column;
    	justify-content: space-between;
    }
    .depa-co-btn-btns > button{
    	width: 100%;
    	height: 30px;
    	border-radius: 5px;
    	box-shadow: 1px 1px 5px;
    	cursor: pointer;
    }
    
    /* 리뷰 */
    .depa-review{
    	display: flex; 
    	margin-top: 100px;
    	width: 100%;
    }
    .review-content{
    	width: 60%;
    }
    .re-co-head-text{
    	display: flex; 
    	justify-content: space-between; 
    	height: 50px; 
    	align-items: center; 
    	margin: auto 50px
    }
    .re-co-head-text > button{
    	cursor: pointer;
        height: 30px;
        background-color: #FAFFFA;
        border-radius: 5px;
        box-sizing: border-box;
        box-shadow: 1px 1px 5px;
    }
    .re-co-head-text > button:active{
    	background-color: #F2D4FF;
    	color: white;
    	font-weight: bold;
    }
    #review-frm{
    	position: relative;
    	display: none;
    }
    .no-color-star{
    	margin-top: 20px;
    	margin-left: 20px;
    }
    .color-star{
    	position: absolute;
    	top:0;
    	margin-left: 20px;
    }
    .fs{
        margin: 0;
        display: none;
        cursor: pointer;
    }
    .fsa{
    	margin: 0;
    	cursor: auto;
    }
    i{
        cursor: pointer;
    }
    .review-list{

    }
    .list-starpoint{
    	margin-left: 30px; 
    	margin-top: 20px;
    }
    .review-list-content{
    	display: flex; 
    	align-items: center;
    }
    .review-list-content-btn{
    	width: 10%; 
    	height: 94px;
    	display: flex;
    	flex-direction: column;
    	justify-content: space-around;
    	align-items: center;
    }
    .review-list-content-btn > button{
    	width: 50%;
    	height: 30px;
    	cursor: pointer;
    	font-weight: bold;
    	color: white;
    	border-radius: 5px; 
    }
    
    /* 포토 리스트  */
    .review-poto{ 
    	display: flex; 
    	margin-top: 100px;
    }
    .poto-btn{
    	display: flex; 
    	justify-content: space-between; 
    	height: 50px; 
    	align-items: center; 
    	margin: auto 50px;
    }
    .poto-btn > button{
    	cursor: pointer;
        height: 30px;
        width: 80px;
        background-color: #FAFFFA;
        border-radius: 5px;
        box-sizing: border-box;
        box-shadow: 1px 1px 5px;
    }
    .poto-btn > button:active{
    	background-color: #F2D4FF;
    	color: white;
    	font-weight: bold;
	}
    #numPeople{
    	width:20px;
    }
    
    /* 기타 */
    #date{
    	 width:90%; 
    	 height:30px;
    }
    #time{
    	 width:90%; 
    	 height:30px;
    }
    #peoplecnt{
    	width:100%;
    	margin-top:10px;
    }
    #numPeople{
    	text-align: center;
    	width: 50%;
    	height:30px;
    }
    .inStoreClick > button{
    	width: 100%;
    	height: 30px;
    	border-radius: 5px;
    	box-shadow: 1px 1px 5px;
    	cursor: pointer;
    }
    #menufrm{
    	border:1px solid black; 
    	display: flex; 
    	align-items: center; 
    	justify-content: space-around; 
    	margin-top: 20px;
    	flex-wrap: wrap;
    	
    }
</style>

<c:if test='${session_id == null || session_id == ""}'>
	<script>
		alert('로그인을 해주시기 바랍니다.');
		location.href="/member/login";
	</script>
</c:if>

<div class="head-text">
    <h1>${store.relax_rstrnt_nm }</h1>
</div>
<div class="container">
    <div class="depa-null"></div>
    <div class="depa-content">
        <div class="depa-co-img">
            <img src="/resources/img/burger-4955630_1280.png" alt="">
        </div>
        <div class="depa-co-info">
            <div class="depa-co-de-text">
                상 호 명 : ${store.relax_rstrnt_nm }
            </div>
            <div class="depa-co-de-text">
                주  소 : ${store.relax_add1 }
            </div>
            <div class="depa-co-de-text">
                전 화 번 호 : ${store.relax_rstrnt_tel }
            </div>
            <div class="depa-co-de-text">
                안심식당 지정일 : ${store.date }
            </div>
            <div class="depa-co-de-text">
                대 표 자 : ${store.relax_rstrnt_represent }
            </div>
        </div>
        <div class="depa-co-btn">
        	<table id="calendar" style="border:1px solid black; width: 100%;">
	        	<tr>
	        		<td style="border:1px solid black;" onclick='pervMonth()'><i class="fas fa-chevron-left"></i></td>
	        		<td id="tbCalendarYM" style="border:1px solid black;" colspan="5"></td>
	        		<td style="border:1px solid black;" onclick='nextMonth()'><i class="fas fa-chevron-right"></i></td>
	        	</tr>
	        	<tr>
	        		<td style="border: 1px solid black; color: red">일</td>
	        		<td style="border: 1px solid black;">월</td>
	        		<td style="border: 1px solid black;">화</td>
	        		<td style="border: 1px solid black;">수</td>
	        		<td style="border: 1px solid black;">목</td>
	        		<td style="border: 1px solid black;">금</td>
	        		<td style="border: 1px solid black; color: blue">토</td>
	        	</tr>
        	</table>
            <button id="yeyag">예약하기</button>
            <div class="depa-co-btn-btns">
            	<button id="inStore">매장 식사</button>
            </div>
            <div class="inStoreClick">
            	<div style="width:100%; margin-top:10px;">
					<input type="date" id="date" onchange="dateChange(this.value)">
				</div>
				<div style="width:100%; margin-top:10px;">
					<input type="time" id="time" onchange="timeChange(this.value)">
				</div>
            	<div id="peoplecnt">
            		<i class="fas fa-minus" onclick="minusNum()"></i>
            		<input id="numPeople" value="1" readonly="readonly">
            		<i class="fas fa-plus" onclick="plusNum()"></i>
            	</div>
            	<button style="margin-top:10px;" onclick="reservate()">예약하기</button>
            	<button style="margin-top:10px;" onclick="forgiveRes()">취소하기</button>
            </div>
        </div>
    </div>
    <div class="depa-null"></div>
</div>
<div class="depa-review">
    <div class="depa-null"></div>
    <div class="review-content">
    	<div style="margin: 0 auto 50px auto">
    		<c:if test="${session_storecode != null && session_storecode == svo.storecode }">
    			<button id="menuInsert" style="cursor: pointer; height: 30px;">메뉴 작성하기</button>
    			<div id="menupan">
	    			<form id="menufrm" name="menuInfo" action="menu" method="post" enctype="multipart/form-data">
	    				<div style="width: 25%;">
	    					<input type="file" name="file">
	    				</div>
	    				<div style="display: flex; flex-direction: column; margin-left: 10px;">
	    					<div style="margin-top: 10px; display: flex; justify-content: space-between;">
	    						<div>가 격 : <input name="price" id="price" style="height: 20px; width: 150px;"></div>
	    					</div>
	    					<div style="margin-top: 10px;">
	    						<textarea rows="10" cols="90" name="content"></textarea>
	    					</div>
	    				</div>
		    			<div style="text-align: right;">
	   						<button type="button" style="cursor: pointer; height: 30px;" onclick="menuUpload()">작성하기</button>
	    				</div>
	    			</form>
	    		</div>
    		</c:if>
    	</div>
    	<c:forEach var="menu" items="${menu }">
	    	<div id="mu${menu.uid }" style="border:1px solid black; display: flex; align-items: center; margin-top: 30px;">
				<div id="menuing${menu.uid }" style="width: 25%; text-align: center;" >	
					<img alt="" src="/resources/upload/${menu.file }" style="max-width: 100%; max-height: 150px;">
				</div>
				<div style="display: flex; flex-direction: column; margin-left: 10px;">
					<div id ="menuprice${menu.uid }" style="margin-top: 10px;">
						가 격 : <fmt:formatNumber value="${menu.price }" type="currency"/>
					</div>
					<div id="menutext${menu.uid}" style="margin-top: 10px;">
						<textarea rows="10" cols="90" readonly="readonly" style="background-color: rgba(0,0,0,0.1)">${menu.content }</textarea>
					</div>
				</div>
				<c:if test="${session_storecode != null }">
					<div id="changebutn${menu.uid }" style="margin-left: 20px; display: flex; flex-direction: column; align-items: center;">
						<button style="height: 50px; width: 50px; margin-top: 30px; cursor: pointer;" onclick="menuUpdate(${menu.uid}, '${menu.file}', ${menu.price }, '${menu.content }')">수정</button>
						<button style="height: 50px; width: 50px; margin-top: 30px; cursor: pointer;" onclick="menuDel(${menu.uid})">삭제</button>
					</div>
				</c:if>
			</div>
		</c:forEach>
        <div class="re-co-head-text" style="margin-top: 100px">
            <h2>방문자 리뷰</h2>
            <button style="cursor: pointer; height: 30px; width: 100px;" onclick="showReview()">리뷰 작성하기</button>
        </div>
        <form id="review-frm" method="post" enctype="multipart/form-data">
        	<input type="hidden" id="starscore" name="starpoint">
        	<input type="hidden" name="storecode" value="${store.relax_seq }">
        	<input type="hidden" name="dosi" value="${store.relax_si_nm }">
        	<input type="hidden" name="sigugun" value="${store.relax_sido_nm }">
        	<input type="hidden" name="address" value="${store.relax_add1 }">
        	<input type="hidden" name="storename" value="${store.relax_rstrnt_nm }">
            <div class="no-color-star">
                <i class="far fa-star" onclick="changeStar(1)"></i>
                <i class="far fa-star" onclick="changeStar(2)"></i>
                <i class="far fa-star" onclick="changeStar(3)"></i>
                <i class="far fa-star" onclick="changeStar(4)"></i>
                <i class="far fa-star" onclick="changeStar(5)"></i>
            </div>
            <div class="color-star">
                <i class="fas fa-star fs" onclick="changeStar1(1)"></i>
                <i class="fas fa-star fs" onclick="changeStar1(2)"></i>
                <i class="fas fa-star fs" onclick="changeStar1(3)"></i>
                <i class="fas fa-star fs" onclick="changeStar1(4)"></i>
                <i class="fas fa-star fs" onclick="changeStar1(5)"></i>
            </div>
            <div style="display: flex; align-items: center; margin-top: 10px;">
                <div style="width: 80%; height: 100px; text-align: center;">
                   <textarea name="comment" rows="6" style="width: 95%;" placeholder="리뷰를 작성해 주시기 바랍니다."></textarea>
                </div>
                <input type="file" name="file" style="cursor: pointer;">
                <button type="button" style="width: 100px; margin-right: 30px; cursor: pointer;" onclick="reviewInsert()">작성하기</button>
            </div>
        </form>
        <c:forEach var="review" items="${review }">
        	<div id="review${review.uid }" class="review-list">
	            <div class="list-starpoint">
	            	<c:choose>
	            		<c:when test="${review.starpoint == 1}">
			                <i class="fas fa-star fsa" style="color:gold"></i>
			                <i class="fas fa-star fsa"></i>
			                <i class="fas fa-star fsa"></i>
			                <i class="fas fa-star fsa"></i>
			                <i class="fas fa-star fsa"></i>
		                </c:when>
		                <c:when test="${review.starpoint == 2}">
			                <i class="fas fa-star fsa" style="color:gold"></i>
			                <i class="fas fa-star fsa" style="color:gold"></i>
			                <i class="fas fa-star fsa"></i>
			                <i class="fas fa-star fsa"></i>
			                <i class="fas fa-star fsa"></i>
		                </c:when>
		                <c:when test="${review.starpoint == 3}">
			                <i class="fas fa-star fsa" style="color:gold"></i>
			                <i class="fas fa-star fsa" style="color:gold"></i>
			                <i class="fas fa-star fsa" style="color:gold"></i>
			                <i class="fas fa-star fsa"></i>
			                <i class="fas fa-star fsa"></i>
		                </c:when>
		                <c:when test="${review.starpoint == 4}">
			                <i class="fas fa-star fsa" style="color:gold"></i>
			                <i class="fas fa-star fsa" style="color:gold"></i>
			                <i class="fas fa-star fsa" style="color:gold"></i>
			                <i class="fas fa-star fsa" style="color:gold"></i>
			                <i class="fas fa-star fsa" ></i>
		                </c:when>
		                <c:when test="${review.starpoint == 5}">
			                <i class="fas fa-star fsa" style="color:gold"></i>
			                <i class="fas fa-star fsa" style="color:gold"></i>
			                <i class="fas fa-star fsa" style="color:gold"></i>
			                <i class="fas fa-star fsa" style="color:gold"></i>
			                <i class="fas fa-star fsa" style="color:gold"></i>
		                </c:when>
	                </c:choose>
	            </div>
	            <div class="review-list-content">
	                <div style="width: 70%; height: 100px; text-align: center; margin-top: 10px;">
	                   <textarea name="" id="review-text" cols="" rows="6" style="width: 95%;" readonly>${review.comment }</textarea>
	                </div>
	                <c:if test="${fn:length(review.flie_o) > 37}">
               			<img src="/resources/upload/${review.flie_o }" alt="사진없음" style="width: 20%; max-height: 100px;">
               		</c:if>
		            <div class="review-list-content-btn">
		            	<c:if test="${session_id == review.id }">
			                <button style="background-color: #DC3545" onclick="reviewDelete(${review.uid})">삭제</button>
		                </c:if>
		               <c:if test="${session_storecode == svo.storecode}">
			                <button style="background-color: #0D6EFD" onclick="reviewModify(${review.uid})">답글</button>
		                </c:if>
		            </div>
	            </div>
              	<div style="margin-left: 30px; ">
                    작성자 : ${review.id } / 작성일시 : ${review.signdate }
                </div>
                <c:forEach var="comment" items="${comment }">
	                <c:if test="${review.fid == comment.fid }">
	                	<div style="margin-left: 50px; display: flex; align-items: center;">
	                	<i class="fas fa-level-up-alt" style="transform: rotate(90deg); font-size: 50px;"></i>
			                <div style="width: 70%; height: 100px; text-align: center; margin-top: 10px;">
			                   <textarea name="" id="review-text" cols="" rows="6" style="width: 95%;" readonly>${comment.content }</textarea>
			                </div>
			                <div style="margin-left: 30px; ">
	                    	작성자 : ${comment.id } 
				            <div>
				                <button style="background-color: #DC3545; height: 50px; width: 50px;" onclick="reviewDelete(${commnet.uid})">삭제</button>
				            </div>
	                	</div>
		            	</div>
	                </c:if>
                </c:forEach>
        	</div>
        </c:forEach>
        <div>
           	<form id="reply" action="/board/replyInsert" method="post">
  				<input type="hidden" name="reuid" value=""> 
           		<textarea name="recomment" rows="10" cols="120"></textarea>
           		<button type="button" onclick="replyInsert()">답변 달기</button>
           	</form>
        </div>
    </div>
    <div class="depa-null"></div>
</div>
<div class="review-poto">
    <div class="depa-null"></div> 
    <div style="width: 60%;">
        <div class="poto-btn">
            <h2>사진</h2>
            <button style="cursor: pointer; height: 30px;" onclick="#">모두보기</button>
        </div>
        <div></div>
        <div style="display: flex; flex-wrap: wrap; width: 100%; margin-top: 30px;">
        	<c:forEach var="review" items="${review }">
        		<c:if test="${fn:length(review.flie_o) > 37}">
		            <div style="width: 22%; border: 1px solid black; margin: 10px; text-align: center; ">
		                <img src="/resources/upload/${review.flie_o }" alt="사진없음" style="width: 100%; max-height: 100px;">
		            </div>
		        </c:if>
            </c:forEach>
        </div>
    </div>
    <div class="depa-null"></div>  
</div>

<script>
	var replayuid;
	
	$('#reply').hide();
	
	function replyInsert(){
		var uid = replayuid;	// 게시글의 uid
		var re = document.getElementById('reply');
		re.reuid.value=uid;
		if(!re.recomment.value){
			alert('답글을 작성해 주시기 바랍니다.');
			re.recomment.focus();
			return;
		}
		
		re.submit();
	}

	function reviewModify(num){
		$('#reply').toggle();
		$('#review'+num+'').append($('#reply'));
		replayuid = num;
		return replayuid;
	}
	
	function menuUpdate(uid, aaa, price, content){
		$('#mu'+uid+'').empty();
		var str = '<form id="UpdateMenu" name="UpdateMenu" action="updatemenu" method="post" enctype="multipart/form-data" style="display:flex; align-items: center; ">';
			str += '<input type="hidden" name="uid" value="'+uid+'">'
			str += '<div style="display:flex; flex-direction: column; text-align:center;">';
			str += '<div><img alt="" src="/resources/upload/'+aaa+'" style="max-width: 100%; max-height: 150px;"></div>';
			str += '<div><input type="file" name="file"></div>';
			str += '</div>';
			str += '<div style="display:flex; flex-direction: column;">';
			str += '<div>가 격 : <input name="price" value="'+price+'"></div>'
			str += '<div><textarea name="content" id="review-text" cols="90" rows="10">'+content+'</textarea></div>'
			str += '</div>';
			str += '<div style="margin-left:20px;"><button type="button" style="height:50px;" onclick="MenuUpdate()">수정하기</button></div>';
			str += '</form>'
			$('#mu'+uid+'').append(str);
	}
	function MenuUpdate(){
		var upmenu  = document.getElementById('UpdateMenu');
		
		if(confirm('해당 메뉴를 수정하시겠습니까?')){
			upmenu.submit();
		}
	}
	
	function menuDel(uid){
		var code = ${param.code}
		if(confirm('삭제하시겠습니까?')){
			location.href="/board/deleteMenu?uid="+uid+"&code="+code;
		}
	}
	
	function menuUpload(){
		var menu = document.getElementById('menufrm');
		
		if(!menu.file.value){
			alert('메뉴 사진을 등록해주시기 바랍니다.');
			return;
		}
		if(!menu.price.value){
			alert("가격을 입력해 주시기 바랍니다.");
			menu.price.focus();
			return;
		}
		if(!menu.content.value){
			alert('메뉴 설명란을 입력해 주시기 바랍니다.');
			menu.content.focus();
			return;
		}
		menu.submit();
	}
	
 	$('#menupan').hide();
	$('#menuInsert').click(function(){
		$('#menupan').toggle();
	});
	
	//캘린더
	var today = new Date();
	var date = new Date();
	
	nowCalendar();
	
	function nowCalendar(){
		var doMonth = new Date(today.getFullYear(),today.getMonth(),1);		// 이번달의 첫번째 날
		var lastDate = new Date(today.getFullYear(),today.getMonth()+1,0);	// 이번달의 마지막 날
		var tbCalendar = document.getElementById("calendar");
		var nowYM = document.getElementById('tbCalendarYM');
		var nowtime = today;
		nowYM.innerHTML = today.getFullYear() + "년 " + (today.getMonth() + 1) + "월";
		
		while (tbCalendar.rows.length > 2) {
	        tbCalendar.deleteRow(tbCalendar.rows.length-1);  
	    }
		
		var row = null;
	    row = tbCalendar.insertRow();
	    
	    var cnt = 0;
	    
	    for (i=0; i<doMonth.getDay(); i++) {
	        cell = row.insertCell();
	        cnt = cnt + 1;
	    }
	    
	  
	    for (i=1; i<=lastDate.getDate(); i++) { 
	   
	        cell = row.insertCell();
	        cell.innerHTML = "<span style='cursor: pointer;' onclick='yayag("+today.getFullYear()+","+(today.getMonth()+1)+","+i+")'>"+i+"<span>";
	        cnt = cnt + 1;
	
	    	if (cnt % 7 == 1) {
	    		cell.innerHTML = "<span style='color: #F79DC2; cursor: pointer;' onclick='yayag("+today.getFullYear()+","+(today.getMonth()+1)+","+i+")'>"+i+"<span>";
	   		} 
	    	
	     	if (cnt%7 == 0){
	        	cell.innerHTML = "<span style='color:skyblue; cursor: pointer;' onclick='yayag("+today.getFullYear()+","+(today.getMonth()+1)+","+i+")'>"+i+"<span>";
	          	row = calendar.insertRow();
	     	}
	     	
	    	 if (today.getFullYear() == date.getFullYear() && today.getMonth() == date.getMonth() && i == date.getDate()) {
	       		cell.bgColor = "#FAF58C";//셀의 배경색을 노랑으로 
	      	}
	    }    
	}
	
	function yayag(num1, num2, num3){
		
		if(String(num2).length == 1){
			num2 = "0"+num2;
			
		}
		if(String(num3).length == 1){
			num3 = "0"+num3;
		}
		
		var str = num1+"-"+num2+"-"+num3;
		
		var date = document.getElementById('date');
		date.value = str;
		
		$.ajax({
			type : "post",
			url : "/board/dateCheck",
			data : {
				"date" : date.value
			},
			success : function(data){
				
				if(data == "past"){
					alert("오늘 이후의 날짜를 선택해주세요.");
					$("#date").val("");
				}else if(data == "three"){
					alert("같은 날짜에 최대 3회의 예약이 가능합니다.\n해당 날짜에 이미 3건의 예약이 있습니다.\n예약 목록은 마이페이지에서 확인이 가능합니다.");
					$("#date").val("");
				}else{
					
				}
				
			}
		});
	}
	
	function pervMonth() {
		today = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());
		nowCalendar();
	}
	
	function nextMonth(){
		today = new Date(today.getFullYear(), today.getMonth() + 1, today.getDate());
		nowCalendar();
	}
	
	$('.depa-co-btn-btns').css('display', 'none');
	$(".inStoreClick").css("display", "none");
	$('#yeyag').click(function(){
		var id = "${session_id}";
		
		if(id == null || id == ""){
			alert("로그인 후 이용 가능합니다.");
			return;
		}else{
			$('.depa-co-btn-btns').stop().fadeToggle(500);
		}
	})

	var score;		// 디비에담을 별점
	
	function showReview(){
	    $('#review-frm').stop().fadeToggle(500);
	}
	
	function changeStar(num){
	    score = num;
	    var st = document.getElementsByClassName('far');
	    var ts = document.getElementsByClassName('fs');
	    
	    for(var i=0; i<num; i++){
	        ts[i].style.display = "inline-block";
	        ts[i].style.color = "gold";
	    }
	    return score;
	}
	
	function changeStar1(num){
	    score = num;
	    var st = document.getElementsByClassName('far');
	    var ts = document.getElementsByClassName('fs');
	    
	    for(var i=0; i<5; i++){
	        if(i<num){
	            ts[i].style.display = "inline-block";
	            ts[i].style.color = "gold";
	            
	        }else{
	         
	            ts[i].style.display = "none";   
	        }
	    }
	    return score;
	}
	
	function reviewInsert(){
		var frmReview = document.getElementById('review-frm');
		var starscore = document.getElementById('starscore');
		starscore.value = score;
		if(score == null){
			alert('별점을 입력해 주시기바랍니다.');
			return;
		} else if(frmReview.comment.value == ""){
			alert('리뷰 내용을 입력해 주시기 바랍니다.');
			frmReview.comment.focus();
			return;
		}
		
		frmReview.submit();
	}
	
	function reviewDelete(uid){
		var con = confirm('정말로 삭제하시겠습니까?');
		var code = ${param.code};
		var date = '${param.date}';

		if(con == true){
			location.href="/board/reviewDelete?uid="+uid+"&code="+code+"&date="+date;
		}
	}
	
	//value='"+ya+"'
	$("#inStore").click(function(){
		
		$("#yeyag").css("display", "none");
		$(".depa-co-btn-btns").css("display","none");
		$(".inStoreClick").css("display", "block");
		
	});
	
	function reservate(){
		var code = "${store.relax_seq }";
		var name = "${store.relax_rstrnt_nm }";
		var tel = "${store.relax_rstrnt_tel }";
		var safe_date = "${store.date }";
		var addr = "${store.relax_add1 }";
		var reserv_date = $("#date").val();
		var reserv_time = $("#time").val();
		var numPeople = $("#numPeople").val();
		
		if(!reserv_date){
			alert("날짜를 선택해주세요.");
			$("#date").focus();
			return;
		}
		if(!reserv_time){
			alert("시간을 선택해주세요.");
			$("#time").focus();
			return;
		}
		
		$.ajax({
			type : "post",
			url : "/board/reserv_inStore",
			data : {
				"code" : code,
				"res_name" : name,
				"res_tel" : tel,
				"res_date" : safe_date,
				"res_addr" : addr,
				"reserv_date" : reserv_date,
				"reserv_time" : reserv_time,
				"peopleNum" : numPeople
			}, 
			success : function(data){
				alert("예약이 완료되었습니다.");
				location.href="/board/detailpage?code="+data.code+"&date="+data.date;
			}
		});
	}
	
	function forgiveRes(){
		$("#yeyag").css("display", "block");
		$(".inStoreClick").css("display", "none");
		
	}
	
	function dateChange(date){
		$.ajax({
			type : "post",
			url : "/board/dateCheck",
			data : {
				"date" : date
			},
			success : function(data){
				
				if(data == "past"){
					alert("오늘 이후의 날짜를 선택해주세요.");
					$("#date").val("");
				}else if(data == "three"){
					alert("같은 날짜에 최대 3회의 예약이 가능합니다.\n해당 날짜에 이미 3건의 예약이 있습니다.\n예약 목록은 마이페이지에서 확인이 가능합니다.");
					$("#date").val("");
				}else{
					
				}
				
			}
		});
	}
	
	function timeChange(time){
		var reserv_date = $("#date").val();
		
		if(!reserv_date){
			alert("날짜를 선택해주세요.");
			$("#date").focus();
			return;
		}
		
		$.ajax({
			type : "post",
			url : "/board/timeCheck",
			data : {
				"time" : time,
				"date" : reserv_date
			},
			success : function(data){
				
				if(data == "ok"){
					
				}else if(data == "small"){
					alert("현시각 보다 1시간 이후부터 예약 가능합니다.");
					$("#time").val("");
				}else if(data == "DBno"){
					alert("예약하신 목록과 적어도 3시간 이상은 차이가 나야 예약이 가능합니다.\n예약하신 목록은 마이페이지에서 확인 가능합니다.");
					$("#time").val("");
				}else{
					alert("오늘 이후의 날짜를 선택해주세요.");
					$("#date").val("");
				}
			}
		});
	}
	
	function minusNum(){
		var num = $("#numPeople").val();
		
		if(num == "1"){
			alert("1명 이상 선택해주세요.");
		}else{
			var result = parseInt(num)-1;
			$("#numPeople").val(result);
		}
	}
	
	function plusNum(){
		var num = $("#numPeople").val();
		
		if(num == "4"){
			alert("코로나로 인해 5인 이상 집합 금지입니다.");
		}else{
			var result = parseInt(num)+1;
			$("#numPeople").val(result);
		}
	}
	
</script>

<%@ include file="/WEB-INF/views/include/footer.jsp"%>