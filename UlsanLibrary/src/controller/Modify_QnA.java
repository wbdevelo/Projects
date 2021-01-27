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

@WebServlet("/qna/modify_qna.do")
public class Modify_QnA extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Modify_QnA() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAll(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAll(request, response);
	}
	
	protected void doAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			int uid = Integer.parseInt(request.getParameter("uid"));
			
			QnADAO qdao = new QnADAO();
			QnA q = new QnA();
			
			q = qdao.view_qna(uid);
			
			request.setAttribute("q", q);
			request.setAttribute("uid", uid);
			request.setAttribute("pageNum", request.getParameter("pageNum"));
			
			RequestDispatcher dis = request.getRequestDispatcher("modify_q.jsp");
			dis.forward(request, response);
	}

}
