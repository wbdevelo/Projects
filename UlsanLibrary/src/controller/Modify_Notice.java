package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.NoticeDAO;
import model.Nnotice;


@WebServlet("/notice/modify_n.do")
public class Modify_Notice extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public Modify_Notice() {
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
		
		int uid = Integer.parseInt(request.getParameter("uid"));
				
		Nnotice n = new Nnotice();
		NoticeDAO ndao = new NoticeDAO();
		
		n = ndao.view_n(uid);
		
		request.setAttribute("n", n);
		request.setAttribute("uid", uid);
		
		RequestDispatcher dis = request.getRequestDispatcher("modify_n.jsp");
		dis.forward(request, response);
		
	}

}
