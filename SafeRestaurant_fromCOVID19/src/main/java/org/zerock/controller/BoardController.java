package org.zerock.controller;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.CommentVO;
import org.zerock.domain.MenuVO;
import org.zerock.domain.ReservationVO;
import org.zerock.domain.ReviewVO;
import org.zerock.domain.StoreMemberVO;
import org.zerock.domain.StoreVO;
import org.zerock.persistence.AjaxDAO;
import org.zerock.persistence.BoardDAO;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Inject
	private AjaxDAO adao;
	
	@Inject
	private BoardDAO bdao;
	
	// 첨부파일 저장 경로
	// servlet-context.xml에 있는 bean id="uploadPath" 경로 매칭 
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	// 보고싶은 가게 상세페이지
	@GetMapping("/detailpage")
	public void detailpageGet(@RequestParam("code") String code, Model model, HttpSession session, RedirectAttributes rttr) {
		StoreMemberVO svo = new StoreMemberVO();
		List<ReviewVO> reviewarr = new ArrayList<ReviewVO>();
		StoreVO getstore = new StoreVO();
		List<MenuVO> menu = new ArrayList<MenuVO>();
		List<CommentVO> comment = new ArrayList<CommentVO>();
		
		comment = bdao.getComment(code);
		menu = bdao.getMenu(code);
		getstore = adao.getStore(code);
		reviewarr = bdao.getReview(code);
		svo = bdao.getStoreMember(code);
		
		model.addAttribute("comment", comment);
		model.addAttribute("svo", svo);
		model.addAttribute("store", getstore);
		model.addAttribute("review", reviewarr);
		model.addAttribute("menu", menu);
	}
	@PostMapping("/detailpage")
	public String detailpagePose(ReviewVO vo, MultipartFile file, HttpSession session, @RequestParam("code") String code, RedirectAttributes rttr) throws IOException {
		String id = (String)session.getAttribute("session_id");
		
		String fileName = uploadFile(file.getOriginalFilename(), file.getBytes());
		
		vo.setId(id);
		vo.setFlie_o(fileName);
		
		int fid1 = 0;
		int fid2 = 0;
		int cnt = bdao.getcountFid(code);
		
		if(cnt == 0) {
			fid1=1;
		} else {
			fid2 = bdao.getFid(code);
			if(fid2>0) {
				fid1 =  fid2+1;
			} else {
				fid1 = 1;
			}
		}
		
		vo.setFid(fid1);
		bdao.reviewInsert(vo);
		
		rttr.addAttribute("code", code);
		
		return "redirect:detailpage";

	}
	public String uploadFile(String originalName, byte[] fileData) throws IOException {
		UUID uid = UUID.randomUUID();
		String savedName = uid.toString() + "_" + originalName;
		
		// import java.io.File; 
		File target = new File(uploadPath, savedName);
		
		// FileCopyUtils는 'org.springframework.util' 패키지에 설정된 클래스(실제 파일 처리)
		FileCopyUtils.copy(fileData, target);
		
		return savedName;
	}
	
	// 리뷰삭제
	@GetMapping("reviewDelete")
	public String reviewDeleteGet(int uid, String code, String date, RedirectAttributes rttr) {
		
		bdao.reviewDelete(uid);
		
		rttr.addAttribute("code", code);
		rttr.addAttribute("date", date);
		return "redirect:detailpage";
	}
	

	@GetMapping("/goDetail")
	public String goDetailPost(String rname, RedirectAttributes rttr) {
		if(rname.length() > 8) {
			rname = rname.substring(0, rname.lastIndexOf("..."));
		}
		
		Map<String, String> map = new HashMap<String, String>();
		map = bdao.getDetail(rname);
		
		rttr.addAttribute("code", map.get("code"));
		rttr.addAttribute("date", map.get("date"));
		
		return "redirect:detailpage";
	}
	
	@GetMapping("/list")
	public void listGet(String category, Model model, RedirectAttributes rttr) {
		ArrayList<StoreVO> list = new ArrayList<StoreVO>();
		ArrayList<StoreVO> list2 = new ArrayList<StoreVO>();

		String totalcnt = bdao.GetcountTotal();


		list = bdao.getStoreListGet(category, totalcnt);
		
		for(int i=0; i<list.size(); i++) {
			if(category.contains("기타")) {
				if(list.get(i).getRelax_gubun_detail().contains("기타")) {
					list2.add(list.get(i));
				}
			} else {
				if(category.equals(list.get(i).getRelax_gubun_detail())) {
					list2.add(list.get(i));
				}
			}
		}
		
		
		model.addAttribute("list", list2);
	}
	@PostMapping("/list")
	public void listPost(String category, String sido, String sigugun, Model model) {
		ArrayList<StoreVO> list = new ArrayList<StoreVO>();
		ArrayList<StoreVO> list2 = new ArrayList<StoreVO>();
		
		String totalcnt = bdao.countTotal(sido, sigugun);
		
		list = bdao.getStoreList(totalcnt, category, sido, sigugun);
		
		for(int i=0; i<list.size(); i++) {
			if(category.contains("기타")) {
				if(list.get(i).getRelax_gubun_detail().contains("기타")) {
					list2.add(list.get(i));
				}
			} else {
				if(category.equals(list.get(i).getRelax_gubun_detail())) {
					list2.add(list.get(i));
				}
			}
		}
		
		model.addAttribute("list", list2);
		model.addAttribute("category", category);
		model.addAttribute("sido", sido);
		model.addAttribute("sigugun", sigugun);
	}
	
	
	@ResponseBody
	@PostMapping("/reserv_inStore")
	public Map<String, Object> inStorePost(ReservationVO vo, HttpSession session, RedirectAttributes rttr) {
		String id = (String)session.getAttribute("session_id");
		vo.setId(id);
		bdao.insertReserv_inStore(vo);
		
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("code", vo.getCode());
		map.put("date", vo.getRes_date());
		
		return map;
	}
	
	
	@ResponseBody
	@PostMapping("/dateCheck")
	public String dateCheckPost(String date, RedirectAttributes rttr, HttpSession session) {
		Date today = new Date();
		SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd");
		String tocal = cal.format(today);
		Date todate = null;
		Date reserv_date = null;
		
		ReservationVO rvo = new ReservationVO();
		rvo.setId((String)session.getAttribute("session_id"));
		rvo.setReserv_date(date);

		String dateResult = "";
		try {
			todate = cal.parse(tocal);
			reserv_date = cal.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		if(reserv_date.equals(todate)) {
			dateResult = "present";
			if(bdao.getReservList(rvo).size() >= 3) {
				dateResult = "three";
			}
		}else if(reserv_date.compareTo(todate) > 0) {
			dateResult = "future";
			if(bdao.getReservList(rvo).size() >= 3) {
				dateResult = "three";
			}
		}else{
			dateResult = "past";
		}
		
		return dateResult;
	}
	
	
	
	@ResponseBody
	@PostMapping("/timeCheck")
	public String timePost(String time, String date, HttpSession session) {
		Date today = new Date();
		SimpleDateFormat cal = new SimpleDateFormat("HHmm");
		String tocal = cal.format(today);
		
		SimpleDateFormat cal2 = new SimpleDateFormat("yyyy-MM-dd");
		String tocal2 = cal2.format(today);
		Date todate = null;
		Date reserv_date = null;
		
		String timeResult = "";
		try {
			todate = cal2.parse(tocal2);
			reserv_date = cal2.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		ReservationVO rvo = new ReservationVO();
		rvo.setId((String)session.getAttribute("session_id"));
		rvo.setReserv_date(date);
		List<ReservationVO> rlist = bdao.getReservList(rvo);
		
		int totime = Integer.parseInt(tocal);
		String retime = time.substring(0,2)+time.substring(3);
		int reserv_time = Integer.parseInt(retime);
		
		if(rlist.size() > 0) {
			
			for(int i=0; i<rlist.size(); i++) {
				Date rDate = null;
				try {
					rDate = cal2.parse(rlist.get(i).getReserv_date().toString());
				} catch (ParseException e) {
					e.printStackTrace();
				}

				
				if(rDate.equals(reserv_date)) {
					//DB 값과 비교
					int rTime = Integer.parseInt(rlist.get(i).getReserv_time().substring(0,2)+rlist.get(i).getReserv_time().substring(3));
					
					if(Math.abs(rTime-reserv_time) >= 300) {
						
					}else {
						timeResult = "DBno";
					}
					
				}else {
					
				}
			}	
			
		}
		
		if(timeResult.equals("")) {
			//현 시각과 비교
			if(todate.equals(reserv_date)) {
				if(reserv_time >= totime+100) {
					timeResult = "ok";
				}else {
					tocal = Integer.valueOf(totime+100).toString();
					String possible = tocal.substring(0,2)+":"+tocal.substring(2);
					
					timeResult = "small";
				}
			}else if(todate.compareTo(reserv_date) > 0) {
				timeResult = "datePast";
			}else {
				timeResult = "ok";
			}
		}
		
		
		return timeResult;
	}
	
	@ResponseBody
	@GetMapping("/ajaxcategorylist")
	public ArrayList<StoreVO> ajaxcategorylist(String category, String sido, String sigugun) {
		ArrayList<StoreVO> list = new ArrayList<StoreVO>();
		String totalcnt = bdao.countTotal(sido, sigugun);
		
		list = bdao.getAllList(totalcnt, category, sido, sigugun);
		
		return list;
	}
	
	@PostMapping("/menu")
	public String InsertMenu(MultipartFile file, String price, String content, HttpSession session) throws IOException {
		String id = (String)session.getAttribute("session_id");
		String code = (String)session.getAttribute("session_storecode");
		MenuVO vo = new MenuVO();
		String fileName = uploadFile(file.getOriginalFilename(), file.getBytes());
		vo.setFile(fileName);
		vo.setPrice(price);
		vo.setContent(content);
		vo.setId(id);
		vo.setStorecode(code);

		bdao.InsertMenu(vo);
		
		return "redirect:detailpage?code="+code;
		
	}
	
	@GetMapping("/deleteMenu")
	public String deleteMenu(String code, String uid) {
		bdao.DeleteMenu(uid);
		return "redirect:detailpage?code="+code;
	}
	
	@PostMapping("/replyInsert")
	public String replyInsert(String recomment, String reuid, HttpSession session) {
		String id = (String)session.getAttribute("session_id");
		String code = (String)session.getAttribute("session_storecode");
		CommentVO cvo = new CommentVO();
		ReviewVO rvo = new ReviewVO();
		
		rvo.setUid(Integer.parseInt(reuid));
		rvo = bdao.getFidwhereUid(rvo);
		cvo.setFid(rvo.getFid());
		// 혹시 모르니 여기 마킹 여기서 지우면 됨
		cvo.setContent(recomment);
		cvo.setId(id);
		cvo.setStorecode(code);
		bdao.replyInset(cvo);
		
		return "redirect:detailpage?code="+code;
		
	}
	
	@PostMapping("/updatemenu")
	public String updateMenuPost(MultipartFile file, String uid, String price, String content, HttpSession session) throws IOException {
		MenuVO vo = new MenuVO();
		String id = (String)session.getAttribute("session_id");
		String code = (String)session.getAttribute("session_storecode");
		String fileName = uploadFile(file.getOriginalFilename(), file.getBytes());
		vo.setFile(fileName);
		vo.setPrice(price);
		vo.setContent(content);
		vo.setUid(Integer.parseInt(uid));
		vo.setId(id);
		vo.setStorecode(code);
		
		bdao.UpdateMenu(vo);
		
		return "redirect:detailpage?code="+vo.getStorecode();
		
	}
}
