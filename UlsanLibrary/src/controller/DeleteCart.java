package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CartDAO;
import model.Cart;

@WebServlet("/cart/deleteC.do")
public class DeleteCart extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public DeleteCart() {
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
		Cart c = new Cart();
		
		HttpSession session = request.getSession();
		
		String num [] = request.getParameter("num").split(",");
		for(int i=0; i<num.length; i++) {
			c = cdao.num_cart(num[i]);
			cdao.delete_cart(num[i]);
		}
		
		String jogeon = "";
		if(c.getId().equals("")) {
			jogeon = "and guest='"+c.getGuest()+"'";
		}else {
			jogeon = "and id='"+c.getId()+"'";
		}
		
		int count = cdao.cart_count(jogeon);
		session.setAttribute("cart_count", count);
		
		response.sendRedirect("SelectC.do?id="+c.getId()+"&guest="+c.getGuest());
		
	}

}
