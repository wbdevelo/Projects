<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>

<style>
	.jj-frame{
		width:100%;
		min-height:650px;
		position: relative;
		margin-bottom: 30px;
	}
	
	.jj-main{
		border-right:1px solid #cccccc;
		border-left:1px solid #cccccc;
		width:40%;
		min-height:650px;
		margin-left:30%;
	}
	
	.jj-content{
		width:70%;
		margin-left:3%;
		min-height:650px;
	}
	
	#jj-alldel{
		cursor: pointer;
	}
	
	#jj-alldel:hover{
		cursor: pointer;
		background-color: #008aee;
		color:#ffffff;
	}
	
	#jj-infoA{
		text-decoration: none;
		color:black;
	}
	
	.jj-info{
		height:200px;
		width:400px;
	}
	
	.jj-maincon{
		width:650px;
		height:300px;
		margin-bottom: 30px;
		border-bottom: 1px solid #cccccc;
		margin-left: 20px;
		padding-left: 30px;
	}
	
	.jj-big{
		width:700px;
	}
</style>



<div class="jj-frame"><!-- jj-frame -->
	<div class="jj-main"><!-- jj-main -->
		<div class="jj-content">
			<table>
				<tr>
					<td id="jj-alldel" onclick="location.href='delAllJjim.do';">전체삭제</td>
				</tr>
			</table>
			
			<table class="jj-big" border=0>
				<c:forEach var="ev" items="${ev}">
					<tr>
						<td>
							<table class="jj-maincon">
								<tr>
									<td>	
										<a href="/e_book/view_e.do?uid=${ev.uid}&writer=${ev.writer}"><img src="/upload/${ev.thum_file}"></a>
									</td>
									<td>
										<table style="width:90%;" border=0>
											<tr>
												<td style="height:30px;text-align:right;">
													<a href="delJjim.do?id=${session_id}&title_uid=${ev.uid}">❌</a>
												</td>
											</tr>
											<tr>
												<td class="jj-info">
													<a id="jj-infoA" href="/e_book/view_e.do?uid=${ev.uid}&writer=${ev.writer}">
													<ul>
														<li>${ev.title} </li>
														<li>${ev.writer}</li>
														<li>${ev.pub_date}</li>
														<li>${ev.price}</li>
														<li>${ev.point}</li>
													</ul>
													</a>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>	
</div>

<%@ include file="/include/footer.jsp" %>