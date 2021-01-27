package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.QnADAO;
import model.QnA;

@WebServlet("/member/myQ.do")
public class MyQnA extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public MyQnA() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAll(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAll(request, response);
	}
	
	protected void doAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		QnADAO qdao = new QnADAO();
		ArrayList<QnA> v = new ArrayList<>();

		v = qdao.my_q(request.getParameter("id"));
		
		request.setAttribute("v", v);
		
		RequestDispatcher dis = request.getRequestDispatcher("my_q.jsp");
		dis.forward(request, response);
	}

}
