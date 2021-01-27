<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>

<style>
	.btn_hw{
		width:80px;
		height:40px;
		border:0px;
		background-color:#7d9dfa;
		color:white;
		font-size:16px;
	}
	.btn_cancle{
		width:80px;
		height:40px;
		border:2px solid #7d9dfa;
		background-color:white;
		color:#7d9dfa;
		font-size:16px;
	}
</style>

<form action="confirm_reserv.do" method="post">
<div style="display:flex;">
	<div style="width:20%"></div>
	<c:choose>
		<c:when test="${state == 'alarm'}">
			<div style="width:79%;text-align:center">
				<div>
					'${a.id}' 님이 요청하신 ${a.lib_name}의 ${a.title}책이 대출 가능합니다.<br>
					대출을 원하시면 확정하기를 눌러주세요.
				</div>
				<div style="display:flex;height:50px;padding-top:20px;padding-left:600px;">
					<div><input class="btn_hw" type="submit" value="확정하기"></div>
					<div style="width:30px;"></div>
					<div><input class="btn_cancle" type="submit" formaction="cancel_reserv.do" value="취소하기"></div>
				</div>
			</div>
		</c:when>
		<c:when test="${state == '확정'}">
			<div style="width:79%;text-align:center">찾으러 오시는 기간: ${v_readDate}</div>
		</c:when>
		<c:otherwise>
			<div style="width:79%;text-align:center">취소하셨습니다.</div>
		</c:otherwise>
	</c:choose>
	<div style="width:20%"></div>
</div>
<input type="hidden" name="lib_name" value="${a.lib_name}">
<input type="hidden" name="book_uid" value="${a.book_uid}">
<input type="hidden" name="id" value="${a.id}">
<input type="hidden" name="readDate" value="${a.readDate}">
<input type="hidden" name="uid" value="${a.uid}">
<input type="hidden" name="readNum" value="${a.readNum}">

</form>

<%@ include file="/include/footer.jsp" %>