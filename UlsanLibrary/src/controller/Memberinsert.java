package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import dao.MemberDAO;
import model.Member;


@WebServlet("/member/member_insert.do")
@MultipartConfig(
		fileSizeThreshold = 0,
		location = "C:\\JSP\\UlsanLibrary\\WebContent\\upload"
)
public class Memberinsert extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public Memberinsert() {
        super();

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAll(request, response);//get이든 post든 상관 없이 실행하겠다.

	}
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAll(request, response);//get이든 post든 상관 없이 실행하겠다.		
	}
	
	protected void doAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		Member bean = new Member();
		
		bean.setName(request.getParameter("name"));
		bean.setId(request.getParameter("id"));
		bean.setPass(request.getParameter("pass"));
		bean.setAge(Integer.parseInt(request.getParameter("age")));
		bean.setEmail(request.getParameter("email"));
		
		MemberDAO dao = new MemberDAO();
		dao.insertMember(bean);
		
		response.sendRedirect("joinOk.jsp");
		
	}
}


