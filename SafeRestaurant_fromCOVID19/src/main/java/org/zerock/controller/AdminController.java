package org.zerock.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.AdminExcelVO;
import org.zerock.domain.AskVO;
import org.zerock.domain.MemberVO;
import org.zerock.domain.SlideImgVO;
import org.zerock.persistence.AdminDAO;
import org.zerock.persistence.MypageDAO;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Inject
	private AdminDAO dao;
	
	@Resource(name="excelPath")
	private String excelPath;
	@Resource(name="slidePath")
	private String slidePath;
	
	
	public String uploadExcel(String fileName, byte[] fileData) throws IOException {
		Date today = new Date();
		SimpleDateFormat cal = new SimpleDateFormat("yyyyMMddHHmmss");
		String uploadName = cal.format(today) + "_" + fileName;
		
		File target = new File(excelPath, uploadName);
		
		FileCopyUtils.copy(fileData, target);
		
		return uploadName;
	}
	public String uploadSlide(String fileName, byte[] fileData) throws IOException {
		Date today = new Date();
		SimpleDateFormat cal = new SimpleDateFormat("yyyyMMddHHmmss");
		String uploadName = cal.format(today) + "_" + fileName;
		
		File target = new File(slidePath, uploadName);
		FileCopyUtils.copy(fileData, target);
		
		return uploadName;
	}
	
	
	
	
	@GetMapping("/excel")
	public void excelGet(Model model) {
		List<AdminExcelVO> list = new ArrayList<AdminExcelVO>();
		list = dao.getExcelList();
		
		for(int i=0; i<list.size(); i++) {
			int index = list.get(i).getFile_name().indexOf("_");
			String date = list.get(i).getFile_name().substring(0, index);
			String name = list.get(i).getFile_name().substring(index+1);
			
			list.get(i).setUpload_date(date);
			list.get(i).setFile_name(name);
		}
		
		model.addAttribute("list", list);
	}
	@PostMapping("/excel")
	public String excelPost(MultipartFile file) throws IOException {
		
		String file_name = uploadExcel(file.getOriginalFilename(), file.getBytes());
		
		AdminExcelVO vo = new AdminExcelVO();
		vo.setFile_name(file_name);
		vo.setFile_path(excelPath+"\\"+file_name);
		
		dao.changeAll_to_noUse();
		dao.insertExcel(vo);
		 
		return "redirect:excel";
	}
	
	
	
	@ResponseBody
	@PostMapping("/delExcel")
	public String delExcelPost(String uid, String pick) {
		String result = "";
		
		if(pick.equals("사용중")) {
			result = "no";
		}else {
			AdminExcelVO vo = new AdminExcelVO();
			vo.setUid(Integer.parseInt(uid));
			vo.setPick(pick);
			
			dao.deleteExcel(vo);
			
			result = "ok";
		}
		return result;
	}
	
	
	
	@ResponseBody
	@PostMapping("/changeExcel")
	public void changeExcelPost(String uid) {
		dao.changeAll_to_noUse();
		dao.changeUse(uid);
	}
	
	
	
	
	@GetMapping("/main")
	public void mainGet() {
		
	}
	
	@GetMapping("/index")
	public void indexGet(Model model) {
		List<MemberVO> list = dao.getAllMember();

		model.addAttribute("list", list);
	}

	@GetMapping("/force")
	public String forceGet(String id) {
		dao.force(id);
		
		return "redirect:allMember";
	}
	
	
	@GetMapping("/setting/slidimgAdmin")
	public void slidimgAdmin(Model model) {
		List<SlideImgVO> list1 = dao.getSlide1();
		List<SlideImgVO> list2 = dao.getSlide2();
		
		model.addAttribute("list1", list1);
		model.addAttribute("list2", list2);
	}
	@PostMapping("/setting/slidimgAdmin")
	public String slideImgPost(MultipartFile file) throws IOException {
		System.out.println(file);
		String file_name = uploadSlide(file.getOriginalFilename(), file.getBytes());
		
		SlideImgVO vo = new SlideImgVO();
		vo.setFile_name(file_name);
		//vo.setNum(number);
		
		//int count = dao.checkImg(vo);
		//if(count == 0) {
			dao.insertImg(vo);
		//}else {
			//dao.updateImg(vo);
		//}
		
		return "redirect:/admin/setting/slidimgAdmin";
	}
	@GetMapping("/updateSlide")
	public String updateSlide(String uid, String num) {
		SlideImgVO vo = new SlideImgVO();
		
		int count = dao.checkImg(num);
		if(count != 0) {
			vo = dao.getSlideInfo(uid);
			vo.setNum(num);
			dao.updateImg1(vo);
		} else {
			vo = dao.getSlideInfo(uid);
			vo.setNum(num);
			dao.updateImg2(vo);
		}
			
		return "redirect:/admin/setting/slidimgAdmin";
	}
	
	@GetMapping("/slidedelete")
	public String slidedelete(String uid) {
		
		dao.slideDelete(uid);
		return "redirect:/admin/setting/slidimgAdmin";
	}
	
	
	
	@GetMapping("/setting/ask")
	public void askGet(Model model) {
		List<AskVO> list = dao.getAllask();
		for(int i=0; i<list.size(); i++) {
			String count = dao.countAnswer(list.get(i).getUid());
			list.get(i).setCount(count);
		}
		
		model.addAttribute("list", list);
	}
}
