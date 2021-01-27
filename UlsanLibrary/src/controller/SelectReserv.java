package controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ReservDAO;
import model.Reservation;

@WebServlet("/library/SelectReserv.do")
public class SelectReserv extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public SelectReserv() {
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
		response.setContentType("text/html; charset=utf-8");
		
		String lib_name = URLDecoder.decode(request.getParameter("lib_name"));
		
		ReservDAO rdao = new ReservDAO();
		ArrayList<Reservation> rv = new ArrayList<Reservation>();
		rv = rdao.Select_reserv(lib_name);
	
		Date today = new Date();
		SimpleDateFormat cal = new SimpleDateFormat("yyyyMMdd");
		String todate = cal.format(today);
		
		request.setAttribute("rv", rv);
		request.setAttribute("todate", todate);
		
		RequestDispatcher dis = request.getRequestDispatcher("reserv_list.jsp");
		dis.forward(request, response);
	}

}
