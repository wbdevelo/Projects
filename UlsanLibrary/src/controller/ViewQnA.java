package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.QnADAO;
import model.QnA;

@WebServlet("/qna/view_q.do")
public class ViewQnA extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ViewQnA() {
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
		
		QnADAO qdao = new QnADAO();
		QnA q = new QnA();
		
		int uid = Integer.parseInt(request.getParameter("uid"));
		
		q = qdao.view_qna(uid);
		
		request.setAttribute("q", q);
		request.setAttribute("now", request.getParameter("now"));
		request.setAttribute("pageNum", request.getParameter("pageNum"));
		
		RequestDispatcher dis = request.getRequestDispatcher("view_q.jsp");
		dis.forward(request, response);
	}

}
