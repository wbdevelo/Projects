package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.javafx.scene.control.skin.VirtualFlow.ArrayLinkedList;

import dao.CartDAO;
import model.Cart;

/**
 * Servlet implementation class ViewDetail
 */
@WebServlet("/admin/account/detail.do")
public class ViewDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ViewDetail() {
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
		ArrayList<Cart> cv = new ArrayList<Cart>();
		Cart c = new Cart();
		
		String jogeon = "";
		if(request.getParameter("id") == null) {
			jogeon = "and guest='"+request.getParameter("guest")+"'";
		}else {
			jogeon = "and id='"+request.getParameter("id")+"'";
		}
		
		String product_num[] = request.getParameter("product_num").split(",");
		for(String val : product_num) {
			c = cdao.get_detail(jogeon, val);
			cv.add(c);
		}
		
		request.setAttribute("cv", cv);
		request.setAttribute("state", request.getParameter("state"));
		
		RequestDispatcher dis = request.getRequestDispatcher("detail_view.jsp");
		dis.forward(request, response);
	}

}
