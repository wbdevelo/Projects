package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CartDAO;
import dao.MemberDAO;
import dao.OrderDAO;
import model.Cart;
import model.Member;
import model.Order;

@WebServlet("/purchase/pay.do")
public class Pay extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Pay() {
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
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		
		CartDAO cdao = new CartDAO();
		String num[] = request.getParameter("num").split(",");
		String ip = request.getParameter("ip");
		String bank = request.getParameter("bank");
		String total_price = request.getParameter("sub");
		String mypoint = "";
		if(request.getParameter("mypoint") == null || request.getParameter("mypoint") == "") {
			mypoint = "0";
		}else {
			mypoint = request.getParameter("mypoint");
		}
		String id = "";
		
		if(session.getAttribute("id") == null) {
			id = "";
		}else {
			id = (String)session.getAttribute("id");
		}
		
		
		OrderDAO odao = new OrderDAO();
		Order o = new Order();
		o.setBank(bank);
		o.setGuest((String)session.getAttribute("guest"));
		o.setIpkumja(ip);
		o.setPrice(total_price);
		o.setProduct_num(request.getParameter("num"));
		o.setPassword(request.getParameter("pass"));
		o.setId(id);
		
		odao.insert_info(o);
		
		String ord_uid = odao.select_uid(o);

		for(String val : num) {
			cdao.daeki(val, bank, ip);
			cdao.insert_uid(val, ord_uid);
		}
		
		String count_uid = cdao.uid_count(ord_uid);
		cdao.insert_uidCount(count_uid, ord_uid);
		
		MemberDAO mdao = new MemberDAO();
		mdao.update_pointonly(mypoint, id);
		
		
		String jogeon = "";
		if(id.equals("") || id == null) {
			jogeon = "and guest='"+session.getAttribute("guest")+"'";
		}else {
			jogeon = "and id='"+id+"'";
		}
		
		int count = cdao.cart_count(jogeon);
		session.setAttribute("cart_count", count);
		
		Date today = new Date();
		SimpleDateFormat cal = new SimpleDateFormat("yyyyMMdd");
		String signdate = cal.format(today);
		
		signdate = signdate.substring(0, 4)+"-"+signdate.substring(4, 6)+"-"+ (Integer.parseInt(signdate.substring(6, 8))+2);
		
		request.setAttribute("price", total_price);
		request.setAttribute("signdate", signdate);
		
		RequestDispatcher dis = request.getRequestDispatcher("gumaeOk.jsp");
		dis.forward(request, response);
	}

}
