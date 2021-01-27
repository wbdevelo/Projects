package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CartDAO;
import dao.OrderDAO;


@WebServlet("/admin/pay/mu_cancel.do")
public class MuCancel extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public MuCancel() {
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
		OrderDAO odao = new OrderDAO();
		CartDAO cdao = new CartDAO();
		
		String ord_uid = request.getParameter("uid");
		
		cdao.cancel_mu(ord_uid);
		odao.cancel_mu(ord_uid);
		
		response.sendRedirect("/admin/pay/mu.do");
		
	}

}
