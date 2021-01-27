package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.OrderDAO;
import model.Order;

@WebServlet("/admin/account/SelectA.do")
public class AdminSelectAccount extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AdminSelectAccount() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAll(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAll(request, response);
	}
	
	protected void doAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		OrderDAO odao = new OrderDAO();
		ArrayList<Order> ov = new ArrayList<Order>();
		ov = odao.get_all();
		
		request.setAttribute("ov", ov);
		
		RequestDispatcher dis = request.getRequestDispatcher("account_list.jsp");
		dis.forward(request, response);
	}

}
