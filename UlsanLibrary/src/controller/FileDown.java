package controller;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CartDAO;

@WebServlet("/member/down.do")
public class FileDown extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public FileDown() {
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
		cdao.click_count(request.getParameter("product_num"));
		
		String ord_uid = request.getParameter("ord_uid");
		String ddate = request.getParameter("ddate");
		String ddateh = request.getParameter("ddateh");
		
		
		String count = cdao.click_num(ord_uid);
		
		response.sendRedirect("gumaemokrok.do?page=down&uid="+ord_uid+"&click_count="+count+"&ddate="+URLEncoder.encode(ddate)+"&ddateh="+URLEncoder.encode(ddateh));
		
	}

}
