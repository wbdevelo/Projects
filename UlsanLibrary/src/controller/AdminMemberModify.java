package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDAO;
import model.Member;

@WebServlet("/admin/member/member_modify.do")
public class AdminMemberModify extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminMemberModify() {
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
		
		String id = request.getParameter("id");
		
		Member bean = new Member();
		MemberDAO dao = new MemberDAO();
		
		bean = dao.viewMember(id);
		
		request.setAttribute("modify", bean);//bean객체를 modify로 바꿔서 포워드
		
		RequestDispatcher dis = request.getRequestDispatcher("member_modify.jsp");
		 dis.forward(request, response);//포워드 시키고싶다면 이걸 계속 쓰면 된다.
	}

}
