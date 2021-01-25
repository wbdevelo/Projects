<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@include file="/include/header.jsp"%>

<%
request.setCharacterEncoding("utf-8");

String post = request.getParameter("post");
int uid = Integer.parseInt(request.getParameter("uid"));

String sql = "select * from " + post + " where uid='" + uid + "'";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

String title = "";
String content = "";
String id = "";
String nickname = "";
String signdate = "";
while(rs.next()){
	title = rs.getString("title");
	content = rs.getString("content");
	id = rs.getString("id");
	signdate = rs.getString("signdate");
	nickname = rs.getString("nickname");
}
rs.close();
stmt.close();
conn.close();
%>

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
        cursor:pointer;
	}
	
	.lay_st{
		border:1px solid #e5e5e5;
		width:100%;
		height:100%;
	}
	.title_st{
		font-weight:bold;
		font-size:30px;
		color:#7dbeb8;
		height:60px;
	}
	.naljja{
		font-size:13px;
		color:#8a837e;
	}
	.gesy_geul{
		font-size:12px;
		color:#7dbeb8;
		font-weight:bold;
	}
	.gesy_wi{
		font-weight:bold;
		color:#8a837e;
	}
	.matching{
		width:68px;
        height:30px;
        background-color: white;
        border: 1px solid #e5e5e5;
        color:#8a837e;
        cursor:pointer;
	}
	.gesy_other{
		font-size:12px;
		color:#8a837e;
	}
</style>
<br><br>
<table width=1000px height=800px align=center>
<form name="make_daewha" action="/message/daewha.jsp" method=post>
<input type="hidden" id="sang_nick" name="sang_nick" value="<%=nickname%>">
<input type="hidden" id="post" name="post" value="<%=post%>">
<input type="hidden" id="uid" name="uid" value="<%=uid%>">
	<tr>
		<td width=100px></td>
		<td>
			<table class="lay_st">
				<tr>
					<td colspan=2 height=20px></td>
				</tr>
				<tr>
					<td colspan=2 class="title_st"><%=title%></td>
				</tr>
				<tr height=30px>
					<td style="width:500px;font-color:#8a837e;font-size:14px">
						<%if(session_kind != null && session_kind.equals("giver_mem")){ %>
							<a onclick="dae()"><span style="border-bottom:1px solid black;cursor:pointer"><%=nickname%></span></a>
						<%}else{%>
							<%=nickname%>
						<%}%>
					</td>
					<td class="naljja" align=right><%=signdate%></td>
				</tr>
				<tr>
					<td colspan=2 height=20px style="border-bottom:1px solid #e5e5e5"></td>
				</tr>
				<tr>
					<td colspan=2 height=580px>
						<%=content%>
					</td>
				</tr>
				<tr>
					<td align=right valign=top colspan=2>
						<table>
							<tr>
								<td align=right>
								<%if(session_kind == null){%>
									<a class="bu_st" onclick="location.href='recipient_list.jsp?post=<%=post%>'">목록</a>
								<%}else if((session_kind.equals("recipient_mem")&&session_id.equals(id)) || session_level.equals("10")){%>
									<a class="matching" onclick="location.href='/pages/complete.jsp?post=<%=post%>&uid=<%=uid%>'">매칭완료</a>
									<a class="bu_st" onclick="location.href='modify_guel.jsp?post=<%=post%>&uid=<%=uid%>'">수정</a>
									<a class="bu_st" onclick="location.href='delete_guel.jsp?post=<%=post%>&uid=<%=uid%>'">삭제</a>
									<a class="bu_st" onclick="location.href='recipient_list.jsp?post=<%=post%>'">목록</a>
								<%}else{%>
									<a class="bu_st" onclick="location.href='recipient_list.jsp?post=<%=post%>'">목록</a>
								<%}%>
							</td>
							<td width=20px rowspan=2></td>
						</tr>
						<tr>
							<td height=20px></td>
						</tr>
					</table>
				</form>
				</tr>
			</table>
		</td>
		<td width=100px></td>
	</tr>
</table>

<table width=785px height=300px align=center>
	<tr>
		<td colspan=2 style="border-bottom:1px solid #c5c1bf">
			<table height=100% width=100%>
				<tr>
					<td class="gesy_wi">Giver 게시판 글</td>
					<td class="gesy_wi" align=right colspan=2><a href="recipient_list.jsp?post=<%=post%>">전체보기</a></td>
				</tr>
			</table>
		</td>
	</tr>
<%
	String sql_count = "select count(*) from " + post + "";
	
	Connection conn_count = DriverManager.getConnection(url, user, password);
	Statement stmt_count = conn_count.createStatement();
	ResultSet rs_count = stmt_count.executeQuery(sql_count);
	
	int total_record = 0;
	if(rs_count.next()){
		total_record = rs_count.getInt("count(*)");
	}
	
	int num_per_page = 6; //한 페이지당 출력할 게시물 수
	int block_per_page = 1; //한 페이지당 출력할 블럭 링크 수
	int total_page = 0; //총 페이지 수 초기화
	int limit_first = 0;
	
	int page_now;
	if(request.getParameter("page_now") != null){
		page_now = Integer.parseInt(request.getParameter("page_now"));
	}else{
		page_now = 1;
	}
	
	total_page = (int)Math.ceil(total_record / (double)num_per_page);
	limit_first = (page_now-1)*num_per_page;
	
	String sql_list = "select * from " + post + " order by uid desc limit " + limit_first + ", " + num_per_page + "";
	
	Connection conn_list = DriverManager.getConnection(url, user, password);
	Statement stmt_list = conn_list.createStatement();
	ResultSet rs_list = stmt_list.executeQuery(sql_list);
	
	while(rs_list.next()){
		String list_title = rs_list.getString("title");
		String list_signdate = rs_list.getString("signdate");
		int list_uid = rs_list.getInt("uid");
		String list_complete = rs_list.getString("complete");
		
		String sql_title = "select * from " + post + " where title='" + list_title + "'";
		
		Connection conn_title = DriverManager.getConnection(url, user, password);
		Statement stmt_title = conn_title.createStatement();
		ResultSet rs_title = stmt_title.executeQuery(sql_title);
		
		int title_uid = 0;
		while(rs_title.next()){
			title_uid = rs_title.getInt("uid");
		}
		
		if(!list_complete.equals("완료")){
			if(uid == (list_uid)){
%>
	
		<tr>
			<td><a href="view.jsp?post=<%=post%>&uid=<%=uid%>"><span class="gesy_geul"><%=list_title%></span></a></td>
			<td class="gesy_geul" align=right><%=list_signdate%></td>
		</tr>
		<tr>
			<td height=3px style="border-bottom:1px solid #e5e5e5" colspan=2></td>
		</tr>
<%
	}else{
%>
		<tr>
			<td><a href="view.jsp?post=<%=post%>&uid=<%=title_uid%>"><span class="gesy_other"><%=list_title%></span></a></td>
			<td class="gesy_other" align=right><%=list_signdate%></td>
		</tr>
		<tr>
			<td height=3px style="border-bottom:1px solid #e5e5e5" colspan=2></td>
		</tr>
<%
	}
	}else{
		
	}
}
%>
</table>

<table width=100%>
	<tr>
		<td height=30px></td>
	</tr>
	<tr>
		<td align=center>
			<%
			int total_block = 0;
			int block = 0;
			int first_page = 0;
			int last_page = 0;
			int my_page = 0;
			
			//총 블럭수
			total_block = (int)Math.ceil(total_page / (double)block_per_page);
			
			block = (int)Math.ceil(page_now / (double)block_per_page);
			first_page = (block - 1) * block_per_page;
			last_page = block * block_per_page;
			
			if(total_block <= block){
				last_page = total_page;
			}
			
			//이전 블럭 처리
			if(block == 1){}else{
				my_page = first_page;%>
				<a class="page_go" href="view.jsp?post=<%=post%>&uid=<%=uid%>&page_now=<%=my_page%>">
					<b>&lt;</b> <span style="font-size:13px">이전</span> &nbsp;
				</a>
				<%}
				
				if(block < total_block){
					my_page = last_page + 1;
				%>
					<a class="page_go" href="view.jsp?post=<%=post%>&uid=<%=uid%>&page_now=<%=my_page%>">
						&nbsp; <span style="font-size:13px">다음</span> <b>&gt;</b>
					</a>
				<%}else{}%>
		</td>
	</tr>
</table>
<script>
	function dae(){
		document.make_daewha.submit();
	}
</script>
</body>
</html>