package controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CartDAO;
import model.Cart;


@WebServlet("/b_member/bmember_mokrok.do")
public class Bmember_mokrok extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public Bmember_mokrok() {
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
		
		String uid = request.getParameter("uid");
		
		CartDAO cdao = new CartDAO();
		ArrayList<Cart> cv = new ArrayList<Cart>();
		cv = cdao.get_gumae(uid);
		
		Date today = new Date();
		SimpleDateFormat cal = new SimpleDateFormat("yyyyMMdd");
		String todate = cal.format(today);
		
		request.setAttribute("cv", cv);
		request.setAttribute("todate", todate);
		
		RequestDispatcher dis = request.getRequestDispatcher("gumae_mokrok.jsp");
		dis.forward(request, response);
		
	}

}
