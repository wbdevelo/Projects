package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CartDAO;
import dao.OrderDAO;

@WebServlet("/member/cancel.do")
public class CancelGumae extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public CancelGumae() {
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
		
		String id = request.getParameter("id");
		String guest = request.getParameter("guest");
		String ord_uid = request.getParameter("ord_uid");
		
		CartDAO cdao = new CartDAO();
		cdao.cancelG(ord_uid);
  
		OrderDAO odao = new OrderDAO(); 
		odao.cancelGumae(ord_uid);
	  
		response.sendRedirect("gumaemokrokList.do?id="+id+"&guest="+guest); 
		 
		
		 
		
	}

}
