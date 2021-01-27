package e_controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.EBookDAO;
import dao.JjimDAO;


@WebServlet("/e_book/delete_e.do")
public class DeleteE_book extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public DeleteE_book() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doALL(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doALL(request, response);
	}
	
	protected void doALL(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		
		int uid = Integer.parseInt(request.getParameter("uid"));
		
		EBookDAO ed = new EBookDAO();
		ed.delete_e(uid);
		
		String id = (String)session.getAttribute("id");
		JjimDAO jdao = new JjimDAO();
		jdao.delete_jjim(uid);
		
		response.sendRedirect("delete_e.jsp");
	}

}








