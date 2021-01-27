package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.AlarmDAO;
import model.Alarm;


@WebServlet("/ReservationAlarm/SelectAlarm.do")
public class SelectAlarm extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public SelectAlarm() {
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
		
		AlarmDAO adao = new AlarmDAO();
		ArrayList<Alarm> av = new ArrayList<Alarm>();
		
		av = adao.select_alarm(id);
		int count = adao.count_alarm(id);
		
		request.setAttribute("av", av);
		request.setAttribute("count", count);
		
		RequestDispatcher dis = request.getRequestDispatcher("alarm_list.jsp");
		dis.forward(request, response);
		
	}

}
