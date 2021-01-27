package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CartDAO;
import model.Cart;

@WebServlet("/cart/SelectC.do")
public class SelectCartList extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public SelectCartList() {
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
		ArrayList<Cart> v = new ArrayList<Cart>();
		
		String id = request.getParameter("id");
		String guest = request.getParameter("guest");
		String jogeon = "";
		
		if(id.equals("")) {
			jogeon = "and guest='"+guest+"'";
		}else {
			jogeon = "and id='"+id+"'";
		}
		
		v = cdao.select_cart(jogeon);
		
		request.setAttribute("v", v);
		
		RequestDispatcher dis = request.getRequestDispatcher("cart_list.jsp");
		dis.forward(request, response);
		
	}

}
