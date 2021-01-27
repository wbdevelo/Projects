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

@WebServlet("/admin/pay/mu.do")
public class AdminMutongjang extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AdminMutongjang() {
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
		
		String gubun = request.getParameter("gubun");
		
		OrderDAO odao = new OrderDAO();
		ArrayList<Order> v = new ArrayList<Order>();
		
		if(gubun == null || gubun.equals("전체")) {
			v = odao.get_all();
		}else if(gubun.equals("gDaeki")){
			v = odao.get_daeki();
		}else if(gubun.equals("cDaeki")) {
			v = odao.get_cDaeki();
		}else if(gubun.equals("c")) {
			v = odao.select_cancel();
		}else {
			v = odao.get_gumae();
		}
		
		request.setAttribute("v", v);
		request.setAttribute("gubun", gubun);
		
		RequestDispatcher dis = request.getRequestDispatcher("mu.jsp");
		dis.forward(request, response);
	}

}
