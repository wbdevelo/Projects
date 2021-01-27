package controller;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/searchkind.do")
public class Search_Kind extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public Search_Kind() {
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
		
		String kind = request.getParameter("kind");
		String allSearch = request.getParameter("allSearch");
		
		if(kind.equals("gallery")) {
			request.setAttribute("allsearch", allSearch);
			RequestDispatcher dis = request.getRequestDispatcher("/gallery/SelectG");
			dis.forward(request, response);
		}else {
			request.setAttribute("allsearch", allSearch);
			RequestDispatcher dis = request.getRequestDispatcher("/e_book/SelectE");
			dis.forward(request, response);
		}
	}

}
