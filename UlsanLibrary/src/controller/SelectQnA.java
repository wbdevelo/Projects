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

@WebServlet("/qna/SelectQ")
public class SelectQnA extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public SelectQnA() {
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
		ArrayList<QnA> v = new ArrayList<>();
		
		int sizePerPage = 10;
		int pagePerBlock = 5;
		int pageNum = 1;
		if(request.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
		
		int count = 0;
		int startRow = 0;
		int endRow = 0;
		
		count = qdao.getAllCount();
		
		startRow = (pageNum - 1) * sizePerPage;
		endRow = sizePerPage;
		
		v = qdao.select_qna(startRow, endRow);
		
		int number = qdao.getNum();
		
		request.setAttribute("v", v);
		request.setAttribute("count", count);
		request.setAttribute("sizePerPage", sizePerPage);
		request.setAttribute("pagePerBlock", pagePerBlock);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("number", number);
		
		
		RequestDispatcher dis = request.getRequestDispatcher("list_q.jsp");
		dis.forward(request, response);
	}
	
}
