<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/WEB-INF/views/admin/include/adminHead.jsp"%>

<%@include file="/WEB-INF/views/admin/include/adminSideNav.jsp"%>

<%@include file="/WEB-INF/views/admin/include/adminSetting.jsp"%>

                    <div class="card mb-4" style="width: 100%;">
                            <div class="card-header">
                                <i class="fas fa-table mr-1"></i>
                                현재 슬라이드 배너 이미지
                            </div>
                            <div class="card-body" >
                                <div class="table-responsive" >
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>No</th>
                                                <th>Img</th>
                                                <th>File-Name</th>
                                                <th>Upload-Date</th>
                                                <th>Delete</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	<c:set var="number" value="1"/>
                                        	<c:forEach var="list1" items="${list1}" varStatus="status">
                                        		<c:if test="${list1.num != 0 }">
	                                            <tr>
	                                                <td style="text-align: center; font-weight: bold; vertical-align: middle;">${list1.num}</td>
	                                                <td style="vertical-align: middle; width: 200px; text-align: center; height: 100px;">
	                                                	<img src="/resources/slideimg/${list1.file_name }" style="max-width: 150px;">
	                                                </td>
	                                                <td style="vertical-align: middle;">${list1.file_name }</td>
	                                                <td style="vertical-align: middle;">${list1.signdate }</td>
	                                                <td style="vertical-align: middle; text-align: center;">
	                                                	<button type="button" class="btn btn-danger" onclick="slideDelete(${list1.uid})">삭제</button>
	                                                </td>
	                                            </tr>
	                                            </c:if>
                                            <c:set var="number" value="${number+1 }"/>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="card mb-4" style="width: 60%; float: left; margin-left: 2%;">
                            <div class="card-header">
                                <i class="fas fa-table mr-1"></i>
                                슬라이드 배너 이미지 업로드
                            </div>
                            <div class="card-body" >
                                <div class="table-responsive" >
                                    <table class="table table-bordered" id="dataTable" width="50%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>No</th>
                                                <th>Img</th>
                                                <th>File-Name</th>
                                                <th>Upload-Date</th>
                                                <th>Setting</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	<c:set var="number" value="1"/>
                                        	<c:forEach var="list2" items="${list2}" varStatus="status">
	                                            <tr>
	                                                <td style="text-align: center; font-weight: bold; vertical-align: middle;">${number}</td>
	                                                <td style="vertical-align: middle;">
	                                                	<img src="/resources/slideimg/${list2.file_name }" style="max-width: 100px; height: 150px;">
	                                                </td>
	                                                <td style="vertical-align: middle;">${list2.file_name }</td>
	                                                <td style="vertical-align: middle;">${list2.signdate }</td>
	                                                <td style="display: flex; flex-direction: column; justify-content: space-between; align-items: center;">
	                                                	<button onclick="slideUpdate(${list2.uid}, 1)">slide1</button>
	                                                	<button style="margin-top: 10px;" onclick="slideUpdate(${list2.uid}, 2)">slide2</button>
	                                                	<button style="margin-top: 10px;" onclick="slideUpdate(${list2.uid}, 3)">slide3</button>
	                                                	<button style="margin-top: 10px;" onclick="slideUpdate(${list2.uid}, 4)">slide4</button>
	                                                	<button style="margin-top: 10px;" onclick="slideUpdate(${list2.uid}, 5)">slide5</button>
	                                                </td>
	                                            </tr>
                                            <c:set var="number" value="${number+1 }"/>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="card mb-4" style="width: 30%; float: left; margin-left: 5%;">
                            <div class="card-header">
                                <i class="fas fa-table mr-1"></i>
                                슬라이드 배너 이미지 업로드
                            </div>
                            <form name="slideUploadFile" method="post" enctype="multipart/form-data" >
	                            <div class="card-body" >
	                                <div class="table-responsive">
	                                    <input type="file" name="file" id="slidfile" onchange="previewImage(this)">
	                                    <div style="text-align: right;">
	                                    	<input type="button" value="업로드" onclick="fileUpload()">
                                    	</div>
                                    	<div id="preview" style="margin-top: 30px;">
                                    	</div>
	                                </div>
	                            </div>
                            </form>
                        </div>
                </main>

<script>
	function fileUpload(){
		var f = slideUploadFile;
		var slidfile = document.getElementById('slidfile');
		
		if(!f.slidfile.value){
			alert('파일을 선택해 주시기 바랍니다.');
			return;
		}
		
		if(confirm('선택한 파일을 업로드하시겠습니까?')){
			f.submit();
		} else{
			alert('취소하셨습니다.')
		}
	}
	
	function slideUpdate(uid, num){
		if(confirm(num+'번쨰 배너를 수정하시겠습니까?')){
			location.href="/admin/updateSlide?uid="+uid+"&num="+num;
		}
	}
	
	function slideDelete(uid){
		if(confirm('해당 배너 이미지를 삭제하시겠습니까?')){
			location.href="/admin/slidedelete?uid="+uid;
		}
	}
	
	function previewImage(f){
		var file = f.files;
		// 확장자 체크
		if(!/\.(gif|jpg|jpeg|png)$/i.test(file[0].name)){
			alert('gif, jpg, png 파일만 선택해 주세요.\n\n현재 파일 : ' + file[0].name);
			// 선택한 파일 초기화
			f.outerHTML = f.outerHTML;
			document.getElementById('preview').innerHTML = '';

		}
		else {
			// FileReader 객체 사용
			var reader = new FileReader();
			// 파일 읽기가 완료되었을때 실행
			reader.onload = function(rst){
				document.getElementById('preview').innerHTML = '<img src="' + rst.target.result + '" style="max-width: 380px;">';
			}
			// 파일을 읽는다
			reader.readAsDataURL(file[0]);
		}
	}
</script>
               
<%@include file="/WEB-INF/views/admin/include/adminFooter.jsp"%>
