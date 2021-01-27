package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CartDAO;
import dao.OrderDAO;

@WebServlet("/b_member/Bmem_down.do")
public class BmemFileClick extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public BmemFileClick() {
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
		
		String guest = request.getParameter("guest");
		
		CartDAO cdao = new CartDAO();
		cdao.click_count(request.getParameter("product_num"));
		
		OrderDAO odao = new OrderDAO();
		String pass = odao.get_pass(guest);
		
		response.sendRedirect("bmember_mokrok.do?guest_num="+guest+"&pass="+pass);
		
	}

}
