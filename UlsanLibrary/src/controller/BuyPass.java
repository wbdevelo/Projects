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
import dao.MemberDAO;
import model.Cart;
import model.EBook;
import model.Member;


@WebServlet("/e_book/BuyPass.do")
public class BuyPass extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public BuyPass() {
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
	
		Cart c = new Cart();
		CartDAO cdao = new CartDAO();
		EBookDAO edao = new EBookDAO();
		EBook e = new EBook();
		ArrayList<Cart> v = new ArrayList<>();
		
		
		int uid = Integer.parseInt(request.getParameter("uid"));
		e = edao.view_ebook(uid);
		
		Date today = new Date();
		SimpleDateFormat cal = new SimpleDateFormat("yyyyMMddHHmmss");
		String signdate = cal.format(today);
		
		String num = signdate + "_" + (int)(Math.random()*1000000);
		
		c.setFile(e.getFile());
		c.setId(request.getParameter("id"));
		c.setPurchase("x");
		c.setTitle(e.getTitle());
		c.setGuest(request.getParameter("guest"));
		c.setPrice(e.getPrice());
		c.setProduct_num(num);
		c.setThum_file(e.getThum_file());
		c.setBookfile(e.getBook_file());
		c.setPoint(e.getPoint());
		String gubun = "bn";
		
		cdao.insert_cart(c, gubun);
		
		MemberDAO mdao = new MemberDAO();
		Member m = new Member();
		m = mdao.viewMember(request.getParameter("id"));
		
		String jogeon = "";
		if(c.getId().equals("")) {
			jogeon = "and guest='"+c.getGuest()+"'";
		}else {
			jogeon = "and id='"+c.getId()+"'";
		}
		
		int count = cdao.cart_count(jogeon);
		HttpSession session = request.getSession();
		session.setAttribute("cart_count", count);
		
		v = cdao.select_cart(jogeon);
		
		response.sendRedirect("/purchase/purchase.do?num="+num+",");
	}

}
