<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String id2 = request.getParameter("id_value");
%>


<script>
	function id_use(){//현재 팝업 인풋값을 다시 join.jsp 아이디 인풋에 전달 후 창 닫기
		//~~~~~
		window.close();
	}
	
	function id_unused(){//전달할 값 없으니 창만 닫습니다.
		window.close();
	}
</script>
  
<title>아이디 중복확인</title>

<body onload="">
<h3 align="center">아이디 중복확인</h3>
<table align="center" width=30% border=1>
<form name="id_check" action="id_check.do" method="post">
		<tr>
			<td><input id="id" name="id" value="<%=id2%>"></td>
			<td><input type="submit" value="조회"></td>
		</tr>
</form>
		<tr>
			<td><input type=button onclick="id_use()" value="확인"></td>
			<td><input type=button onclick="id_unused()" value="취소"></td>
		</tr>
	
</table>
</body>
