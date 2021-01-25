<%@page import="com.mysql.cj.xdevapi.Result"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String sql = "select * from " + session_kind + " where id='" + session_id + "'";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

String id = "";
String address = "";
String email = "";
String phone = "";
String zipcode = "";
String nickname = "";
while(rs.next()){
	id = rs.getString("id");
	address = rs.getString("address");
	email = rs.getString("email");
	phone = rs.getString("phone");
	zipcode = rs.getString("zipcode");
}
%>
<style>
	input{
		border:1px solid gray;
		height:25px;
		width:200px;
	}
	.out_table{
		width:50%;
		height:400px;
		border-top:1px solid gray;
		border-bottom:1px solid gray;
	}
	.guelja{
		width:40%;
		font-size:12px;
		font-weight:bold;
	}
	.juso{
		border:1px solid gray;
		height:25px;
		background-color:#fbf7f2;
		width:65px;
		font-size:12px;
	}
	.gaip{
		background-color:#fbf7f2;
		border:1px solid black;
		width:240px;
        height:50px;
	}
</style>

<script>
	function sujeong(){
		
		document.mem_sujeong.submit();
		
	}
</script>

<br><br><br><br>
<table class="out_table" align=center>
<form name="mem_sujeong" action="infoChange_DB.jsp" method="post">
	<tr>
		<td>
			<table width=80% height=100% align=center>
				<tr>
					<td class="guelja">아이디</td>
					<td><input id="id" name="id" value="<%=id%>" readonly></td>
				</tr>
				<tr>
					<td class="guelja">닉네임</td>
					<td><input id="nickname" name="nickname" value="<%=session_nickname%>" readonly></td>
				</tr>
				<tr>
					<td class="guelja">이메일</td>
					<td><input id="email" name="email" value="<%=email%>"></td>
				</tr>
				<tr>
					<td class="guelja">휴대폰 번호</td>
					<td><input id="phone" name="phone" value="<%=phone%>"></td>
				</tr>
				<tr>
					<td class="guelja">주소</td>
					<td>
						<table>
							<tr>
								<td>
									<input type="text" style="width:100%" id="sample6_postcode" name="zipcode" value="<%=zipcode%>">
								</td>
								<td width=5px></td>
								<td>
									<input type="button" class="juso" onclick="sample6_execDaumPostcode()" value="주소찾기">
								</td>
							</tr>
							<tr>
								<td colspan=3><input type="text" style="width:100%" id="sample6_address" name="zip1" value="<%=address%>"></td>
							</tr>
							<tr>
								<td colspan=3><input type="hidden" style="width:100%" id="sample6_detailAddress" name="zip2"></td>
							</tr>
							<tr>
								<td colspan=3><input type="hidden" style="width:100%" id="sample6_extraAddress" name="zip3"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</form>
</table>


<br>
<table align=center>
	<tr>
		<td colspan=2>
			<button class="gaip" onclick="sujeong()">회원수정</button>
		</td>
	</tr>
</table>
<br><br>
<!--주소 찾기-->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>

<%@ include file="/include/footer.jsp" %>