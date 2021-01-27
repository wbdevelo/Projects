<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp"%>

<div style="display:flex">
	<div style="width:30%"></div>
	<div style="width:39%;text-align:center;border-top:2px solid #d8d8d8;border-bottom:2px solid #d8d8d8;margin-top:170px;">
		<div style="height:20px;"></div>
		<div>
			저희 사이트를 이용해주셔서 감사합니다.<br><br>
			${signdate} 까지 총 ${price}원을 <br><br>
			예금주: 김지훈<br>
			국민은행 1234-1234-1234-12 으로 보내주세요.
		</div>
		<div style="height:20px;"></div>
	</div>
	<div style="width:30%"></div>
</div>
<div style="height:120px;"></div>
<%@ include file="/include/footer.jsp"%>