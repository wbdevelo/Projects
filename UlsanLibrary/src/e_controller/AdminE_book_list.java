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


@WebServlet("/admin/include/AdminBook_list.do")
public class AdminE_book_list extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public AdminE_book_list() {
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
		
		EBookDAO ed = new EBookDAO();
		ArrayList<EBook> v = new ArrayList<>();
		
		int pagePerSize = 20;
		int pagePerBlock = 5;
		int pageNum = 1;
		if(request.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
		
		int count = 0;
		int number = 0;
		int startRow = (pageNum - 1) * pagePerSize;
		int endRow = pagePerSize;
		
		count = ed.getAllCount();
		number = count - (pageNum -1) * pagePerSize;
		
		if(request.getParameter("search") != null && !request.getParameter("search").equals("")) {
			v = ed.adminSearch_ebook(request.getParameter("search"), startRow, endRow);
		}else {
			v = ed.adminSelect_ebook(startRow, endRow);
		}
		
		request.setAttribute("v", v);
		request.setAttribute("count", count);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("number", number);
		request.setAttribute("pagePerSize", pagePerSize);
		request.setAttribute("pagePerBlock", pagePerBlock);
		
		RequestDispatcher dis = request.getRequestDispatcher("/admin/admin_EBook/admin_ebook_list.jsp");
		dis.forward(request, response);
		
		
	}

}
