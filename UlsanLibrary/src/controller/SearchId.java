package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDAO;

@WebServlet("/member/search_id.do")
public class SearchId extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public SearchId() {
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
		
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		
		MemberDAO dao = new MemberDAO();
		String id = dao.search_id(name, email);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		if(id != null && !id.equals("")) {
			out.print("<script>alert('아이디는 " + id + " 입니다.');history.back();</script>");
		}else {
			out.print("<script>alert('회원이 아닙니다.');history.back();</script>");
		}
		out.close();
		
	}

}
