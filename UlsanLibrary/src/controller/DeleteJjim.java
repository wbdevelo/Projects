package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.JjimDAO;
import model.Jjim;


@WebServlet("/member/delJjim.do")
public class DeleteJjim extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public DeleteJjim() {
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
		int title_uid = Integer.parseInt(request.getParameter("title_uid"));
		
		JjimDAO jdao = new JjimDAO();
		Jjim j = new Jjim();
		
		j.setId(id);
		j.setJjim_v("0");
		j.setTitle_uid(title_uid);
		
		jdao.update_jjim(j);
		
		response.sendRedirect("jjimMok.do");
	}

}
