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

import dao.JjimDAO;
import model.EBook;
import model.Jjim;


@WebServlet("/member/jjimMok.do")
public class MyJjimMok extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public MyJjimMok() {
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
		
		String id = (String)session.getAttribute("id");
		
		JjimDAO jdao = new JjimDAO();
		ArrayList<EBook> ev = new ArrayList<EBook>();
		ev = jdao.select_my(id);
		
		request.setAttribute("ev", ev);
		
		RequestDispatcher dis = request.getRequestDispatcher("jjimMok.jsp");
		dis.forward(request, response);
	}

}
