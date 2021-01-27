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
import javax.servlet.http.HttpSession;

import dao.CartDAO;
import dao.EBookDAO;
import model.Cart;
import model.EBook;

@WebServlet("/cart/cartSI")
public class Cart_SI extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Cart_SI() {
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
	
		Cart c = new Cart();
		CartDAO cdao = new CartDAO();
		EBookDAO edao = new EBookDAO();
		EBook e = new EBook();
		ArrayList<Cart> v = new ArrayList<>();
		
		String gubun = "";
		int uid = Integer.parseInt(request.getParameter("uid"));
		e = edao.view_ebook(uid);
		
		Date today = new Date();
		SimpleDateFormat cal = new SimpleDateFormat("yyyyMMddHHmmss");
		String signdate = cal.format(today);
		
		String product_num = signdate + "_" + (int)(Math.random()*1000000);
		
		c.setFile(e.getFile());
		c.setId(request.getParameter("id"));
		c.setPurchase("x");
		c.setTitle(e.getTitle());
		c.setGuest(request.getParameter("guest"));
		c.setPrice(e.getPrice());
		c.setProduct_num(product_num);
		c.setThum_file(e.getThum_file());
		c.setBookfile(e.getBook_file());
		c.setPoint(e.getPoint());
		
		cdao.insert_cart(c, gubun);
		
		
		response.sendRedirect("/cart/SelectC.do?id="+c.getId()+"&guest="+c.getGuest());
		
	}
}
