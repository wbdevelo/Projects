<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>

<%
	String post = request.getParameter("post");
%>

<script>
	 function save(){
		var fo = create_list;
		
		if(!fo.title.value){
			alert("제목을 입력해주세요.");
			fo.title.focus();
			return;
		}
		fo.submit();
	 }
</script>

<style>
	input{
		width:100%;
		height:100%;
		border:0px solid white;
	}
	
	.bu_st{
		width:50px;
        height:30px;
        background-color: white;
        border: 1px solid #e5e5e5;
        color:#8a837e;
	}
</style>

<br><br>
<div style="text-align:center;"><span style="border-bottom:2px solid gray">글쓰기</span></div>
<br><br>

<table width=100% height=400px>
<form name="create_list" action="write_insert.jsp" method="post">
<input type="hidden" name="post" value="<%=post%>">
	<tr>
		<td width=30%></td>
		<td style="border:1px solid #e5e5e5">
			<table width=100% height=100%>
				<tr>
					<td rowspan=2 width=20px></td>
					<td height=30px>
						<input id="title" name="title" type="text" style="border-bottom:1px solid #e5e5e5" placeholder="제목">
					</td>
					<td rowspan=2 width=20px></td>
				</tr>
				<tr>
					<td>
						<input id="content" name="content" type="text" placeholder="내용">
					</td>
				</tr>
			</table>
		</td>
		<td width=30%></td>
	</tr>
</form>
</table>
<table width=70%>
	<tr>
		<td height=13px></td>
		<td width=10px rowspan=2></td>
	</tr>
	<tr>
		<td align=right>
			<button class="bu_st" onclick="save()">저장</button>
			<button class="bu_st" onclick="location.href='recipient_list.jsp?post=<%=post%>'">취소</button>
		</td>
	</tr>
</table>
    
</body>
</html>