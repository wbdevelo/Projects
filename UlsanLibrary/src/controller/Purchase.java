package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CartDAO;
import dao.MemberDAO;
import model.Cart;
import model.Member;


@WebServlet("/purchase/purchase.do")
public class Purchase extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public Purchase() {
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
		HttpSession session = request.getSession();
				
		CartDAO cdao = new CartDAO();
		Cart c = new Cart();
		
		ArrayList<Cart> v = new ArrayList<Cart>();
		
		String num[] = request.getParameter("num").split(",");
		for(String val : num) {
			c = cdao.num_cart(val);
			v.add(c);
		}
		
		MemberDAO mdao = new MemberDAO();
		Member m = new Member();
		m = mdao.viewMember((String)session.getAttribute("id"));
		
		request.setAttribute("m", m);
		request.setAttribute("v", v);
		request.setAttribute("num", request.getParameter("num"));
		request.setAttribute("paymethod", request.getParameter("paymethod"));
		
		RequestDispatcher dis = request.getRequestDispatcher("/purchase/purchase.jsp");
		dis.forward(request, response);
		
	}
				
		
		
}


