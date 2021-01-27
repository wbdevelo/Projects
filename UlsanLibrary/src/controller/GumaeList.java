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

@WebServlet("/member/gumaemokrokList.do")
public class GumaeList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public GumaeList() {
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
		ArrayList<Order> ov = new ArrayList<Order>();
		
		String id = request.getParameter("id");
		String guest = request.getParameter("guest");
		String jogeon = "";
		
		if(id.equals("") || id == null) {
			jogeon = "and guest='"+guest+"'";
		}else {
			jogeon = "and id='"+id+"'";
		}
		
		ov = odao.get_mokrok(jogeon);
		
		int count = odao.get_count(jogeon);
		
		
		request.setAttribute("ov", ov);
		request.setAttribute("count", count);
		
		RequestDispatcher dis = request.getRequestDispatcher("gumaeList.jsp");
		dis.forward(request, response);
	}

}
