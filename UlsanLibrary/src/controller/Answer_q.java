package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.QnADAO;
import model.QnA;

@WebServlet("/qna/answer_q.do")
public class Answer_q extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Answer_q() {
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
		
		//thread
				String thread = request.getParameter("thread");
				String fid = request.getParameter("fid");
				String new_thread = "";
				
				QnADAO qdao = new QnADAO();
				new_thread = qdao.select_thread(fid, thread);
				
				QnA q = new QnA();
				q.setId(request.getParameter("id"));
				q.setContent(request.getParameter("content"));
				q.setName(request.getParameter("name"));
				q.setTitle(request.getParameter("title"));
				q.setFile(request.getParameter("file"));
				q.setThread(new_thread);
				q.setFid(Integer.parseInt(fid));
				
				qdao.answer_qna(q);
				
				response.sendRedirect("SelectQ");
	}

}
