package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDAO;

@WebServlet("/admin/member/id_check.do")
public class AdminMember_IdCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AdminMember_IdCheck() {
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
		int count = dao.check_id(request.getParameter("id"));
		
		if(count == 0) {
			request.setAttribute("result", "사용이 가능합니다.");
			request.setAttribute("id", request.getParameter("id"));
		}else {
			request.setAttribute("result", "사용이 불가합니다.");
			request.setAttribute("id", request.getParameter("id"));
		}
		
		RequestDispatcher dis = request.getRequestDispatcher("member_join.jsp");
		dis.forward(request, response);
		
	}

}
