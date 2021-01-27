package controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CartDAO;
import dao.OrderDAO;

@WebServlet("/admin/pay/gumae_complete.do")
public class AdminGumaeComplete extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AdminGumaeComplete() {
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
		Date today = new Date();
		SimpleDateFormat cal = new SimpleDateFormat("yyyyMMdd");
		String date = cal.format(today);
		
		odao.gumaeComplete(request.getParameter("product_num"), date);
		
		CartDAO cdao = new CartDAO();
		String p_num[] = request.getParameter("product_num").split(",");
		for(String val : p_num) {
			cdao.guComp(val, date);
		}
		
		response.sendRedirect("mu.do");
	}

}
