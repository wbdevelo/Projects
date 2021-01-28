package org.zerock.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.json.simple.parser.ParseException;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.Excel2VO;
import org.zerock.domain.LIkesVO;
import org.zerock.domain.SlideImgVO;
import org.zerock.domain.StoreVO;
import org.zerock.persistence.AdminDAO;
import org.zerock.persistence.AjaxDAO;

@RestController
@RequestMapping("/ajax")
public class ajaxController {
	
	@Inject
	private AjaxDAO adao;
	@Inject
	private AdminDAO adminDao;
	
	@GetMapping("/selsido")
	public ArrayList<Object> selectSiDo(String sido, Model model) {
		
		ArrayList<String> si = new ArrayList<String>();
		ArrayList<Excel2VO> si_gu = new ArrayList<Excel2VO>();
		
		try {
			// xlsx 파일경로
			FileInputStream fis=new FileInputStream("C:\\JSP\\PJ3\\src\\main\\webapp\\resources\\excel\\adm_code1.xlsx");
			
			XSSFWorkbook workbook=new XSSFWorkbook(fis);
			
			int rowindex=0;
			int columnindex=0;
			
			//시트 수 (첫번째에만 존재하므로 0을 준다)
			//만약 각 시트를 읽기위해서는 FOR문을 한번 더 돌려준다
			XSSFSheet sheet=workbook.getSheetAt(0);
			//행의 수
			int rows=sheet.getPhysicalNumberOfRows();
			for(rowindex=1;rowindex<rows;rowindex++){
				Excel2VO vo = new Excel2VO();
			    //행을읽는다
			    XSSFRow row=sheet.getRow(rowindex);
			    if(row !=null){
			        //셀의 수
			        int cells=row.getPhysicalNumberOfCells();
			        for(columnindex=0;columnindex<=cells;columnindex++){
			            //셀값을 읽는다
			            XSSFCell cell=row.getCell(columnindex);
			            String value="";
			            //셀이 빈값일경우를 위한 널체크
			            if(cell==null){
			                continue;
			            }else{
			                //타입별로 내용 읽기
			                switch (cell.getCellType()){
			                case XSSFCell.CELL_TYPE_FORMULA:
			                    value=cell.getCellFormula();
			                    break;
			                case XSSFCell.CELL_TYPE_NUMERIC:
			                    value=cell.getNumericCellValue()+"";
			                    break;
			                case XSSFCell.CELL_TYPE_STRING:
			                    value=cell.getStringCellValue()+"";
			                    break;
			                case XSSFCell.CELL_TYPE_BLANK:
			                    value=cell.getBooleanCellValue()+"";
			                    break;
			                case XSSFCell.CELL_TYPE_ERROR:
			                    value=cell.getErrorCellValue()+"";
			                    break;
			                }
			                
			                switch (columnindex) {
			                case 0 :
			                	vo.setSi(value);
			                	si.add(value);
			                	break;
			                case 1 :
			                	vo.setGu(value);
			                	break;
			                default:
			                	break;
			                }
			            }
			        }
			        si_gu.add(vo);
			    }
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		//시 중복제거
		ArrayList<String> si2 = new ArrayList<String>();
		for(int i=0; i<si.size()-1; i++) {
			if(si2.size() == 0) {
				si2.add(si.get(i).toString());
			}else {
				if(si.get(i).toString().equals(si.get(i+1).toString())) {
					
				}else {
					si2.add(si.get(i+1).toString());
				}
			}
		}
		//구 띄어쓰기 전 것만
		for(int i=0; i<si_gu.size(); i++) {
			String a = si_gu.get(i).getGu().toString();
			if(a.lastIndexOf(" ") != -1) {
				a = a.substring(0, a.lastIndexOf(" "));
				si_gu.get(i).setGu(a);
			}
		}
		//구 중복제거
		ArrayList<Excel2VO> si_gu2 = new ArrayList<Excel2VO>();
		for(int i=0; i<si_gu.size()-1; i++) {
			Excel2VO vo = new Excel2VO();
			if(si_gu2.size() == 0) {
				vo.setSi(si_gu.get(i).getSi().toString());
				vo.setGu(si_gu.get(i).getGu().toString());
				si_gu2.add(vo);
			}else {
				if(!si_gu.get(i).getGu().equals(si_gu2.get(0).getGu())) {
					if(si_gu.get(i).getGu().toString().equals(si_gu.get(i+1).getGu().toString())) {
						
					}else {
						vo.setSi(si_gu.get(i).getSi().toString());
						vo.setGu(si_gu.get(i).getGu().toString());
						si_gu2.add(vo);
					}		
				}
			}
		}
		//시와 군
		Map<String, Object> map = new HashMap<String, Object>();
		for(int i=0; i<si2.size(); i++) {
			ArrayList<String> gu = new ArrayList<String>();
			for(int j=0; j<si_gu2.size(); j++) {
				if(si2.get(i).equals(si_gu2.get(j).getSi())) {
					gu.add(si_gu2.get(j).getGu());
				}
			}
			map.put(si2.get(i).toString(), gu);
		}
		
		ArrayList<Object> ar = (ArrayList<Object>) map.get(sido);
		
		return ar;

	}
	
	@GetMapping("/selsidogu")
	public ArrayList<Object> selsidoguGet(String sido, String selgu, String nowPage, String searchWord, Model model) throws IOException, ParseException{

		ArrayList<Object> list = new ArrayList<Object>();
		
		if(nowPage == null || nowPage.equals("")) {
			nowPage = "1";
		}
		
		if(!sido.equals("") && !selgu.equals("")) {
			String totalCount = adao.getTotalCount(sido, selgu);
			
			if(!totalCount.equals("0")) {
				list = adao.getList(sido, selgu,totalCount, nowPage);
			}
		}else {
			if(searchWord == null || searchWord.equals("")) {
				list.add("x");
			}else {
				list = adao.getSearch(searchWord, nowPage);
			}
		}
		
       return list;
	}
	
	
	@PostMapping("/byeolRank")
	public List<Object> byeolRankPost(String si) {
		List<Object> list = new ArrayList<Object>();
		list = adao.getRank(si);
		System.out.println(list);
		return list;
	}
	
	@GetMapping("like")
	public List<LIkesVO> like(int code, String like, String date, HttpSession session) {
		String id = (String)session.getAttribute("session_id");
		LIkesVO lvo = new LIkesVO();
		lvo.setId(id);
		lvo.setStorecode(code);
		List<LIkesVO> chk = new ArrayList<LIkesVO>();
		int count = adao.likeSelect(lvo);
		lvo.setReg_date(date);
		
		if(count == 0) {
			lvo.setId(id);
			lvo.setStorecode(code);
			adao.InsertLike(lvo);
			chk = adao.likeSelectChk(lvo);
		}
			
		if(like.equals("0")) {
			like = "1";
			lvo.setLikechk(Integer.parseInt(like));
			lvo.setId(id);
			lvo.setStorecode(code);
			adao.updateLike(lvo);
			chk = adao.likeSelectChk(lvo);
		} else if(like.equals("1")){
			like = "0";
			lvo.setLikechk(Integer.parseInt(like));
			lvo.setId(id);
			lvo.setStorecode(code);
			adao.updateLike(lvo);
			chk = adao.likeSelectChk(lvo);
		}
		
		return chk;
	}

	@PostMapping("/slide")
	public List<SlideImgVO> slidePost() {
		List<SlideImgVO> list = adminDao.getSlide1();
		
		return list;
	}
	
	@GetMapping("/chkStoreAnsim")
	public StoreVO chkStoreAnsim(String sido, String sigugun, String address, String storename) {
		String totalCount = adao.getTotalCount(sido, sigugun);
		
		ArrayList<StoreVO> list = new ArrayList<StoreVO>();
		StoreVO store = new StoreVO();
		list = adao.getStoreList(sido, sigugun, totalCount);
		
		int cnt = list.size();
		for(int i=0; i<cnt; i++) {
			if(list.get(i).getRelax_add1().contains(address) && list.get(i).getRelax_rstrnt_nm().contains(storename)) {
				store.setRelax_seq(list.get(i).getRelax_seq());
				store.setDate(list.get(i).getDate());
				store.setRelax_add1(list.get(i).getRelax_add1());
				store.setRelax_gubun(list.get(i).getRelax_gubun());
				store.setRelax_gubun_detail(list.get(i).getRelax_gubun_detail());
				store.setRelax_rstrnt_nm(list.get(i).getRelax_rstrnt_nm());
				store.setRelax_rstrnt_represent(list.get(i).getRelax_rstrnt_represent());
				store.setRelax_rstrnt_tel(list.get(i).getRelax_rstrnt_tel());
				store.setRelax_si_nm(list.get(i).getRelax_si_nm());
				store.setRelax_sido_nm(list.get(i).getRelax_sido_nm());
			}
		}
		
		return store;
	}
	
	@PostMapping("/storecodeCheck")
	public String storecodeCheck(String storecode) {
		String code = "";
		
		code = adao.getCheckStorecode(storecode);
		
		return  code;
	}
	
}
