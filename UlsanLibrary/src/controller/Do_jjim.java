package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.JjimDAO;
import model.Jjim;

@WebServlet("/e_book/jjim.do")
public class Do_jjim extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Do_jjim() {
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
		
		Jjim j = new Jjim();
		j.setId(request.getParameter("id"));
		j.setJjim_v(request.getParameter("heart"));
		j.setTitle_uid(Integer.parseInt(request.getParameter("title_uid")));
		
		JjimDAO jdao = new JjimDAO();
		jdao.update_jjim(j);
		
		response.sendRedirect("SelectE");
	}

}
