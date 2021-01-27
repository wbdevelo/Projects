package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDAO;
import model.Member;


@WebServlet("/member/naverLogin.do")
public class NaverLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public NaverLogin() {
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
		
		String email = request.getParameter("email");
		String name = request.getParameter("name");
		String guest = request.getParameter("guest");
		String id = request.getParameter("id");
		
		Member bean = new Member();
		bean.setEmail(email);
		bean.setId(email);
		bean.setName(name);
		bean.setPass("");
		bean.setAge(0);
		
		MemberDAO mdao = new MemberDAO();
		int count = mdao.loginMember(id, "");
		if(count == 0) {
			mdao.insertMember(bean);
		}
		mdao.loginSelect(id, "");
		
		HttpSession session = request.getSession();
		session.setAttribute("id", email);
		session.setAttribute("name", name);
		session.setAttribute("level", "1");
		
		response.sendRedirect("/");
	}

}
