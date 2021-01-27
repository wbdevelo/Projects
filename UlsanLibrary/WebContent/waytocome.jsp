<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp"%>
<style>
  .come-head{
  	margin-top:10px;
  }
  
  .car-table {
    width: 100%;
  }
	ul {
    list-style: none;
    padding:0;
    margin:0;
	}

	li { 
   		padding-left: 1em; 
    	text-indent: -.7em;
	}

	li:before {
    	content: "■ ";
    	color: #0074c8; 
	}
	
  #park-td1 {
    width: 40%;
    border-right: 1px solid #444444;
    border-left: 1px solid #444444;
    border-bottom: 1px solid #444444;
    border-top: 1px solid #444444;
  }
  
  #park-td2 {
    width: 40%;
    border-right: 1px solid #444444;
    border-left: 1px solid #444444;
    border-bottom: 1px solid #444444;
  }
  
</style>
<body>
	<table align="center" width=100%>
			<tr>
				<td>
					<table class="come-head" align="center" width=50%>
						<tr>
							<td align="center">
								<h2>찾아오시는 길</h2><hr>
							</td>
						</tr>
						<tr>
							<td align="center">
							<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3246.8551365406065!2d129.34228301552372!3d35.53257738022924!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3567cd690fbef461%3A0x47b99f0175386846!2z7Jq47IKw64-E7ISc6rSA!5e0!3m2!1sko!2skr!4v1607647655751!5m2!1sko!2skr" width="500" height="350" frameborder="0" style="border:0;" allowfullscreen="" aria-hidden="false" tabindex="0"></iframe>
							</td>
						</tr>
						<tr>
							<td>
								<hr><h3>위치</h3>
								<ul>
									<li>도로명주소 : 울산광역시 남구 꽃대나리로 140(여천동)</li>
									<li>지번주소 : 울산광역시 남구 여천동 1456</li>
								</ul>
							</td>
						</tr>
						<tr>
							<td>
								<hr><h3>주차장 안내</h3>
								<ul>
									<li>도보나 대중교통을 이용해 주시기 바랍니다.</li>
									<li>개방시간 : 09:00 ~21:00</li>
									<li>주차요금</li>
								</ul>
								<table class="car-table">
									<tr>
										<td id="park-td1">기본(1시간 이내)</td>
										<td id="park-td1">기본초과 1시간 단위</td>
										<td id="park-td1">1일 최대</td>
									</tr>
									<tr>
										<td id="park-td2">무료</td>
										<td id="park-td2">500원</td>
										<td id="park-td2">3,000원</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>				
				</td>		
			</tr>	
	</table>
</body>


<%@ include file="/include/footer.jsp"%>