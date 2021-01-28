package org.zerock.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zerock.domain.AskVO;
import org.zerock.domain.PagingVO;
import org.zerock.persistence.ServiceDAO;

@Controller
@RequestMapping("/customerService")
public class ServiceController {

	@Inject
	private ServiceDAO dao;
	
	
	
	@GetMapping("/write")
	public void writeGet(HttpSession session, Model model) {
		model.addAttribute("count", dao.countList((String)session.getAttribute("session_id")));
	}
	@PostMapping("/write")
	public String writePost(AskVO vo, HttpSession session) {
		vo.setId((String)session.getAttribute("session_id"));
		dao.insertAsk(vo);
		
		return "redirect:list";
	}
	
	
	
	
	@GetMapping("/list")
	public void listGet(HttpSession session, Model model, String nowPage) {
		String id = (String)session.getAttribute("session_id");

		PagingVO pvo = new PagingVO();
		if(nowPage == null || nowPage.equals("")) {
			pvo.setNowPage(1);
		}else {
			pvo.setNowPage(Integer.parseInt(nowPage));
		}
		pvo.setId(id);
		pvo.setPagePerPost(10);
		pvo.setTotalPost(dao.countList(id));
		
		PageMaker pm = new PageMaker();
		pvo = pm.paging(pvo);
		
		List<AskVO> list = dao.getMyaskList(pvo);
		
		for(int i=0; i<list.size(); i++) {
			String postUid = Integer.valueOf(list.get(i).getUid()).toString();
			list.get(i).setCount(dao.countAnswer(postUid));
		}
		
		model.addAttribute("listNum", list.size());
		model.addAttribute("list", list);
		model.addAttribute("pvo", pvo);
	}
	
	
	
	
	@GetMapping("/view")
	public void viewGet(int uid, Model model) {
		model.addAttribute("data", dao.getData(uid));
		model.addAttribute("answer", dao.getAnswer(Integer.valueOf(uid).toString()));
	}
	
	
	@ResponseBody
	@PostMapping("/answer")
	public List<AskVO> answerPost(String text, String uid, HttpSession session) {
		AskVO vo = new AskVO();
		vo.setContent(text);
		vo.setId((String)session.getAttribute("session_id"));
		vo.setPostUid(uid);
		
		dao.insertAnswer(vo);
		
		return dao.getAnswer(uid);
	}
	
}
