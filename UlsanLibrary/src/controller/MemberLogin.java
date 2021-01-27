package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.AlarmDAO;
import dao.CartDAO;
import dao.MemberDAO;
import model.Cart;
import model.Member;


@WebServlet("/member/login_ok.do")
public class MemberLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public MemberLogin() {
        super();

    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doALL(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doALL(request, response);
	}
	
	protected void doALL(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		
		String id  = request.getParameter("id");
		String pass = request.getParameter("pass");
		
		int total_record = 0;
		int cart_count = 0;
		
		MemberDAO dao = new MemberDAO();
		CartDAO cdao = new CartDAO();
		
		total_record = dao.loginMember(id, pass);//DAO에서 처리한 loginMember() 객체를 total_record변수에 대입하여 쓰겠다
		
		Member bean = new Member();
		Cart c = new Cart();
		if(total_record == 1) {
			bean = dao.loginSelect(id,pass);
			
			if(bean.getState().equals("o")) {
				HttpSession session = request.getSession();
				
				session.setAttribute("id", bean.getId());
				session.setAttribute("name", bean.getName());
				session.setAttribute("level", bean.getLevel());
				
				c.setGuest((String)session.getAttribute("guest"));
				c.setId((String)session.getAttribute("id"));
				
				
				String jogeon = "";
				if(c.getId().equals("")) {
					jogeon = "and guest='"+c.getGuest()+"'";
				}else {
					jogeon = "and id='"+c.getId()+"'";
				}
				
				cart_count = cdao.cart_count(jogeon);
				
				session.setAttribute("cart_count", cart_count);

				AlarmDAO adao = new AlarmDAO();
				int alarm_count = 0;
				
				if(bean.getLevel().equals("1")) {
					alarm_count = adao.get_count((String)session.getAttribute("id"));
					session.setAttribute("alarm_count", alarm_count);
				}
				
				if(bean.getLevel().equals("5")) {
					alarm_count = adao.set_alarmCount(bean.getName());
					session.setAttribute("alarm_count", alarm_count);
				}
				
				response.sendRedirect("/index.do");
			}else {
				PrintWriter out = response.getWriter();
				out.print("<script>alert('탈퇴한 회원입니다. 가입이 필요합니다.');location.href='login.jsp';</script>");
			}
			
		}else{
			request.setAttribute("msg", "아이디 또는 비밀번호 일치하지 않습니다.");
			request.setAttribute("url", "login.jsp");
			
			RequestDispatcher dis = request.getRequestDispatcher("/error.jsp");
			dis.forward(request, response);
		}
	}

}













