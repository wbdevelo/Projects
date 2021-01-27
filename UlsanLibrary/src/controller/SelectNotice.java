package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.NoticeDAO;
import model.Nnotice;

@WebServlet("/notice/SelectN")
public class SelectNotice extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public SelectNotice() {
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
		
		NoticeDAO ndao = new NoticeDAO();
		ArrayList<Nnotice> v = new ArrayList<>();
		
		int pageSize = 10;
		//현재보여지는 페이지 값 처리
		int pageNum = 1;
		if(request.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
		//전체 게시글 총 갯수 초기화
		int count = 0;
		//전체 게시글 총 갯수
		count = ndao.getAllCount();
		
		//페이지내에서 보여질 넘버링 숫자 
		int number = count - (pageNum -1) * pageSize;
		
		//현재 페이지 limit값 처리
		int startRow = (pageNum -1 )* pageSize;
		int endRow = pageSize;
		
		v = ndao.select_notice(startRow, endRow);
		
		request.setAttribute("v", v);//
		request.setAttribute("count", count);
		request.setAttribute("number", number);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("pageNum", pageNum);
		
		RequestDispatcher dis = request.getRequestDispatcher("list_n.jsp");
		dis.forward(request, response);
		
	}
	
}
