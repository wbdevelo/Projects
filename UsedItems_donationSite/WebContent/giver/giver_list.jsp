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
    .mitjul{
    	width:100%;
    	height:280px;
		border-bottom:2px solid black;
		text-align:center
	}
	.img_class{
		width:100%;
		height:100%
	}
	.tedury{
		border:1px solid black;
		width:300px;
		height:350px;
		text-align:center;
	}
</style>

<table style="height:500px;width:100%;background-color:#cfe9eb;">
	<tr>
		<td height=100px></td>
	</tr>
	<tr>
		<td>
			<table width=100% height=100%>
				<tr>
					<td width=40%></td>
					<td>
						"오늘도 감사합니다."<br><br><br>
						 • 일반인으로 가입하신 분들만 사용이 가능합니다.<br><br>
						 • 기부하시고 싶은 물건 무엇이든 '[글쓰기]'를 이용하여 게시글을 올리실 수 있습니다.<br><br>
						 • 게시물을 올리실 때 물건 사진은 필수입니다!<br><br>
						 • 자유롭게 올리시되 다음 사람이 사용할 수 있을 정도의 상태인 물품만을 올려주세요.<br><br>
						 • 운영자가 보기에 상태가 너무 불량할 시 글이 강제 삭제될 수 있습니다.
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
	<span style="border-bottom:2px solid gray">Giver<br></span>
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

if(search != ""){
	sql_count = "select count(*) as total_count from " + post + " where nickname like '%" + search + "%' or title like '%" + search + "%' or content like '%" + search + "%'";
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
<form action="giver_list.jsp?post=<%=post%>" method="post">
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
</table><br>

<table width=60% height=400px align=center>
<%
int k = total_record - (page_now - 1) * num_per_page;
int number = 1;
String sql;

if(search != ""){
	sql = "select * from " + post + " where nickname like '%" + search + "%' or title like '%" + search + "%' or content like '%" + search + "%' order by uid desc limit " + first  + ", " + num_per_page + "";
}else{
	sql = "select * from " + post + " order by uid desc limit " + first  + ", " + num_per_page + "";
}
ResultSet rs = stmt.executeQuery(sql);

while(rs.next()){
	int uid = rs.getInt("uid");
	String title = rs.getString("title");
	String file_rename = rs.getString("file_rename");
	String file_s = rs.getString("file_s");
	String complete = rs.getString("complete");
	
	if(!complete.equals("완료")){
%>

		<%if(number%3 == 1){
			out.print("<tr><td colspan=7 height=30px></td></tr>");
			out.print("<tr>");
			out.print("<td width=7% ></td>");
		}%>
			<td>
				<table class="tedury" align=center>
					<tr>
						<td class="mitjul">
							<a href="view.jsp?post=<%=post%>&uid=<%=uid%>&page_now=<%=page_now%>&rud=uid"><img class="img_class" src="/upload/<%=file_s%>"></a>
						</td>
					</tr>
					<tr>
						<td align=center><%=title%></td>
					</tr>
				</table>
			</td>
			<td width=7% ></td>
		<%if(number%3 == 0){
			out.print("</tr>");
		}%>


<%
number++;
k--;
	}
}
%>
	</tr>
</table>
<table width=85%>
    <tr>
    	<td colspan=3 style="text-align:right">
    		<%if(session_kind == null){ %>
    			<a onclick="alert('로그인이 필요합니다.')" style="cursor:pointer">[글쓰기]</a>
    		<%}else if(session_kind.equals("giver_mem") || session_level.equals("10")){%>
    			<a href="write.jsp?post=<%=post%>">[글쓰기]</a>
    		<%}else{%>
    			<a onclick="alert('일반인만 사용이 가능한 기능입니다.')" style="cursor:pointer">[글쓰기]</a>
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
					<a href="giver_list.jsp?post=<%=post%>&page_now=<%=my_page%>&search=<%=search%>">&lt;</a>
				<%}
				
				for(direct_page=first_page+1; direct_page<=last_page; direct_page++){
					if(page_now == direct_page){%>
						<font color="red"><b><%=direct_page%></b></font>
					<%}else{%>
						<a href="giver_list.jsp?post=<%=post%>&page_now=<%=direct_page%>&search=<%=search%>"><%=direct_page%></a>
					<%}
				}
				
				if(block < total_block){
					my_page = last_page + 1;
				%>
					<a href="giver_list.jsp?post=<%=post%>&page_now=<%=my_page%>">&gt;</a>
				<%}%>
		</td>
	</tr>
</table>
<br><br>

<%@ include file="/include/footer.jsp" %>