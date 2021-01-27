<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>


<style>
	.tst{
		width:20%;
		border-right:2px solid #d8d8d8
	}
	.ist{
		width:15%;
		border-right:2px solid #d8d8d8
	}
	.idst{
		width:15%;
		border-right:2px solid #d8d8d8
	}
	.dst{
		width:30%;
		border-right:2px solid #d8d8d8
	}
	.ost{
		width:10%;
		border-right:2px solid #d8d8d8
	}
	.btst{
		width:10%;
	}
	.btn_alarm{
		width:50px;
		height:30px;
		border:0px;
		background-color:#5882fa;
		color:white;
		border-radius: 5px 5px 5px 5px;
	}
	.btn_cancle{
		width:40px;
		height:30px;
		border:2px solid #5882fa;
		background-color:white;
		color:#5882fa;
		border-radius: 5px 5px 5px 5px;
	}
	.sframe{
		display:flex;
		text-align:center;
		height:30px;
		line-height:30px;
	}
	.frame{
		border-bottom:2px solid #d8d8d8;
		border-left:2px solid #d8d8d8;
		border-right:2px solid #d8d8d8;
		height:30px;
	}
</style>


<div style="display:flex">
	<div style="width:20%"></div>
	<div style="width:59%;min-height:390px;">
		<div style="border:2px solid #d8d8d8;text-align:center;display:flex;height:40px;line-height:40px;">
			<div class="tst">제목</div>
			<div class="ist">ISBN</div>
			<div class="idst">아이디</div>
			<div class="dst">예약신청 날짜</div>
			<div class="ost">상태</div>
			<div class="btst"></div>
		</div>
		<c:forEach var="rv" items="${rv}">
		<div class="frame" style="border:1px solid black">
		<form action="/ReservationAlarm/alarm.do" method="post">
			<input type="hidden" name="lib_name" value="${rv.lib_name}">
			<input type="hidden" name="id" value="${rv.id}">
			<input type="hidden" name="book_uid" value="${rv.book_uid}">
			<input type="hidden" name="title" value="${rv.title}">
			<div class="sframe">
				<c:choose>
					<c:when test="${rv.readDate != null && rv.alarmDate != null}">
						<c:choose>
							<c:when test="${rv.readDate == ''}">
								<c:choose>
									<c:when test="${rv.alarmDate+3 < todate }">
										<div class="tst"><span style="color:red">${rv.title}</span></div>
										<div class="ist"><span style="color:red">${rv.ISBN}</span></div>
										<div class="idst"><span style="color:red">${rv.id}</span></div>
										<div class="dst"><span style="color:red">${rv.date}</span></div>
										<div class="ost">
											<c:if test="${rv.state == 'rDaeki'}">
												<span style="color:red">알림대기</span>
	
											</c:if>
											<c:if test="${rv.state == 'alarm'}">
												<span style="color:red">알람보냄</span>
											</c:if>
										</div>
									</c:when>
									<c:otherwise>
										<div class="tst">${rv.title}</div>
										<div class="ist">${rv.ISBN}</div>
										<div class="idst">${rv.id}</div>
										<div class="dst">${rv.date}</div>
										<div class="ost">
											<c:if test="${rv.state == 'rDaeki'}">
												알림대기
											</c:if>
											<c:if test="${rv.state == 'alarm'}">
												알람보냄
											</c:if>
										</div>
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${rv.readDate+2 < todate }">
										<div class="tst"><span style="color:red">${rv.title}</span></div>
										<div class="ist"><span style="color:red">${rv.ISBN}</span></div>
										<div class="idst"><span style="color:red">${rv.id}</span></div>
										<div class="dst"><span style="color:red">${rv.date}</span></div>
										<div class="ost">
											<c:if test="${rv.state == 'rDaeki'}">
												<span style="color:red">알림대기</span>
											</c:if>
											<c:if test="${rv.state == 'alarm'}">
												<span style="color:red">알람보냄</span>
											</c:if>
										</div>
									</c:when>
									<c:otherwise>
										<div class="tst">${rv.title}</div>
										<div class="ist">${rv.ISBN}</div>
										<div class="idst">${rv.id}</div>
										<div class="dst">${rv.date}</div>
										<div class="ost">
											<c:if test="${rv.state == 'rDaeki'}">
												알림대기
											</c:if>
											<c:if test="${rv.state == 'alarm'}">
												알람보냄
											</c:if>
										</div>
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<div class="tst">${rv.title}</div>
						<div class="ist">${rv.ISBN}</div>
						<div class="idst">${rv.id}</div>
						<div class="dst">${rv.date}</div>
						<div class="ost">
							<c:if test="${rv.state == 'rDaeki'}">
								알림대기
							</c:if>
							<c:if test="${rv.state == 'alarm'}">
								알람보냄
							</c:if>
						</div>
					</c:otherwise>
				</c:choose>
				<div class="btst">
					<c:if test="${rv.state == 'rDaeki'}">
						<input class="btn_alarm" type="submit" value="알리기">
					</c:if>
						<input class="btn_cancle" type="submit" formaction="/ReservationAlarm/del_reserv.do" value="삭제">	
				</div>
			</div>
		</form>
		</div>
		</c:forEach>
	</div>
	<div style="width:20%"></div>
</div>




<%@ include file="/include/footer.jsp" %>