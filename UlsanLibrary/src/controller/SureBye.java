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


@WebServlet("/member/surebye.do")
public class SureBye extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public SureBye() {
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
		
		bean  = dao.deleteviewMember(id);
		
		request.setAttribute("modify", bean);//bean객체를 modify객체로 이름 바꿔서 포워드
		request.setAttribute("id", id);
		
		RequestDispatcher dis = request.getRequestDispatcher("/member/surebye.jsp");
		dis.forward(request, response);//포워드 시키고싶다면 이걸 계속 쓰면 된다.
		
	}

}
