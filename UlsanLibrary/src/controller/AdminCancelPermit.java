package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CartDAO;
import dao.OrderDAO;

@WebServlet("/admin/account/cancel_permit.do")
public class AdminCancelPermit extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AdminCancelPermit() {
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
		
		String product_num = request.getParameter("product_num");
		String id = request.getParameter("id");
		
		odao.cancel_complete(product_num, id);
		
		
		String product[] = request.getParameter("product_num").split(",");
		for(String val : product) {
			cdao.cancel_complete(val, id);
		}
		
		response.sendRedirect("SelectC.do");
		
	}

}
