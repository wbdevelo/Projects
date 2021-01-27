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


@WebServlet("/notice/view_n.do")
public class ViewNotice extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public ViewNotice() {
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
		
		NoticeDAO ndao = new NoticeDAO();
		Nnotice n = new Nnotice();
		
		int uid = Integer.parseInt(request.getParameter("uid"));
		
		n = ndao.view_n(uid);
		
		request.setAttribute("n", n);
		request.setAttribute("uid", uid);
		RequestDispatcher dis = request.getRequestDispatcher("view_n.jsp");
		dis.forward(request, response);
		
	}

}


