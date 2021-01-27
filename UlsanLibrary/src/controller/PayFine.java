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


@WebServlet("/purchase/PayFine.do")
public class PayFine extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public PayFine() {
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
		HttpSession session = request.getSession();
		
		String id = (String)session.getAttribute("id");
		
		ArrayList<Member> m = new ArrayList<>();
		MemberDAO dao = new MemberDAO();
		
		m = dao.view_paymem(id);
		
		
		ArrayList<Cart> v = new ArrayList<>();
		CartDAO cdao = new CartDAO();
		
		v = cdao.view_paycart(id);
		
		request.setAttribute("m", m);
		request.setAttribute("v", v);
		RequestDispatcher dis = request.getRequestDispatcher("/purchase/pay_fine.jsp");
		dis.forward(request, response);
		
		
	}


}
