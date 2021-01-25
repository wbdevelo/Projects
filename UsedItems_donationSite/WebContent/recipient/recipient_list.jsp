<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>

<style>
.search_table {
		border:1px solid #526069;
		color:#526069;
		border-radius:10px 10px 10px 10px;
        width:100%;
        height:70%;
		font-size:13px;
	}
    .search_input{
        border:0px;
        height:100%;
    }
    .wi{
    	border-top:2px solid #c5c1bf;
    	border-bottom:1px solid #eeedec;
    	text-align:center;
    	font-weight:bold;
    	font-size:20px;
    	height:15%
    }
</style>

<table style="height:500px;width:100%;background-color:#cfe9eb">
	<tr>
		<td height=100px></td>
	</tr>
	<tr>
		<td>
			<table width=100% height=100%>
				<tr>
					<td width=40%></td>
					<td>
						"오늘도 즐거운 하루 되시길 바랍니다."<br><br><br>
						• 기관인 멤버만 사용 가능한 페이지입니다.<br><br>
						• '[글쓰기]'를 이용하여 필요하신 물품을 알려주십시오.<br><br>
						• 기부는 선의입니다. 항상 감사한 마음을 표현합시다.
					</td>
					<td width=20%></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height=100px></td>
	</tr>
</table>
<div style="width:100%;height:150px;text-align:center;font-size:20px">
	<br><br>
	<span style="border-bottom:2px solid gray">Recipient<br></span>
</div>

<%
request.setCharacterEncoding("utf-8");

String post = request.getParameter("post");
String search = request.getParameter("search");

if(search == null){
	search = "";
}

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
String sql_count;

//검색
if(search != ""){
	sql_count = "select count(*) as total_count from " + post + " where nickname like '%" + search + "%' or id like '%" + search + "%' or title like '%" + search + "%' or content like '%" + search + "%'";
}else{
	sql_count = "select count(*) as total_count from " + post + "";
}
ResultSet rs_count = stmt.executeQuery(sql_count);

int total_record = 0;
if(rs_count.next()){
	total_record = rs_count.getInt("total_count");
}

int num_per_page =6; //한 페이지당 출력할 게시물 수
int page_per_block = 5; //한 페이지당 출력할 블럭 링크 수
int total_page = 0; //총 페이지 수 초기화
int first = 0; //limit -> first,num_per_page 시작 값 부터 num_per_page 수만큼 선택

//현재 페이지 구하기
int page_now = 1; //현재 페이지 수 선언

if(request.getParameter("page_now") != null){
	page_now = Integer.parseInt(request.getParameter("page_now"));
}else{
	page_now = 1;
}

//총 페이지 수		//Math.ceil -> 올림.
total_page = (int)Math.ceil(total_record / (double)num_per_page);

first = num_per_page * (page_now - 1);
%>

<table style="background-color:white;width:100%">
<form action="recipient_list.jsp?post=<%=post%>" method="post">
    <tr>
    	<td></td>
        <td align=right width=250px>
        	<table class="search_table">
        		<tr>
        			<td>
        				<input class="search_input" name="search" placeholder="search">
        			</td>
        			<td align=right>
			            <input type="image" src="/img/search.png" name="submit" value="submit" style="width:15px;height:15px">
			        </td>
        		</tr>
        	</table>
        </td>
    </tr> 
</form>
</table>
<br><br>

<table align=center width=70% height=350px>
	<tr>
		<td class="wi" colspan=4>
			<table width=100% height=100%>
				<tr>
					<td width=9.5%>No</td>
					<td width=60.5%>제목</td>
					<td width=10.2%>글쓴이</td>
					<td width=19.8%>날짜</td>
				</tr>
			</table>
		</td>
	</tr>
<%
int k = total_record - (page_now - 1) * num_per_page;
String sql;

if(search != ""){
	sql = "select * from " + post + " where nickname like '%" + search + "%' or id like '%" + search + "%' or title like '%" + search + "%' or content like '%" + search + "%' order by uid desc limit " + first  + ", " + num_per_page + "";
}else{
	sql = "select * from " + post + " order by uid desc limit " + first  + ", " + num_per_page + "";
}
ResultSet rs = stmt.executeQuery(sql);

while(rs.next()){
	int uid = rs.getInt("uid");
	String title = rs.getString("title");
	String signdate = rs.getString("signdate");
	String nickname = rs.getString ("nickname");
	String complete = rs.getString("complete");
	
	if(!complete.equals("완료")){
%>

	<tr style="text-align:center;">
		<td width=10%><%=k%></td>
		<td width=60%><a href="view.jsp?post=<%=post%>&uid=<%=uid%>&page_now=<%=page_now%>"><%=title%></a></td>
		<td width=10%><%=nickname%></td>
		<td width=20%><%=signdate%></td>
	</tr>
	<tr>
		<td style="border-bottom:1px solid #eeedec;height:3px" colspan=4></td>
	</tr>
<%
k--;
	}
}
%>
</table>
<table width=85%>
	<tr>
    	<td colspan=3 style="text-align:right">
    		<%if(session_kind == null){ %>
    			<a onclick="alert('로그인이 필요합니다.')"; style="cursor:pointer"">[글쓰기]</a>
    		<%}else if(session_kind.equals("recipient_mem") || session_level.equals("10")){%>
    			<a href="write.jsp?post=<%=post%>">[글쓰기]</a>
    		<%}else{%>
    			<a onclick="alert('기관인만 사용이 가능한 기능입니다.')" style="cursor:pointer">[글쓰기]</a>
    		<%}%>
    	</td>
    </tr>
</table>
<table width=100%>
	<tr>
		<td height=20px></td>
	</tr>
	<tr>
		<td align=center>
			<%
			int total_block = 0;
			int block = 0;
			int first_page = 0;
			int last_page = 0;
			int direct_page = 0;
			int my_page = 0;
			
			//총 블럭수
			total_block = (int)Math.ceil(total_page / (double)page_per_block);
			
			block = (int)Math.ceil(page_now / (double)page_per_block);
			first_page = (block - 1) * page_per_block;
			last_page = block * page_per_block;
			
			if(total_block <= block){
				last_page = total_page;
			}
			
			//이전 블럭 처리
			if(block == 1){
				
			}else{
				my_page = first_page;%>
					<a href="recipient_list.jsp?post=<%=post%>&page_now=<%=my_page%>&search=<%=search%>">&lt;</a>
				<%}
				
				for(direct_page=first_page+1; direct_page<=last_page; direct_page++){
					if(page_now == direct_page){%>
						<font color="red"><b><%=direct_page%></b></font>
					<%}else{%>
						<a href="recipient_list.jsp?post=<%=post%>&page_now=<%=direct_page%>&search=<%=search%>"><%=direct_page%></a>
					<%}
				}
				
				if(block < total_block){
					my_page = last_page + 1;
				%>
					<a href="recipient_list.jsp?post=<%=post%>&page_now=<%=my_page%>">&gt;</a>
				<%}%>
		</td>
	</tr>
</table>
<br><br>

<%@ include file="/include/footer.jsp" %>