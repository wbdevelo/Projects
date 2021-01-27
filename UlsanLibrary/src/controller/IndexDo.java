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
import dao.NoticeDAO;
import model.EBook;
import model.Nnotice;


@WebServlet("/index.do")
public class IndexDo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public IndexDo() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAll(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAll(request, response);
	}
	
	protected void doAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		NoticeDAO ndao = new NoticeDAO();
		ArrayList<Nnotice> nv = new ArrayList<Nnotice>();
		nv = ndao.select_notice(0, 5);
		
		EBookDAO edao = new EBookDAO();
		ArrayList<EBook> ev = new ArrayList<EBook>();
		ev = edao.get_best5();
		
		request.setAttribute("nv", nv);
		request.setAttribute("ev", ev);
		
		RequestDispatcher dis = request.getRequestDispatcher("/index.jsp");
		dis.forward(request, response);
	}

}
