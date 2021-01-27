package controller;

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

@WebServlet("/e_book/writer_book.do")
public class WriterBook extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public WriterBook() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAll(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAll(request, response);
	}
	
	protected void doAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String writer = request.getParameter("writer");
		
		EBookDAO edao = new EBookDAO();
		ArrayList<EBook> ev = new ArrayList<EBook>();
 		ev = edao.getBook_writer(writer);
 		
 		request.setAttribute("ev", ev);
 		
 		RequestDispatcher dis = request.getRequestDispatcher("writer_book.jsp");
 		dis.forward(request, response);
	}

}
