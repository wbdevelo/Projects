package controller;

import java.io.IOException;
import java.net.URLDecoder;
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
import dao.OrderDAO;
import model.Cart;
import model.Order;

@WebServlet("/member/gumaemokrok.do")
public class GumaeMokrok extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public GumaeMokrok() {
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
		
		CartDAO cdao = new CartDAO();
		OrderDAO odao = new OrderDAO();
		ArrayList<Cart> v = new ArrayList<>();
		ArrayList<Order> ov = new ArrayList<Order>();
		
		String uid = request.getParameter("uid");
		
		v = cdao.get_mokrok(uid);
		String click_count = cdao.click_num(uid);
		String count_uid = cdao.uid_count(uid);
		
		Date today = new Date();
		SimpleDateFormat cal = new SimpleDateFormat("yyyyMMdd");
		String todate = cal.format(today);
		String ddateh = "";
		String ddate = "";
		if(request.getParameter("page") == null) {
			ddateh = request.getParameter("ddateh");
			ddate = request.getParameter("ddate");
		}else {
			ddate = URLDecoder.decode(request.getParameter("ddate"));
			ddateh = URLDecoder.decode(request.getParameter("ddateh"));
		}
		
		request.setAttribute("todate", todate);
		request.setAttribute("v", v);
		request.setAttribute("click_count", click_count);
		request.setAttribute("count_uid", count_uid);
		request.setAttribute("ord_uid", uid);
		request.setAttribute("ddateh", ddateh);
		request.setAttribute("ddate", ddate);
		
		RequestDispatcher dis = request.getRequestDispatcher("gumae_mokrok.jsp");
		dis.forward(request, response);
		
	}

}