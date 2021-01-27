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

@WebServlet("/member/myG.do")
public class MyGallery extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public MyGallery() {
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
		
		GalleryDAO gdao = new GalleryDAO();
		ArrayList<Gallery> v = new ArrayList<>();
		
		v = gdao.my_g(request.getParameter("lib_name"));
		
		request.setAttribute("v", v);

		RequestDispatcher dis = request.getRequestDispatcher("my_g.jsp");
		dis.forward(request, response);
		
	}

}
