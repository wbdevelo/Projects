package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDAO;
import model.Member;


@WebServlet("/member/bye_relog.do")
public class ByeRelog extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public ByeRelog() {
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
		response.setContentType("text/html;charset = utf-8");
		
		String id  = request.getParameter("id");
		String pass = request.getParameter("pass");
		
		int total_record = 0;
		
		MemberDAO dao = new MemberDAO();
		
		total_record = dao.loginMember(id, pass);//DAO에서 처리한 loginMember() 객체를 total_record변수에 대입하여 쓰겠다
		
		Member bean = new Member();
		if(total_record == 1) {
			bean = dao.loginSelect(id,pass);
			
			if(!bean.getState().equals("x") && !bean.getState().equals("X")) {
			
			response.sendRedirect("surebye.do");
			
			}else {
				
				PrintWriter out = response.getWriter();//이걸 쓸때는 response.setContentType("text/html;charset = utf-8"); 를 써라
				out.print("<script> alert('탈퇴한 회원입니다. 가입이 필요합니다.'); location.href = '/member/login.jsp'; </script>");
			}
			
			
		}else{
			request.setAttribute("msg", "아이디 또는 비밀번호 일치하지 않습니다.");
			request.setAttribute("url", "login.jsp");
			
			RequestDispatcher dis = request.getRequestDispatcher("/error.jsp");
			dis.forward(request, response);
		}
		
	}

}
