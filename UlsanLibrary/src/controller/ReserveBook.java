package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.AlarmDAO;
import dao.GalleryDAO;
import dao.ReservDAO;
import model.Alarm;
import model.Gallery;


@WebServlet("/gallery/reserv.do")
public class ReserveBook extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public ReserveBook() {
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
		PrintWriter out = response.getWriter();
		
		HttpSession session = request.getSession();
		ReservDAO rdao = new ReservDAO();
		GalleryDAO gdao = new GalleryDAO();
		Gallery g = new Gallery();
		
		String id = (String)session.getAttribute("id");
		int iuid = Integer.parseInt(request.getParameter("uid"));
		String lib_name = request.getParameter("lib_name");
		
		if(id == null || id.equals("")) {
			out.print("<script>alert('회원만 이용 가능합니다.');history.back();</script>");
		}else {
			int count = rdao.onePer_id(id, iuid);
			if(count == 0) {
				Date today = new Date();
				SimpleDateFormat cal = new SimpleDateFormat("yyyyMMddHHmmss");
				String signdate = cal.format(today);
				
				g = gdao.modify_gallery(iuid);
				int row_count = rdao.count_row(g);
				if(row_count == 0) {
					rdao.insert_reserv(g, id, signdate);
				}else {
					rdao.insert_reservRow(g, id, signdate, row_count);
				}
				
				SimpleDateFormat cal2 = new SimpleDateFormat("yyyyMMdd");
				String date = cal2.format(today);
				
				AlarmDAO adao = new AlarmDAO();
				Alarm a = new Alarm();
				a.setBook_uid(iuid);
				a.setDate(date);
				a.setId("");
				a.setLib_name(lib_name);
				a.setTitle("");
				adao.insert_alarm(a);
			
				response.sendRedirect("view_g.do?uid="+g.getUid()+"&title="+g.getTitle()+"&lib_name="+URLEncoder.encode(g.getLib_name()));
			}else {
				out.print("<script>alert('예약은 한 번만 가능합니다.');history.back();</script>");
			}
		}
		
		
	}

}
