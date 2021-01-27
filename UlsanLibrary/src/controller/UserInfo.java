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


@WebServlet("/member/userinfo.do")
public class UserInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public UserInfo() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doALL(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doALL(request, response);
	}

	protected void doALL(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		Member bean = new Member();
		
		MemberDAO dao = new MemberDAO();
		
		bean = dao.viewMember(id);
		
		request.setAttribute("modify", bean);
		
		RequestDispatcher dis = request.getRequestDispatcher("userinfo.jsp");
		dis.forward(request, response);
		
		
	}

}
