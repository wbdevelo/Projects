<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp"%>
    
<style>
	.viewN-frame{
		width:100%;
		height:750px;
		position:relative;
	}
	
	.viewN-main{
		width:60%;
		height:100%;
		position: absolute;
		top:0px;
		left:20%;
		border-right:1px solid #dedede;
		border-left:1px solid #dedede;
	}
	
	.viewN-title{
		width: 100%;
		height: 50px;
		background-color:#cccccc;
		font-size:30px;
	}
	
	.viewN-wirter{
		width: 100%;
		height: 20px;
		background-color:#cccccc;
		text-align:right;
	}
	
	.viewN-content{
		text-align:center;
		width: 100%;
		height: 450px;	
		border-bottom:1px solid #dedede;
		margin-top:10px;
		padding-top:30px;
	}
	
	.viewN-file{
		border-bottom:1px solid #dedede;
		
	}
	
	.viewN-admin-modi{
		border:1px solid #dedede;
		text-align:center;
		width: 5%;
		height: 20px;	
		cursor: pointer;
	}
	
	.viewN-admin-modi:hover{
		border:1px solid #dedede;
		text-align:center;
		width: 5%;
		height: 20px;	
		cursor: pointer;
		background-color:#0074c8;
		color:#ffffff;
	}
	
	.viewN-admin-dele{
		border:1px solid #dedede;
		text-align:center;
		width: 5%;
		height: 20px;	
		cursor: pointer;
		position: absolute;
		top:592px;
		left:5%
	}
	
	.viewN-admin-dele:hover{
		border:1px solid #dedede;
		text-align:center;
		width: 5%;
		height: 20px;	
		cursor: pointer;
		position: absolute;
		top:592px;
		left:5%;
		background-color:#0074c8;
		color:#ffffff;
	}
	
	#file-icon{
		width: 50px;
		height: 30px;
	}
	
	#nofilecon{
		width: 30px;
		height: 30px;
	}
	
	.viewN-golist{
	
	}
	
	.viewN-golist{
		border:1px solid #dedede;
		text-align:center;
		width: 5%;
		height: 20px;	
		cursor: pointer;
	}
	
	.viewN-golist:hover{
		border:1px solid #dedede;
		text-align:center;
		width: 5%;
		height: 20px;	
		cursor: pointer;
		background-color:#0074c8;
		color:#ffffff;
	}
</style>
<div class="viewN-frame"><!-- viewN-frame -->
	<div class="viewN-main"><!-- viewN-content -->
		<div class="viewN-title">제목 : ${n.title }</div>
		<div class="viewN-wirter">글쓴이 : ${n.name }</div>
		<div class="viewN-content">${n.content }</div>
		
		<div class="viewN-file">
			<c:choose>
				<c:when test="${n.file == null || n.file == '' }">
					<img id="nofilecon" src="/img/no.png"><a>파일이 없습니다.</a>
				</c:when>
				<c:otherwise>
					<img id="file-icon" alt="" src="/img/filecon.png"><a href="/upload/${n.file }" download>${n.file }</a>
				</c:otherwise>
			</c:choose>
		</div>
		<c:if test="${session_level == '5' && session_level == '10' || session_name == n.name}">
		<div class="viewN-admin-modi" onclick="location.href='modify_n.do?uid=${uid }';">
			수정
		</div>
		<div class="viewN-admin-dele" onclick="location.href='delete_n.do?uid=${uid }';">	
			삭제
		</div>
		</c:if>
		<div class="viewN-golist" onclick="location.href='/notice/SelectN';">
			목록
		</div>
	</div>
</div>
	

<%@ include file="/include/footer.jsp"%>
