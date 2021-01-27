package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.QnADAO;
import model.QnA;

@WebServlet("/qna/delete_q.do")
public class Delete_QnA extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Delete_QnA() {
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
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		QnADAO qdao = new QnADAO();
		QnA q = new QnA();
		
		q = qdao.view_qna(uid);
		int count = qdao.check_thread(q.getFid(), q.getThread());
		
		if(count == 0) {		
			qdao.delete_qna(uid);
		}else {
			out.write("<script>alert('답글이 있는 글은 삭제가 불가능 합니다.');history.back();</script>");
			out.close();
		}
		
		response.sendRedirect("SelectQ");
	}

}
