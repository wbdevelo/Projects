package e_controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.EBookDAO;
import model.EBook;


@WebServlet("/e_book/view_writerBook.do")
public class View_writerBook extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public View_writerBook() {
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
		
		String writer = request.getParameter("writer");
		
		EBookDAO edao = new EBookDAO();
		
		ArrayList<EBook> v = new ArrayList<EBook>();
		
		v = edao.get_writerbook(writer);
		request.setAttribute("v", v);
		RequestDispatcher dis = request.getRequestDispatcher("/e_book/view_writerbook.jsp");
		dis.forward(request, response);
		
	}

}
