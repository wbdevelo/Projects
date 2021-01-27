package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDAO;

@WebServlet("/member/search_pass.do")
public class SearchPass extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public SearchPass() {
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
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		
		MemberDAO dao = new MemberDAO();
		String pass = dao.search_pass(id, name, email);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		if(pass != null && !pass.equals("")) {
			out.print("<script>alert('비밀번호는 " + pass + "입니다.');history.back();</script>");
		}else {
			out.print("<script>alert('없는 회원입니다.');history.back();</script>");
		}
		out.close();
	}

}
