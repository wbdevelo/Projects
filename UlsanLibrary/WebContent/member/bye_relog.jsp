<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>


<style>
table{
	text-align:center;
}

h2{
	align:center;
	text-align:center;
}
</style>

   <form action="bye_relog.do" method="post">
    <table align="center">
   	 <h2>보안을 위해 재 로그인 해주시길 바랍니다.</h2>
    	<tr>
    		<td>아이디</td>
    		<td><input name="id" value="${session_id }" ></td>
    	</tr>
    	<tr>
    		<td>비밀번호</td>
    		<td><input type="password" name="pass"></td>
    	</tr>
    	<tr>
    		<td colspan=2><input type="submit" value="로그인"></td>
    	</tr>
    </table>
   </form>
    
<%@ include file="/include/footer.jsp" %>