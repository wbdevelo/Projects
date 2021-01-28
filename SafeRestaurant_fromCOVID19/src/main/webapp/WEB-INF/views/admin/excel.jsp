<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@include file="/WEB-INF/views/include/nav.jsp"%>

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
		width:51%;
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
	
/* 리스트 */
	.list_area{
		text-align: center;
		margin: 0 auto;
		width: 99%;
	}
	.list{
		display: inline-block;
		min-height: 400px;
		width: 51%;
		margin-top: 50px;
	}
	.list0{
		display: inline-block;
		height: 400px;
		width: 51%;
		margin-top: 200px;
	}
	.list_header{
		width: 100%;
		display: flex;
		height:40px;
		background-color: #ffbba0;
		border-top: 1px solid #dc4300;
		border-bottom: 1px solid #dc4300;
		font-size: 18px;
	}
	.num{
		width:8%;
		line-height: 40px;
	}
	.name{
		width:37%;
		line-height: 40px;
	}
	.upDate{
		width:20%;
		line-height: 40px;
	}
	.check{
		width:15%;
		line-height: 40px;
	}
	.use{
		width: 10%;
		line-height: 40px;
	}
	.del{
		width:10%;
		line-height: 40px;
	}
	.list_content{
		display: flex;
		width: 100%;
		min-height: 40px;
		border-bottom: 1px solid #dc4300;
		font-size: 14px;
	}
	.list_content button{
		height:30px;
		width:80px;
		border:2px solid #ffbba0;
		color:#d88767;
		background-color:white;
		font-weight: bold;
	}
	.del button{
		width:50px;
	}

/* 페이징 */
	.paging_area{
		width:100%;
		padding-top:30px;
		text-align:center;
		margin: 0 auto;
	}
	.paging{
		display:inline-block;
		width:150px;
	}
	.paging_content{
		display:flex;
	}
	.paging_number{
		width:50px;
	}
	.preBlock{
		padding-right:10px;
		padding-top:3px;
	}
	.nextBlock{
		padding-left:10px;
		padding-top:3px;
	}
	
/* 파일 */
	.file_area{
		width: 99%;
		margin-top: 50px;
		text-align: center;
		display: flex;
	}
	.file_area input[type="file"] {
	  position: absolute;
	  width: 0;
	  height: 0;
	  padding: 0;
	  overflow: hidden;
	  border: 0;
	}
	.file_img{
		margin-left: 40%;
		margin-right: 20px;
	}
	.file_name{
		height:30px;
		width:250px;
		border:0px;
		text-align:center;
	}
	.sub_btn{
		width:100px;
		border:2px solid black;
		background-color: white;
		font-weight:bold;  
		border-radius: 3px 3px 3px 3px;
	}
</style>

<fmt:parseDate var="todayDate" value="${todate}" pattern="yyyy-MM-dd"/>
<fmt:formatDate var="todayDate" value="${todayDate}" pattern="yyyyMMdd"/>


<form name="excelForm" method="post" enctype="multipart/form-data">
	<div class="file_area">
		<div class="file_img">
			<label for="file">
				<i class="fas fa-paperclip" style="font-size:30px;"></i>
			</label>
		</div>
		<input class="file_name" placeholder="파일 이름">
		<input class="sub_btn" type="button" onclick="formSub()" value="업로드">
		<input type="file" name="file" id="file">
	</div>
</form>


<div class="list_area">
	<div class="list">
		<div class="list_header">
			<div class="num"><b>No</b></div>
			<div class="name"><b>파일이름</b></div>
			<div class="upDate"><b>업로드 날짜</b></div>
			<div class="check"><b>사용여부</b></div>
			<div class="use"></div>
			<div class="del"></div>
		</div>
		<c:set var="i" value="0"/>
		<c:forEach var="list" items="${list}">
		<c:set var="i" value="${i+1}"/>
			<div class="list_content">
				<div class="num">${i}</div>
				<div class="name">${list.file_name}</div>
				<div class="upDate">${list.upload_date}</div>
				<div class="check">${list.pick}</div>
				<div class="use">
					<c:if test="${list.pick == ''}">
						<button onclick="changeUse('${list.uid}')">사용하기</button>
					</c:if>
				</div>
				<div class="del">
					<button onclick="delete_excel('${list.uid}', '${list.pick}')">삭제</button>
				</div>
			</div>
		</c:forEach>
	</div>
</div>

<div class="paging_area">
	<div class="paging">
		<div class="paging_content">
			<c:if test="${pvo.nowBlock > 1 && pvo.nowBlock <= pvo.totalBlock}">
				<div class="preBlock"><a href="/mypage/jjimList?nowPage=${pvo.startPage-pvo.pagePerBlock}"><img src="/resources/img/previous.png"></a></div>
			</c:if>
			<c:if test="${pvo.totalPage > 1}">
			<c:forEach var="i" begin="${pvo.startPage}" end="${pvo.endPage}">
					<div class="paging_number"><a href="/mypage/jjimList?nowPage=${i}">${i}</a></div>
			</c:forEach>
			</c:if>
			<c:if test="${pvo.endPage < pvo.totalPage}">
				<div class="nextBlock"><a href="/mypage/jjimList?nowPage=${pvo.startPage+pvo.pagePerBlock}"><img src="/resources/img/next.png"></a></div>
			</c:if>
		</div>
	</div>
</div>

<script>

	$("#file").on("change", function(){
		var fileV = $("#file").val();
		var fileName = fileV.substring(fileV.lastIndexOf("\\")+1);
		$(".file_name").val(fileName);
	});

	function formSub(){
		var fn = excelForm;
		
		if(!fn.file.value){
			alert("파일을 선택해주세요.");
			return;
		}
		fn.submit();
	}
	
	function delete_excel(uid, pick){
		$.ajax({
			type : "post",
			url : "/admin/delExcel",
			data : {
				"uid" : uid,
				"pick" : pick
			},
			success : function(data){
				if(data == "ok"){
					alert("삭제되었습니다.");
				}else{
					alert("현재 사용중인 파일은 삭제하실 수 없습니다.");
				}
				location.href="/admin/excel";
			}
		});
	}
	
	function changeUse(uid){
		$.ajax({
			type : "post",
			url : "/admin/changeExcel",
			data : {
				"uid" : uid
			},
			success : function(){
				alert("수정이 완료되었습니다.");
				location.href="/admin/excel";
			}
		});
	}
</script>

<%@ include file="/WEB-INF/views/include/footer.jsp"%>