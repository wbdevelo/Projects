package e_controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.EBookDAO;
import model.EBook;


@WebServlet("/admin/AdminModifyE_Book.do")
public class AdminModifyE_Book extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminModifyE_Book() {
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
		
		EBook e = new EBook();
		EBookDAO edao = new EBookDAO();
		
		e = edao.view_ebook(uid);
		
		request.setAttribute("e", e);
		
		RequestDispatcher dis = request.getRequestDispatcher("/admin/admin_EBook/modify_e.jsp");
		dis.forward(request, response);
		
	}

}
