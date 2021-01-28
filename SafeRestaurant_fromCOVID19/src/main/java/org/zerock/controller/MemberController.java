package org.zerock.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Random;
import java.util.regex.Pattern;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.MemberVO;
import org.zerock.domain.StoreMemberVO;
import org.zerock.domain.StoreVO;
import org.zerock.persistence.AjaxDAO;
import org.zerock.persistence.MemberDAO;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Inject
	private MemberDAO dao;
	@Inject
	BCryptPasswordEncoder passEnc;
	@Inject
	private AjaxDAO adao;
	
	
	@GetMapping("/join")
	public void joinGet() {
		
	}
	@PostMapping("/join")
	public String joinPost(MemberVO vo, RedirectAttributes rttr) {
		vo.setPassword(passEnc.encode(vo.getPassword()));
		dao.join(vo);
		
		rttr.addFlashAttribute("msg", "가입되었습니다.");
		return "redirect:/member/join";
	}
	
	
	
	@GetMapping("/login")
	public void loginGet() {
		
	}
	@PostMapping("/login")
	public String loginPost(MemberVO vo, HttpSession session, RedirectAttributes rttr) {
		boolean pwMatch = passEnc.matches(vo.getPassword(), dao.idCheck(vo.getId()));
		MemberVO mvo = dao.oneMember(vo.getId());
		
		if(pwMatch == true) {
			if(mvo.getLevel().equals("1") || mvo.getLevel().equals("10")) {
				session.setAttribute("session_id", vo.getId());
				session.setAttribute("session_level", mvo.getLevel());
				return "redirect:/";
			}else {
				rttr.addFlashAttribute("msg", "no");
				return "redirect:/member/login";
			}
		}else {
			rttr.addFlashAttribute("msg", "no");
			return "redirect:/member/login";
		}
	}
	
	
	
	@ResponseBody
	@PostMapping("/idCheck")
	public String idCheckPost(String userId) {
		return dao.getID(userId);
	}

	@GetMapping("/searchid")
	public void searchidGet() {
		
	}
	@ResponseBody
	@PostMapping("/searchid")
	public String searchidPost(String tel, String addr) {
		MemberVO vo = new MemberVO();
		vo.setTel(tel);
		vo.setAddress(addr);
		
		String id = "";
		vo = dao.searchId(vo);
		
		if(vo.getLevel().equals("1")) {
			id = vo.getId();
		}else {
			id="none";
		}
		
		return id;
	}
	@ResponseBody
	@PostMapping("/storesearchid")
	public String storesearchid(String code, String address, String storename) {
		StoreMemberVO vo = new StoreMemberVO();
		vo.setStorecode(code);
		vo.setStorename(storename);
		vo.setAddress(address);
		
		String id = "";
		vo = dao.storesearchId(vo);
		
		if(vo.getStorecode().equals(code)) {
			id = vo.getId();
		}else {
			id="none";
		}
		return id;
	}
	
	
	
	@GetMapping("/searchpw")
	public void searchpwGet() {
		
	}
	@PostMapping("/searchpw")
	public String searchpwPost(MemberVO vo, RedirectAttributes rttr) {
		int cnt = dao.searchPw(vo);
		
		rttr.addFlashAttribute("cnt", cnt);
		rttr.addFlashAttribute("id", vo.getId());
		
		return "redirect:/member/searchpw";
	}
	@PostMapping("/storesearchpw")
	public String StoresearchpwPost(StoreMemberVO vo, RedirectAttributes rttr) {
		int cnt = dao.StoresearchPw(vo);
		
		if(cnt !=0) {
			rttr.addFlashAttribute("cnt", "3");
			rttr.addFlashAttribute("id", vo.getId());
			
			return "redirect:/member/searchpw";
		} else {
			rttr.addFlashAttribute("cnt", cnt);
			return "redirect:/member/searchpw";
		}

	}
	
	
	
	@GetMapping("/logout")
	public String logoutGet(HttpSession session) {
		session.invalidate();
		
		return "redirect:/";
	}
	
	
	
	@GetMapping("/modify")
	public void modifyGet(HttpSession session, Model model) {
		MemberVO mvo = new MemberVO();
		mvo = dao.oneMember((String)session.getAttribute("session_id"));
		
		model.addAttribute("mvo", mvo);
	}
	@PostMapping("/modify")
	public String modifyPost(MemberVO vo, RedirectAttributes rttr) {
		
		dao.modifyMem(vo);
		
		rttr.addFlashAttribute("msg", "ok");
		
		return "redirect:/member/modify";
	}
	
	@GetMapping("/newpassword")
	public void newpasswordGet(@RequestParam(value="id")String id , Model model) {
		model.addAttribute("id", id);
	}
	@PostMapping("/newpassword")
	public void newpasswordPost(MemberVO vo, Model model) {
		vo.setPassword(passEnc.encode(vo.getPassword()));
		dao.changePw(vo);
		model.addAttribute("msg", "ok");
	}
	@GetMapping("/newpassword2")
	public void StorenewpasswordGet(@RequestParam(value="id")String id , Model model) {
		model.addAttribute("id", id);
	}
	@PostMapping("/newpassword2")
	public void StorenewpasswordPost(StoreMemberVO vo, Model model) {
		vo.setPassword(passEnc.encode(vo.getPassword()));
		dao.changePw2(vo);
		model.addAttribute("msg", "ok");
	}
	
	@GetMapping("chkStoreAnsim")
	public void chkStoreAnsim() {
		
	}
	
	@PostMapping("/storeJoin")
	public String storeJoin(StoreMemberVO vo, RedirectAttributes rttr) {
		
		StoreVO svo = new StoreVO();
		svo = dao.getStoreInfo(vo.getStorecode());
		
		if(svo.getRelax_rstrnt_nm().contains(vo.getStorename())) {
			if(svo.getRelax_seq() == Long.parseLong(vo.getStorecode())) {
				vo.setPassword(passEnc.encode(vo.getPassword()));
				dao.InsertStoreMember(vo);
			} else {
				rttr.addFlashAttribute("mag", "등록된 정보랑 일치하지 않습니다. 안심식당 등록확인 후 다시 가입하여 주시기 바랍니다.");
				return "redirect:/member/join";
			}
		} else {
			rttr.addFlashAttribute("mag", "등록된 정보랑 일치하지 않습니다. 안심식당 등록확인 후 다시 가입하여 주시기 바랍니다.");
			return "redirect:/member/join";
		}
		rttr.addFlashAttribute("msg", "가입되었습니다.");
		return "redirect:/member/join";
	}
	
	@PostMapping("/stoLogin")
	public String stoLogin(StoreMemberVO vo, HttpSession session, RedirectAttributes rttr) {
		boolean pwMatch = passEnc.matches(vo.getPassword(), dao.storeidCheck(vo.getId()));
		StoreMemberVO svo = new StoreMemberVO();
		svo = dao.getStoreDbInfo(vo);
		
		if(svo == null) {
			rttr.addFlashAttribute("msg", "sno");
			return "redirect:/member/login";
		}
		
		if(pwMatch == true) {
			if((svo.getStorecode().equals(vo.getStorecode())) && (svo.getId().equals(vo.getId())) && (svo.getLevel() != 0)) {
				session.setAttribute("session_id", svo.getId());
				session.setAttribute("session_storecode", svo.getStorecode());
				session.setAttribute("session_level", svo.getLevel());
				return "redirect:/";
			}else {
				rttr.addFlashAttribute("msg", "sno");
				return "redirect:/member/login";
			}
		}else {
			rttr.addFlashAttribute("msg", "sno");
			return "redirect:/member/login";
		}
	}
	
	@GetMapping("/modifystore")
	public void modifystore(Model model, HttpSession session) {
		String storecode = (String)session.getAttribute("session_storecode");
		String id = (String)session.getAttribute("session_id");
		
		StoreMemberVO svo = new StoreMemberVO();
		svo.setId(id);
		svo.setStorecode(storecode);
		svo = dao.getStoreDbInfo(svo);
		
		model.addAttribute("svo", svo);
		
	}
	@PostMapping("/modifystore")
	public String modifystorePost(StoreMemberVO vo, RedirectAttributes rttr) {
		dao.modifyMemStore(vo);
		rttr.addFlashAttribute("msg", "ok");
		
		return "redirect:/member/modifystore";
	}
}
