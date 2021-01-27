package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDAO;
import model.Member;

@WebServlet("/admin/member/member_list.do")
public class AdminMemberList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public AdminMemberList() {
        super();

    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAll(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAll(request, response);
	}
	
	protected void doAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		MemberDAO dao = new MemberDAO();
		ArrayList<Member> v = new ArrayList<Member>();//클래스1<클래스2> 변수 = new 클래스1<클래스2>(); 클래스1<클래스2>객체생성후 변수 v에 담는다
		
		//한페이지 보여질 리스트 갯수
		int pageSize = 5;
		//현재보여지는 페이지 값 처리
		int pageNum = 1;
		if(request.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
		//전체 게시글 총 갯수 초기화
		int count = 0;
		//전체 게시글 총 갯수
		count = dao.getAllcount();
		
		//페이지내에서 보여질 넘버링 숫자 
		int number = count - (pageNum -1) * pageSize;
		
		//현재 페이지 limit값 처리
		int startRow = (pageNum -1 )* pageSize;
		int endRow = pageSize;
		
		
		//변수 v에 회원 목록에 띄울 회원들의 이름,아이디,레벨,상태 등을 member_list.jsp로 포워드 시켜서 보낸다
		
		/* v = dao.getAllmember(startRow , endRow); */
		
		if(request.getParameter("search") != null && !request.getParameter("search").equals("")) {
			v = dao.search_mem(request.getParameter("search"), startRow, endRow);
		}else {
			v = dao.select_mem(startRow, endRow);
		}
		
		request.setAttribute("v", v);//
		request.setAttribute("count", count);
		request.setAttribute("number", number);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("pageNum", pageNum);
		
		RequestDispatcher dis = request.getRequestDispatcher("member_list.jsp");
		dis.forward(request, response);//포워드 시키고싶다면 이걸 계속 쓰면 된다.
	}

}
