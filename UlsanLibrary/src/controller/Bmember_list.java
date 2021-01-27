package controller;

import java.io.IOException;
import java.io.PrintWriter;
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

@WebServlet("/b_member/bmember_list.do")
public class Bmember_list extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Bmember_list() {
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
		
		String guest = request.getParameter("guest_num");
		String pass = request.getParameter("pass");
		
		CartDAO cdao = new CartDAO();
		OrderDAO odao = new OrderDAO();
		ArrayList<Order> v = new ArrayList<Order>();
		
		int count = odao.check_mok(guest, pass);
		if(count != 0) {
			v = odao.get_gumae(guest);
		
			Date today = new Date();
			SimpleDateFormat cal = new SimpleDateFormat("yyyyMMdd");
			String todate = cal.format(today);
			
			request.setAttribute("v", v);
			request.setAttribute("todate", todate);
			
			RequestDispatcher dis = request.getRequestDispatcher("B_list.jsp");
			dis.forward(request, response);
		}else {
			PrintWriter out = response.getWriter();
			out.print("<script>alert('입력하신 정보와 일치하는 것이 없습니다.');location.href='/b_member/chk_num.jsp';</script>");
		}
		
	}

}
