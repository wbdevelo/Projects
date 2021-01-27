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
import javax.servlet.http.HttpSession;

import dao.AlarmDAO;
import dao.ReservDAO;
import model.Alarm;


@WebServlet("/ReservationAlarm/alarm_detail.do")
public class AlarmDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public AlarmDetail() {
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
		HttpSession session = request.getSession();
		
		int uid = Integer.parseInt(request.getParameter("uid"));
		int readNum = Integer.parseInt(request.getParameter("readNum"));
		
		AlarmDAO adao = new AlarmDAO();
		Alarm a = new Alarm();
		
		if(readNum == 0) {
			Date today = new Date();
			SimpleDateFormat cal = new SimpleDateFormat("yyyyMMddHHmmss");
			String readDate = cal.format(today);
			
			adao.update_readNumDate(uid, readDate);
		}else {
			adao.update_readNum(uid);
		}
		
		a = adao.select_detail(uid);
		
		ReservDAO rdao = new ReservDAO();
		String state = rdao.get_state(a.getId(), a.getLib_name(), a.getBook_uid());
		
		int alarm_count = adao.get_count((String)session.getAttribute("id"));
		session.setAttribute("alarm_count", alarm_count);
		
		request.setAttribute("a", a);
		request.setAttribute("state", state);
		
		RequestDispatcher dis = request.getRequestDispatcher("alarm_detail.jsp");
		dis.forward(request, response);
	}

}
