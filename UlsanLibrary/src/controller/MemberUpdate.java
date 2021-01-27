package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDAO;
import model.Member;


@WebServlet("/member/member_update.do")
public class MemberUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public MemberUpdate() {
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
	 
	 Member bean = new Member();

	 bean.setName(request.getParameter("name"));
	 bean.setId(request.getParameter("id"));
	 bean.setPass(request.getParameter("pass"));
	 bean.setAge(Integer.parseInt(request.getParameter("age")));
	 bean.setEmail(request.getParameter("email"));
	 bean.setLevel(request.getParameter("level"));
	 
	 MemberDAO dao = new MemberDAO();
	 
	 dao.modifymember(bean);
	 //System.out.println("=-=-=-=-=-=-=-=-=-");
	 response.sendRedirect("/member/userinfo.do?id="+request.getParameter("id"));
	 
		
	}

}
