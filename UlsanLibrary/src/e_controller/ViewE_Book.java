package e_controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.EBookDAO;
import model.EBook;


@WebServlet("/e_book/view_e.do")
public class ViewE_Book extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public ViewE_Book() {
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
		HttpSession session = request.getSession();
		
		int uid = Integer.parseInt(request.getParameter("uid"));
		String writer = request.getParameter("writer");
		
		EBook e = new EBook();
		
		EBookDAO ed = new EBookDAO();
		
		e = ed.view_ebook(uid);
		
		ArrayList<EBook> v = new ArrayList<>();
		v = ed.view_otherbook(writer);
		
		//최근 본 상품 
		if(session.getAttribute("recent") == null) {
			session.setAttribute("recent", request.getParameter("uid"));
		}else {
			session.setAttribute("recent", request.getParameter("uid")+"_"+session.getAttribute("recent"));
		}
		
		request.setAttribute("category", request.getParameter("category"));
		request.setAttribute("e", e);
		request.setAttribute("v", v);
		RequestDispatcher dis = request.getRequestDispatcher("view_e.jsp");
		dis.forward(request, response);
		
	}

}
