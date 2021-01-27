package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.BuyNowDAO;
import dao.MemberDAO;
import dao.OrderDAO;
import model.Order;


@WebServlet("/purchase/paybaro.do")
public class PayBaro extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public PayBaro() {
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
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();

		BuyNowDAO bndao = new BuyNowDAO();
		String num[] = request.getParameter("num").split(",");
		String ip = request.getParameter("ip");
		String bank = request.getParameter("bank");
		String total_price = request.getParameter("sub");
		String mypoint = "";
		
		String whereis = request.getParameter("whereis");
		
		
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
		o.setWhereis(request.getParameter("whereis"));

		
		
		odao.insert_info(o);
		
		String ord_uid = odao.select_uid(o);

		for(String val : num) {
			bndao.daeki(val, bank, ip);
			bndao.insert_uid(val, ord_uid);
		}

		String count_uid = bndao.uid_count(ord_uid);
		bndao.insert_uidCount(count_uid, ord_uid);

		MemberDAO mdao = new MemberDAO();
		mdao.update_pointonly(mypoint, id);


		String jogeon = "";
		if(id.equals("") || id == null) {
			jogeon = "and guest='"+session.getAttribute("guest")+"'";
		}else {
			jogeon = "and id='"+id+"'";
		}

		int count = bndao.buy_count(jogeon);
		session.setAttribute("cart_count", count);

		out.print("<script>alert('감사합니다. 다음날 20시까지 입금 부탁드립니다.');location.href='/';</script>");
		
	}

}
