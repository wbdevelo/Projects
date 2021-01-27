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


@WebServlet("/admin/member/member_delete.do")
public class AdminMemberDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public AdminMemberDelete() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doALL(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doALL(request, response);
	}
	
	protected void doALL(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doALL(request, response);
		
		String id = request.getParameter("id");
		
		request.setCharacterEncoding("utf-8");
		
		Member bean = new Member();
		
		MemberDAO dao = new MemberDAO();
		
		bean  = dao.deleteviewMember(id);
		
		request.setAttribute("modify", bean);//bean객체를 modify로 바꿔서 포워드
		
		RequestDispatcher dis = request.getRequestDispatcher("/admin/member/member_delete.jsp");
		dis.forward(request, response);//포워드 시키고싶다면 이걸 계속 쓰면 된다.
		
	}

}
