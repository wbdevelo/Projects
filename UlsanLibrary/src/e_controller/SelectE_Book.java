package e_controller;

import java.io.IOException;
import java.net.URLDecoder;
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
import dao.JjimDAO;
import model.EBook;
import model.Jjim;


@WebServlet("/e_book/SelectE")
public class SelectE_Book extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public SelectE_Book() {
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
		
		//category
		String category = request.getParameter("category");
		String ord = "";
		if(request.getParameter("ord") == null) {
		
		}else {
			ord = request.getParameter("ord");
		}
		String jogeon = "";
		if(ord.equals("sell")) {
			jogeon = " order by sell desc";
		}else if(ord.equals("priceL")) {
			jogeon = " order by price asc";
		}else if(ord.equals("priceH")){
			jogeon = " order by price desc";
		}else {
			
		}
		
		String search = "";
		if(request.getAttribute("allsearch") != null && !request.getAttribute("allsearch").equals("")) {
			search = (String)request.getAttribute("allsearch");
		}else {
			if(request.getParameter("search") != null && !request.getParameter("search").equals("")) {
				search = request.getParameter("search");
			}else {
				
			}
		}
		
		if(search != null && !search.equals("")) {
			if(category == null || category.equals("")) {
				v = ed.search_ebook(search, startRow, endRow, jogeon);
			}else {
				v = ed.searchNcategory(search, startRow, endRow, category, jogeon);
			}
		}else {
			if(category == null || category.equals("")) {
				v = ed.select_ebook(startRow, endRow, jogeon);
			}else {
				v = ed.category_ebook(startRow, endRow, category, jogeon);
			}
		}
		
		JjimDAO jdao = new JjimDAO();
		String id = (String)session.getAttribute("id");
		ArrayList<Jjim> jv = new ArrayList<Jjim>();
		
		if(id != null) {
			int e_count = ed.getAllCount();
			int count_id = jdao.checkId(id);
			if(count_id == 0 ) {
				jdao.insert_all(id);
			}else if(count_id < e_count) {
				jdao.insert_new(id, count_id, e_count-count_id);
			}else {
				
			}
			
			jv = jdao.get_jjim(id);
			request.setAttribute("jv", jv);
			
		}
		
		ArrayList<EBook> ev = new ArrayList<EBook>();
		ev = ed.get_best();
		
		EBook eb = new EBook();
		ArrayList<EBook> rev = new ArrayList<EBook>();
		//오늘 본 목록 불러오기
		String session_recent = "";
		String previous = "";
		if(session.getAttribute("recent") == null) {
			
		}else {
			session_recent = (String)session.getAttribute("recent");
			String[] r = session_recent.split("_");
			for(String val : r) {
				if(previous.equals(val)) {
					
				}else {
					previous = val;
					eb = ed.get_recent(val);
					rev.add(eb);
				}
			}
		}
		
		
		request.setAttribute("ev", ev);
		request.setAttribute("v", v);
		request.setAttribute("count", count);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("number", number);
		request.setAttribute("pagePerSize", pagePerSize);
		request.setAttribute("pagePerBlock", pagePerBlock);
		request.setAttribute("jv", jv);
		request.setAttribute("category", category);
		request.setAttribute("search", search);
		request.setAttribute("rev", rev);
		
		RequestDispatcher dis = request.getRequestDispatcher("list_e.jsp");
		dis.forward(request, response);
		
		
		
		
		
	}

}
