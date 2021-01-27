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

@WebServlet("/gallery/modify_gallery.do")
public class ModifyGallery extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ModifyGallery() {
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
		
		int uid = Integer.parseInt(request.getParameter("uid"));
		
		GalleryDAO gdao = new GalleryDAO();
		Gallery g = new Gallery();
		g = gdao.modify_gallery(uid);
		
		request.setAttribute("g", g);
		
		RequestDispatcher dis = request.getRequestDispatcher("modify_g.jsp");
		dis.forward(request, response);
	}

}
