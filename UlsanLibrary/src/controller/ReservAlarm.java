package controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AlarmDAO;
import dao.ReservDAO;
import model.Alarm;


@WebServlet("/ReservationAlarm/alarm.do")
public class ReservAlarm extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ReservAlarm() {
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
		
		String lib_name = request.getParameter("lib_name");
		String id = request.getParameter("id");
		int book_uid = Integer.parseInt(request.getParameter("book_uid"));
		
		Date today = new Date();
		SimpleDateFormat cal = new SimpleDateFormat("yyyyMMdd");
		String alarmdate = cal.format(today);
		
		AlarmDAO adao = new AlarmDAO();
		Alarm a = new Alarm();
		
		a.setBook_uid(book_uid);
		a.setDate(alarmdate);
		a.setId(id);
		a.setLib_name(lib_name);
		a.setTitle(request.getParameter("title"));

		adao.insert_alarm(a);
		
		ReservDAO rdao = new ReservDAO();
		rdao.update_state(lib_name, id, book_uid);
		rdao.update_rowNum(lib_name, book_uid);
		
		response.sendRedirect("/library/SelectReserv.do?lib_name="+URLEncoder.encode(lib_name));
	}

}
