package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CartDAO;
import dao.OrderDAO;


@WebServlet("/admin/pay/adminCancel.do")
public class AdminCancel extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public AdminCancel() {
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
		OrderDAO odao = new OrderDAO();
		
		String ord_uid = request.getParameter("uid");
		
		cdao.cancelG(ord_uid);
		odao.cancel_mu(ord_uid);
		
		response.sendRedirect("mu.do");
	}

}
