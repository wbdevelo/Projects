package controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AlarmDAO;
import dao.ReservDAO;
import model.Alarm;


@WebServlet("/ReservationAlarm/confirm_reserv.do")
public class ConfirmReserv extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public ConfirmReserv() {
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
		
		String id = request.getParameter("id");
		String lib_name = request.getParameter("lib_name");
		int book_uid = Integer.parseInt(request.getParameter("book_uid"));
		int uid = Integer.parseInt(request.getParameter("uid"));
		
		ReservDAO rdao = new ReservDAO();
		rdao.update_stateSincheong(lib_name, id, book_uid);
		
		AlarmDAO adao = new AlarmDAO();
		Alarm a = new Alarm();
		a = adao.select_uid(id, lib_name, book_uid);
		
		Date today = new Date();
		SimpleDateFormat cal = new SimpleDateFormat("yyyyMMdd");
		String readDate = cal.format(today);
		
		adao.insert_hwackDate(uid, readDate);
		
		readDate = readDate.substring(0, 4)+"년 "+readDate.substring(4, 6)+"월 "+ (Integer.parseInt(readDate.substring(6, 8))+2)+"일";
		
		request.setAttribute("readDate", readDate);
		
		RequestDispatcher dis = request.getRequestDispatcher("reserv_period.jsp");
		dis.forward(request, response);
		
	}

}
