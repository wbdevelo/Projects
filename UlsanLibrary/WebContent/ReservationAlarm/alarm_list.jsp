<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>


<style>
	.btn_del{
		width:80px;
		height:30px;
		border:2px solid #7d9dfa;
		color:#7d9dfa;
		background-color:white;
		font-size:15px;
		border-radius: 5px 5px 5px 5px;
	}
</style>


<c:choose>
	<c:when test="${count == 0}">
		<div style="display:flex">
			<div style="width:20%;"></div>
			<div style="width:79%;text-align:center;min-height:260px;padding-top:200px;">
				<img src="/img/no2.png"><br>
				알림이 없습니다.
			</div>
			<div style="width:20%;"></div>
		</div>
	</c:when>
	<c:otherwise>
	<div style="display:flex">
		<div style="width:20%;"></div>
		<div style="width:79%;text-align:center;min-height:260px;padding-top:200px;">
			<div style="height:20px;"></div>
			<form action="delAlarm.do" method="post">
			<input type="hidden" name="id" value="${session_id}">
				<div align="left" style="padding-left:300px;">
					<input class="btn_del" type="submit" value="전체삭제">
				</div>
				<c:forEach var="av" items="${av}">
					<div>
						<c:choose>
							<c:when test="${av.readNum == 0}">
								<img src="/img/noread.png">
							</c:when>
							<c:otherwise>
								<img src="/img/read.png">
							</c:otherwise>
						</c:choose>
						<a href="alarm_detail.do?uid=${av.uid}&readNum=${av.readNum}">
							'${av.lib_name}'님에게 알림이 왔습니다.
						</a>
					</div>
					<div style="height:20px;display:flex">
						<div style="width:30%"></div>
						<div style="width:40%"><hr></div>
						<div style="width:30%"></div>
					</div>
				</c:forEach>
			</form>
		</div>
		<div style="width:20%;"></div>
</div>
	</c:otherwise>
</c:choose>

<%@ include file="/include/footer.jsp" %>