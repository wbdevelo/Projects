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

import dao.BuyNowDAO;
import dao.MemberDAO;
import model.BuyNow;
import model.Member;


@WebServlet("/purchase/baropurchase.do")
public class baropurchase extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public baropurchase() {
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
		
		BuyNowDAO bndao = new BuyNowDAO();
		BuyNow bn = new BuyNow();
		
		/* String id = request.getParameter("id"); */
		
		ArrayList<BuyNow> b = new ArrayList<BuyNow>();
		
		//상품정보 담기(상품번호 기준)
		String num[] = request.getParameter("num").split(",");
		for(String val : num) {
			bn = bndao.num_buy(val);
			b.add(bn);
		}
		
		MemberDAO mdao = new MemberDAO(); //회원정보 ~님의 포인트는 0점 입니다 등 담당
		Member m = new Member();
		m = mdao.viewMember((String)session.getAttribute("id"));
		
		/* b = bndao.getproduct(id); */
		
		request.setAttribute("m", m);
		request.setAttribute("b", b);
		request.setAttribute("num", request.getParameter("num"));
		request.setAttribute("paymethod", request.getParameter("paymethod"));
		
		RequestDispatcher dis = request.getRequestDispatcher("/purchase/baro.jsp");
		dis.forward(request, response);
	}

}


