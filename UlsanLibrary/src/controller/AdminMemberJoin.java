package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDAO;
import model.Member;

@WebServlet("/admin/member/member_join.do")
public class AdminMemberJoin extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AdminMemberJoin() {
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
		Member m = new Member();
		
		m.setAge(Integer.parseInt(request.getParameter("age")));
		m.setEmail(request.getParameter("email"));
		m.setId(request.getParameter("id"));
		m.setName(request.getParameter("name"));
		m.setPass(request.getParameter("pass"));
		m.setLevel(request.getParameter("level"));
		m.setState(request.getParameter("state"));
		
		dao.AdmininsertMember(m);
		
		response.sendRedirect("member_list.do");
		
	}

}
