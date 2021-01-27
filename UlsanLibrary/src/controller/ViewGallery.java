package controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.GalleryDAO;
import dao.ReservDAO;
import model.Gallery;
import model.RowNum;

@WebServlet("/gallery/view_g.do")
public class ViewGallery extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ViewGallery() {
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
		response.setContentType("text/html; charset=utf-8");
		HttpSession session = request.getSession();
		
		int uid = Integer.parseInt(request.getParameter("uid"));
		String title = request.getParameter("title");
		String lib_name = URLDecoder.decode(request.getParameter("lib_name"));
		
		String id = (String)session.getAttribute("id");
		
		GalleryDAO gdao = new GalleryDAO();
		Gallery g = new Gallery();
		ArrayList<Gallery> v = new ArrayList<Gallery>();
		
		v = gdao.view_gallery(uid, title, lib_name, id);
		
		
		request.setAttribute("v", v);
		
		RequestDispatcher dis = request.getRequestDispatcher("view_g.jsp");
		dis.forward(request, response);
	}

}
