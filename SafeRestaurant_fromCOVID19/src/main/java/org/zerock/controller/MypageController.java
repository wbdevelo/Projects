package org.zerock.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.AjaxVO;
import org.zerock.domain.MemberVO;
import org.zerock.domain.PagingVO;
import org.zerock.domain.ReservationVO;
import org.zerock.domain.StoreMemberVO;
import org.zerock.persistence.MemberDAO;
import org.zerock.persistence.MypageDAO;

import com.mysql.cj.Session;

@Controller
@RequestMapping("/mypage")
public class MypageController {
	
	@Inject
	private MypageDAO dao;
	@Inject
	private BCryptPasswordEncoder passEncoder;
	@Inject
	private MemberDAO mdao;
	
	@GetMapping("/information")
	public void infoGet(Model model, HttpSession session) {
		StoreMemberVO svo = new StoreMemberVO();
		String storecode = (String)session.getAttribute("session_storecode");
		String id = (String)session.getAttribute("session_id");
		String tel = "";
		if(storecode == null) {
			MemberVO mvo = dao.getMemberInfo(id);
			tel = mvo.getTel().substring(0,3)+"-"+mvo.getTel().substring(3,4)+"***-"+mvo.getTel().substring(7,8)+"***";
		} else if(storecode != null) {
			svo.setId(id);
			svo.setStorecode(storecode);
			svo = mdao.getStoreDbInfo(svo);
		}
		
		
		model.addAttribute("tel", tel);
		model.addAttribute("svo", svo);
	}

	@GetMapping("/activity")
	public void activGet(HttpSession session, Model model) {
		int count = dao.countAsk((String)session.getAttribute("session_id"));
		
		model.addAttribute("count", count);
	}
	
	
	
	@GetMapping("/passChange")
	public void passGet() {
		
	}
	@PostMapping("/passChange")
	public void passPost(String password, String newPass, HttpSession session, Model model) {
		String storedcode = (String)session.getAttribute("session_storecode");
		MemberVO mvo = new MemberVO();
		StoreMemberVO svo = new StoreMemberVO();
		if(storedcode == null || storedcode == "") {
			mvo = dao.getMemberInfo((String)session.getAttribute("session_id"));
			
			if(passEncoder.matches(password, mvo.getPassword())) {
				mvo.setPassword(passEncoder.encode(newPass));
				dao.changePass(mvo);

				session.invalidate();
				model.addAttribute("msg", "ok");
			}else {
				model.addAttribute("msg", "no");
			}
		} else {
			svo = dao.getstoreMemberInfo((String)session.getAttribute("session_id"));
			
			if(passEncoder.matches(password, svo.getPassword())) {
				svo.setPassword(passEncoder.encode(newPass));
				dao.changePassStore(svo);

				session.invalidate();
				model.addAttribute("msg", "ok");
			}else {
				model.addAttribute("msg", "no");
			}
		}

	}
	
	
	@ResponseBody
	@PostMapping("/secession")
	public String secessionGet(String id, String storecode, HttpSession session) {
		System.out.println("가게코드 : "+storecode);
		if(storecode == "" || storecode == null) {
			dao.secession(id);
		} else {
			dao.session2(id);
		}
		session.invalidate();
		return "secession_ok";
	}
	
	
	
	@GetMapping("/jjimList")
	public void jjimGet(HttpSession session, Model model, String nowPage) {
		PagingVO pvo = new PagingVO();
		pvo.setId((String)session.getAttribute("session_id"));
		if(nowPage == null || nowPage.equals("")) {
			pvo.setNowPage(1);
		}else {
			pvo.setNowPage(Integer.parseInt(nowPage));
		}
		pvo.setPagePerPost(6);
		pvo.setTotalPost(dao.totalJjim(pvo));
		
		PageMaker pm = new PageMaker();
		pvo = pm.paging(pvo);
		
		ArrayList<AjaxVO> list = new ArrayList<AjaxVO>();
		list = dao.jjimList(pvo);
		
		model.addAttribute("list", list);
		model.addAttribute("pvo", pvo);		
	}
	
	
	
	@GetMapping("/cancel_like")
	public String cancel_likeGet(@RequestParam("code") String code, HttpSession session) {
		AjaxVO vo = new AjaxVO();
		vo.setCode(code);
		vo.setName((String)session.getAttribute("session_id"));
		
		dao.cancel_like(vo);
		
		return "redirect:jjimList";
	}
	
	
	
	@GetMapping("/reservList")
	public void reservListGet(HttpSession session, Model model, String nowPage) {
		PagingVO pvo = new PagingVO();
		if(nowPage == null || nowPage.equals("")) {
			pvo.setNowPage(1);
		}else {
			pvo.setNowPage(Integer.parseInt(nowPage));
		}
		pvo.setId((String)session.getAttribute("session_id"));
		pvo.setTotalPost(dao.totalReserv(pvo));
		pvo.setPagePerPost(10);
		
		PageMaker pm = new PageMaker();
		pvo = pm.paging(pvo);
		List<ReservationVO> list = dao.reservList(pvo);
		
		Date today = new Date();
		SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd");
		String todate = cal.format(today);
		
		model.addAttribute("todate", todate);
		model.addAttribute("list", list);
		model.addAttribute("pvo", pvo);
	}
	
	@GetMapping("/reservList2")
	public void reservListGet2(HttpSession session, Model model) {
		List<ReservationVO> list = dao.reservList2((String)session.getAttribute("session_storecode"));
		
		Date today = new Date();
		SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd");
		String todate = cal.format(today);
		
		model.addAttribute("todate", todate);
		model.addAttribute("list", list);
	}
	
	
	
	@GetMapping("/reserv_cancel")
	public String reserv_cancelGet(int uid, HttpSession session) {
		
		dao.cancel_reserv(uid);
		
		return "redirect:reservList";
	}
}
