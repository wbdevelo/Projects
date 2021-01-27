package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.GalleryDAO;
import model.Gallery;

@WebServlet("/gallery/SelectG")
public class SelectGallery extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public SelectGallery() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAll(request, response);
	}
	
	protected void doAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		GalleryDAO gd = new GalleryDAO();
		ArrayList<Gallery> v = new ArrayList<>();
		
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
		
		count = gd.getAllCount();
		number = count - (pageNum -1) * pagePerSize;
		
		//검색조건 checkbox
		int check_count = 0;
		String[] value =  new String[5];
		String[] result = new String[5];
		String a = "";
		int j = 0;
		
		if(request.getParameterValues("lib") == null) {
			if(request.getParameter("a") == null) {
				value[0] = "울산남부도서관";
				value[1] = "울산중부도서관";
				value[2] = "울산동부도서관";
				value[3] = "울산북구도서관";
				value[4] = "울주군도서관";
			}else {
				value[0] = "";
				value[1] = "";
				value[2] = "";
				value[3] = "";
				value[4] = "";
			}
		}else{
			value = request.getParameterValues("lib");
		}
		
		for(int i=0; i<value.length; i++) {
			if(value[i] != null) {
				check_count++;
				a = value[i];
				result[j] = a;
				j++;
			}
		}
		
		String jogeon = "";
		if(check_count == 1) {
			jogeon = "and (lib_name='"+result[0]+"')";
		}else if(check_count == 2) {
			jogeon = "and (lib_name='"+result[0]+"' or lib_name='"+result[1]+"')";
		}else if(check_count == 3) {
			jogeon = "and (lib_name='"+result[0]+"' or lib_name='"+result[1]+"' or lib_name='"+result[2]+"')";
		}else if(check_count == 4){
			jogeon = "and (lib_name='"+result[0]+"' or lib_name='"+result[1]+"' or lib_name='"+result[2]+"' or lib_name='"+result[3]+"')";
		}else{
			jogeon = "and (lib_name='"+result[0]+"' or lib_name='"+result[1]+"' or lib_name='"+result[2]+"' or lib_name='"+result[3]+"' or lib_name='"+result[4]+"')";
		}
		
		int search_count = 0;
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
			v = gd.search_gallery(search, startRow, endRow, jogeon);
			search_count = gd.search_count(search, jogeon);
		}else {
			v = gd.select_gallery(startRow, endRow, jogeon);
			search_count = gd.search_count(search, jogeon);
		}
		
		request.setAttribute("v", v);
		request.setAttribute("count", count);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("number", number);
		request.setAttribute("pagePerSize", pagePerSize);
		request.setAttribute("pagePerBlock", pagePerBlock);
		request.setAttribute("lib_value", value);
		request.setAttribute("search_count", search_count);
		
		RequestDispatcher dis = request.getRequestDispatcher("list_g.jsp");
		dis.forward(request, response);
		
	}

}
