package e_controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CartDAO;
import model.Cart;


@WebServlet("/member/my_ebook.do")
public class SelectMy_Ebook extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public SelectMy_Ebook() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doALL(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doALL(request, response);
	}
	
	protected void doALL(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	//cart테이블중 로그인 한 회원의 session_id에 해당하는 purchase가 o인 상태의 책만 골라서 목록에 띄우기
		
		String id = request.getParameter("id");
		
		request.setCharacterEncoding("utf-8");
		
		//한페이지 보여질 리스트 갯수
				int pageSize = 5;
				
				//현재보여지는 페이지 값 처리
				int pageNum = 1;
				if(request.getParameter("pageNum") != null) {
					pageNum = Integer.parseInt(request.getParameter("pageNum"));
				}
				
				//전체 게시글 총 갯수 초기화
				int count = 0;
				
				CartDAO cdao = new CartDAO();
				//내가 결제한 전체 ebook 총 갯수
				count = cdao.getAllcount(id);
				
				//페이지내에서 보여질 넘버링 숫자 
				int number = count - (pageNum -1) * pageSize;
				
				
				
				//변수 v에 회원 목록에 띄울 회원들의 이름,아이디,레벨,상태 등을 member_list.jsp로 포워드 시켜서 보낸다
				ArrayList<Cart> v = new ArrayList<Cart>();//클래스1<클래스2> 변수 = new 클래스1<클래스2>(); 클래스1<클래스2>객체생성후 변수 v에 담는다.
				v = cdao.getAllproduct(id);
				
				request.setAttribute("v", v);//
				request.setAttribute("count", count);
				request.setAttribute("number", number);
				request.setAttribute("pageSize", pageSize);
				request.setAttribute("pageNum", pageNum);
				RequestDispatcher dis = request.getRequestDispatcher("my_e.jsp");
				dis.forward(request, response);//포워드 시키고싶다면 이걸 계속 쓰면 된다.
	}

}
