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

@WebServlet("/admin/account/SelectC.do")
public class AdminSelectCancel extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AdminSelectCancel() {
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
		
		ov = odao.select_cancel();
		
		request.setAttribute("ov", ov);
		
		RequestDispatcher dis = request.getRequestDispatcher("cancel_list.jsp");
		dis.forward(request, response);
		
	}

}
