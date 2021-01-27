package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AlarmDAO;
import dao.ReservDAO;


@WebServlet("/ReservationAlarm/cancel_reserv.do")
public class CancelReserv extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public CancelReserv() {
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
		int readNum = Integer.parseInt(request.getParameter("readNum"));
		
		AlarmDAO adao = new AlarmDAO();
		ReservDAO rdao = new ReservDAO();
		rdao.update_stateCancel(id, lib_name, book_uid);
		adao.update_state(id, lib_name, book_uid);
		
		response.sendRedirect("alarm_detail.do?uid="+uid+"&readNum="+readNum);
		
	}

}
