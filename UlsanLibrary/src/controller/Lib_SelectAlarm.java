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


@WebServlet("/library/SelectAlarm.do")
public class Lib_SelectAlarm extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public Lib_SelectAlarm() {
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
		
		String lib_name = request.getParameter("lib_name");
		
		AlarmDAO adao = new AlarmDAO();
		ArrayList<Alarm> av = new ArrayList<Alarm>();
		av = adao.select_LibAlarm(lib_name);
		adao.update_LibReadNum(lib_name);
		
		String level = (String)session.getAttribute("level");
		String name = (String)session.getAttribute("name");
		
		
		if(level.equals("5")) {
			int alarm_count = 0;
			alarm_count = adao.set_alarmCount(name);
			session.setAttribute("alarm_count", alarm_count);
			
			request.setAttribute("alarm_count", alarm_count);
		}
		
		request.setAttribute("av", av);
		
		RequestDispatcher dis = request.getRequestDispatcher("alarm_list.jsp");
		dis.forward(request, response);
	}

}
