<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>

<style>
	.viewQ-frame{
		width:100%;
		height:750px;
		position:relative;
	}
	
	.viewQ-main{
		width:60%;
		height:100%;
		position: absolute;
		top:0px;
		left:20%;
		border-right:1px solid #dedede;
		border-left:1px solid #dedede;
	}
	
	.viewQ-title{
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
	
	.viewQ-content{
		text-align:center;
		width: 100%;
		height: 450px;	
		border-bottom:1px solid #dedede;
		margin-top:10px;
		padding-top:30px;
	}
	
	.viewQ-file{
		border-bottom:1px solid #dedede;
		
	}
	
	.viewQ-admin-modi{
		border:1px solid #dedede;
		text-align:center;
		width: 5%;
		height: 20px;	
		cursor: pointer;
	}
	
	.viewQ-admin-modi:hover{
		border:1px solid #dedede;
		text-align:center;
		width: 5%;
		height: 20px;	
		cursor: pointer;
		background-color:#0074c8;
		color:#ffffff;
	}
	
	.viewQ-admin-dele{
		border:1px solid #dedede;
		text-align:center;
		width: 5%;
		height: 20px;	
		cursor: pointer;
		position: absolute;
		top:594px;
		left:5%
	}
	
	.viewQ-admin-dele:hover{
		border:1px solid #dedede;
		text-align:center;
		width: 5%;
		height: 20px;	
		cursor: pointer;
		position: absolute;
		top:594px;
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
	
	.viewQ-golist{
	
	}
	
	.viewQ-golist{
		border:1px solid #dedede;
		text-align:center;
		width: 5%;
		height: 20px;	
		cursor: pointer;
	}
	
	.viewQ-golist:hover{
		border:1px solid #dedede;
		text-align:center;
		width: 5%;
		height: 20px;	
		cursor: pointer;
		background-color:#0074c8;
		color:#ffffff;
	}
	
	.viewQ-admin-dap{
		border:1px solid #dedede;
		text-align:center;
		width: 5%;
		height: 20px;	
		cursor: pointer;
		position: absolute;
		top:616px;
		left:5%
	}
	
	.viewQ-admin-dap:hover{
		border:1px solid #dedede;
		text-align:center;
		width: 5%;
		height: 20px;	
		cursor: pointer;
		position: absolute;
		top:616px;
		left:5%;
		background-color:#0074c8;
		color:#ffffff;
	}
</style>

<div class="viewQ-frame"><!-- viewN-frame -->
	<div class="viewQ-main"><!-- viewN-content -->
		<div class="viewQ-title">제목 : ${q.title }</div>
		<div class="viewQ-wirter">글쓴이 : ${q.name }</div>
		<div class="viewQ-content">${q.content }</div>

		<div class="viewQ-file">
			<c:choose>
				<c:when test="${n.file == null || n.file == '' }">
					<img id="nofilecon" src="/img/no.png"><a>파일이 없습니다.</a>
				</c:when>
				<c:otherwise>
					<img id="file-icon" alt="" src="/img/filecon.png"><a href="/upload/${n.file }" download>${n.file }</a>
				</c:otherwise>
			</c:choose>
		</div>
		<c:if test="${session_level == '10' || session_id == q.id}">
			<div class="viewQ-admin-modi" onclick="location.href='modify_qna.do?uid=${q.uid}&pageNum=${pageNum}'">수정</div>
			<div class="viewQ-admin-dele" onclick="location.href='delete_q.do?uid=${q.uid}'">삭제</div>
		</c:if>
		<c:if test="${session_level == '10'}">
			<div class="viewQ-admin-dap" onclick="location.href='reply_q.jsp?uid=${q.uid}&fid=${q.fid}&thread=${q.thread}'">답글</div>
		</c:if>
		<c:choose>
			<c:when test="${now == null || now == ''}">
				<div class="viewQ-golist" onclick="location.href='SelectQ?pageNum=${pageNum}'">목록</div>
			</c:when>
			<c:otherwise>
				<div class="viewQ-golist" onclick="location.href='/member/myQ.do?id=${sessionScope.id}'">목록</div>
			</c:otherwise>
		</c:choose>
	</div>
</div>

<%@ include file="/include/footer.jsp" %>