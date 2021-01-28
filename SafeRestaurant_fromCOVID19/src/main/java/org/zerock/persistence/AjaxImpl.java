package org.zerock.persistence;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Repository;
import org.zerock.domain.LIkesVO;
import org.zerock.domain.RestaurantVO;
import org.zerock.domain.StoreVO;


@Repository
public class AjaxImpl implements AjaxDAO{
	
	private static final String namespace = "org.zerock.mapper.AjaxMapper";
	
	@Inject
	private SqlSession session;
	
	@Inject
	private HttpSession sess;
	
	@Inject
	private AdminDAO adao;

	@Override
	public String getTotalCount(String sido, String sigu) {
		String totalCnt = "";
		// 스트링 빌더 - 문자열을 더할 때 String처럼 새로운 객체를 생성하는 것이 아닌 기존의 데이터에 더하는 방식을 사용 	부하적고 속도 빠름
		StringBuilder urlBuilder = new StringBuilder("http://211.237.50.150:7080/openapi/98a7c867e44aca2a9f26374ca140eeb38e928776601b2b26f966d17ec7c37c37/json/Grid_20200713000000000605_1/1/1"); /*URL*/
        
		try {
			//URLEncoder.encode - URL형식에 맞게 인코딩해줌 //append를통해 파라미터를 넘김
			urlBuilder.append("?" + URLEncoder.encode("RELAX_SI_NM","UTF-8") + "=" + URLEncoder.encode(sido, "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("RELAX_SIDO_NM","UTF-8") + "=" + URLEncoder.encode(sigu, "UTF-8"));/*Service Key*/
			
			//urlBuilder에 담김 주소값을 URL처리
			URL url = new URL(urlBuilder.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Content-type", "application/json");
	       
	        BufferedReader rd;
	        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        } else {
	            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	        }
	        String sb = "";
	        String line;
	        while ((line = rd.readLine()) != null) {
	            sb = sb.concat(line);
	        }
	        rd.close();
	        conn.disconnect();

	        JSONParser par = new JSONParser();
	        //JSON데이터를 넣어 JSON Object 로 만들어 준다.
	        JSONObject obj = (JSONObject)par.parse(sb);
	       
	        //Grid_20200713000000000605_1의 배열을 추출
	        JSONObject json = (JSONObject)obj.get("Grid_20200713000000000605_1");
	        //배열의 key값으로 토탈카운트 추출
	        //System.out.println("=================================="+json.get("totalCnt"));
	        
	        totalCnt =  String.valueOf(json.get("totalCnt"));
	        
		} catch (IOException e) {	
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return totalCnt;
	}

	@Override
	public ArrayList<Object> getList(String sido, String sigu,String totalCnt, String nowPage) {
		
		String id = (String)sess.getAttribute("session_id");
		ArrayList<RestaurantVO> list = new ArrayList<RestaurantVO>();
		ArrayList<RestaurantVO> list2 = new ArrayList<RestaurantVO>();
		int a = 0;
		ArrayList<Object> aobj = new ArrayList<Object>();
		
		try {
			String path = adao.getPath();
			
			FileInputStream fis=new FileInputStream(path);
			XSSFWorkbook workbook=new XSSFWorkbook(fis);
			int rowindex=0;
			int columnindex=0;
			//시트 수 (첫번째에만 존재하므로 0을 준다)
			//만약 각 시트를 읽기위해서는 FOR문을 한번 더 돌려준다
			XSSFSheet sheet=workbook.getSheetAt(0);
			//행의 수
			int rows=sheet.getPhysicalNumberOfRows();
			for(rowindex=1;rowindex<rows;rowindex++){
				RestaurantVO vo = new RestaurantVO();
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
			                	vo.setSeq(value);
			                	break;
			                case 6 :
			                	vo.setDate(value);
			                	break;
			                default:
			                	break;
			                }
			            }
			        }
	                list.add(vo);
			    }
			}
		
			// 스트링 빌더 - 문자열을 더할 때 String처럼 새로운 객체를 생성하는 것이 아닌 기존의 데이터에 더하는 방식을 사용 	부하적고 속도 빠름
			StringBuilder urlBuilder = new StringBuilder("http://211.237.50.150:7080/openapi/98a7c867e44aca2a9f26374ca140eeb38e928776601b2b26f966d17ec7c37c37/json/Grid_20200713000000000605_1/1/"+totalCnt); /*URL*/
			//URLEncoder.encode - URL형식에 맞게 인코딩해줌 //append를통해 파라미터를 넘김
			urlBuilder.append("?" + URLEncoder.encode("RELAX_SI_NM","UTF-8") + "=" + URLEncoder.encode(sido, "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("RELAX_SIDO_NM","UTF-8") + "=" + URLEncoder.encode(sigu, "UTF-8"));/*Service Key*/
	        
			URL url = new URL(urlBuilder.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Content-type", "application/json");
	        //System.out.println("Response code: " + conn.getResponseCode());
	        BufferedReader rd;
	        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        } else {
	            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	        }
	        String sb = "";
	        String line;
	        while ((line = rd.readLine()) != null) {
	            sb = sb.concat(line);
	        }
	        rd.close();
	        conn.disconnect();
	        //System.out.println(sb.toString());
	        
	        JSONParser par = new JSONParser();
	        JSONObject obj = (JSONObject)par.parse(sb);
	        //System.out.println("0000000000000000001"+obj);
	        JSONObject json = (JSONObject)obj.get("Grid_20200713000000000605_1");
	        //System.out.println(json.size()+"json사이즈");
	        JSONArray par_arr = (JSONArray)json.get("row");
	        //System.out.println(par_arr.size()+"par_arr사이즈는	.000000000000000000");
	        String miseType="";
	        
	        for(int i=0; i<par_arr.size(); i++) {
	        	JSONObject weather = (JSONObject) par_arr.get(i);
	        	Long RELAX_SEQ = (Long)weather.get("RELAX_SEQ");		// 안심식당 코드
	        	String RELAX_SI_NM = (String) weather.get("RELAX_SI_NM");            // 시도명
	            String RELAX_SIDO_NM = (String) weather.get("RELAX_SIDO_NM");    // 시 구 군 명
	            String RELAX_GUBUN = (String) weather.get("RELAX_GUBUN");            // 업종
	            String RELAX_RSTRNT_REPRESENT = (String) weather.get("RELAX_RSTRNT_REPRESENT");        // 대표자명
	            Date RELAX_RSTRNT_REG_DT = (Date) weather.get("RELAX_RSTRNT_REG_DT");        // 안심식당 지정일
	            String RELAX_ADD1  = (String) weather.get("RELAX_ADD1");        // 주소1
	            //String RELAX_ADD2  = (String) weather.get("RELAX_ADD2");        // 주소2
	            String RELAX_GUBUN_DETAIL  = (String) weather.get("RELAX_GUBUN_DETAIL");        // 업종상제
	            String RELAX_RSTRNT_TEL = (String) weather.get("RELAX_RSTRNT_TEL");        // 전화번호
	            String RELAX_RSTRNT_NM = (String) weather.get("RELAX_RSTRNT_NM"); 	// 음식점 이름
	            StringBuffer sb1 = new StringBuffer();
	            sb1.append("시도명 : " + RELAX_SI_NM + ", 시 구 군 명 : " + RELAX_SIDO_NM + ", 업종 : "+ RELAX_GUBUN + ", 대표자명: " + RELAX_RSTRNT_REPRESENT + ", 안심식당 지정일 : " 
	            + RELAX_RSTRNT_REG_DT + ", 업종상제 : " + RELAX_GUBUN_DETAIL + ", 주소1" + RELAX_ADD1 + ", 전화번호" + RELAX_RSTRNT_TEL);
	            //System.out.println(sb1.toString());
	            //aobj.add(weather);
	            
	            //찜 기능 추가
	            LIkesVO likevo = new LIkesVO();
	            likevo.setId(id);
	            likevo.setStorecode(Long.valueOf(RELAX_SEQ).intValue());
	            String like = session.selectOne(namespace+".getLike", likevo);
	            
	            if(like == null || like.equals("")) {
	            	weather.put("like", 0);
	            }else {
	            	weather.put("like", like);
	            }
	            
	            //엑셀에 있는 지정일 추가
	            for(int x=0; x<list.size(); x++) {
	            	Long list_seq = Long.parseLong(list.get(x).getSeq());
	            	if(list_seq.equals(RELAX_SEQ)) {
	            		weather.put("date", list.get(x).getDate());
	            	}
	            }
	            //totalCount 추가
	            weather.put("totalCount", totalCnt);
	            //nowPage 추가
	            weather.put("nowPage", nowPage);
	            aobj.add(weather);
	        }
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return aobj;
	}
	
	// 안심식당 코드 값을 통해 상세페이지에 해당하는 자료 뽑기
		@Override
		public StoreVO getStore(String code) {
			StoreVO store = new StoreVO();
			ArrayList<RestaurantVO> list = new ArrayList<RestaurantVO>();
			try {
				String path = adao.getPath();
				
				FileInputStream fis=new FileInputStream(path);
				XSSFWorkbook workbook=new XSSFWorkbook(fis);
				int rowindex=0;
				int columnindex=0;
				//시트 수 (첫번째에만 존재하므로 0을 준다)
				//만약 각 시트를 읽기위해서는 FOR문을 한번 더 돌려준다
				XSSFSheet sheet=workbook.getSheetAt(0);
				//행의 수
				int rows=sheet.getPhysicalNumberOfRows();
				for(rowindex=1;rowindex<rows;rowindex++){
					RestaurantVO vo = new RestaurantVO();
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
				                	vo.setSeq(value);
				                	break;
				                case 6 :
				                	vo.setDate(value);
				                	break;
				                default:
				                	break;
				                }
				            }
				        }
		                list.add(vo);
				    }
				}
				
				// 스트링 빌더 - 문자열을 더할 때 String처럼 새로운 객체를 생성하는 것이 아닌 기존의 데이터에 더하는 방식을 사용 	부하적고 속도 빠름
				StringBuilder urlBuilder = new StringBuilder("http://211.237.50.150:7080/openapi/98a7c867e44aca2a9f26374ca140eeb38e928776601b2b26f966d17ec7c37c37/json/Grid_20200713000000000605_1/1/1"); /*URL*/
				//URLEncoder.encode - URL형식에 맞게 인코딩해줌
				urlBuilder.append("?" + URLEncoder.encode("RELAX_SEQ","UTF-8") + "=" + URLEncoder.encode(code, "UTF-8"));
				
				URL url = new URL(urlBuilder.toString());
				HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		        conn.setRequestMethod("GET");
		        conn.setRequestProperty("Content-type", "application/json");
		        
		        BufferedReader rd;
		        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
		            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		        } else {
		            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		        }
		        String sb = "";
		        String line;
		        while ((line = rd.readLine()) != null) {
		            sb = sb.concat(line);
		        }
		        rd.close();
		        conn.disconnect();
		        
		        JSONParser par = new JSONParser();
		        JSONObject obj = (JSONObject)par.parse(sb);
		        JSONObject json = (JSONObject)obj.get("Grid_20200713000000000605_1");
		        JSONArray par_arr = (JSONArray)json.get("row");
		        String miseType="";
		 
		        if(par_arr.size() != 0) {
		        	JSONObject weather = (JSONObject) par_arr.get(0);

		        	store.setRelax_seq((Long) weather.get("RELAX_SEQ"));
		        	store.setRelax_si_nm((String) weather.get("RELAX_SI_NM"));
		        	store.setRelax_sido_nm((String) weather.get("RELAX_SIDO_NM"));
		        	store.setRelax_rstrnt_nm((String) weather.get("RELAX_RSTRNT_NM"));
		        	store.setRelax_rstrnt_represent((String) weather.get("RELAX_RSTRNT_REPRESENT"));
		        	store.setRelax_add1((String) weather.get("RELAX_ADD1"));
		        	store.setRelax_gubun((String) weather.get("RELAX_GUBUN"));
		        	store.setRelax_gubun_detail((String) weather.get("RELAX_GUBUN_DETAIL"));
		        	store.setRelax_rstrnt_tel((String) weather.get("RELAX_RSTRNT_TEL"));
		        	
		            for(int j=0; j<list.size(); j++) {
		            	if(list.get(j).getSeq().equals(Long.toString(store.getRelax_seq()))) {
		            		store.setDate(list.get(j).getDate());
		            	}
		            }
		        }
		      
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return store;
		}

		@Override
		public ArrayList<Object> getSearch(String searchWord, String nowPage) {
			ArrayList<Object> list = new ArrayList<Object>();
			ArrayList<Object> listLike = new ArrayList<Object>();
			String id = (String)sess.getAttribute("session_id");
			
			try {
				String path = adao.getPath();
				
				FileInputStream fis=new FileInputStream(path);
				XSSFWorkbook workbook=new XSSFWorkbook(fis);
				int rowindex=0;
				int columnindex=0;
				//시트 수 (첫번째에만 존재하므로 0을 준다)
				//만약 각 시트를 읽기위해서는 FOR문을 한번 더 돌려준다
				XSSFSheet sheet=workbook.getSheetAt(0);
				//행의 수
				int rows=sheet.getPhysicalNumberOfRows();
				for(rowindex=1;rowindex<rows;rowindex++){
					Map<String, String> map = new HashMap<String, String>();
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
				                	map.put("RELAX_SEQ", value);
				                	break;
				                case 2 :
				                	map.put("RELAX_SI_NM", value);
				                	break;
				                case 3 :
				                	map.put("RELAX_SIDO_NM", value);
				                	break;
				                case 4 :
				                	map.put("RELAX_RSTRNT_NM", value);
				                	break;
				                case 5 :
				                	map.put("RELAX_RSTRNT_REPRESENT", value);
				                	break;
				                case 6 :
				                	map.put("date", value);
				                	break;
				                case 7 :
				                	map.put("RELAX_ADD1", value);
				                	break;
				                case 9 :
				                	map.put("RELAX_GUBUN", value);
				                	break;
				                case 10 :
				                	map.put("RELAX_GUBUN_DETAIL", value);
				                	break;
				                case 11 :
				                	map.put("RELAX_RSTRNT_TEL", value);
				                	break;
				                default:
				                	break;
				                }
				            }
				        }
		                if(map.get("RELAX_ADD1").contains(searchWord) || map.get("RELAX_RSTRNT_NM").contains(searchWord)) {
		                	map.put("nowPage", nowPage);
		                	list.add(map);
		                }
				    }
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			//찜 기능 추가
            for(int i=0; i<list.size(); i++) {
            	Map<String, Object> m = (Map<String, Object>) list.get(i);
            	LIkesVO lvo = new LIkesVO();
            	lvo.setId(id);
            	lvo.setStorecode(Integer.parseInt(m.get("RELAX_SEQ").toString()));
            	String like = session.selectOne(namespace+".getLike", lvo);
            	
            	if(like == null || like.equals("")) {
            		m.put("like", "0");
            	}else {
            		m.put("like", like);
            	}
            	listLike.add(m);
            }
			
			return listLike;
		}

		
		
		@Override
		public List<Object> getRank(String si) {
			return session.selectList(namespace+".rank", si);
		}
		
		@Override
		public int likeSelect(LIkesVO lvo) {
			return session.selectOne(namespace+".selectLIkeId", lvo);
		}

		@Override
		public void InsertLike(LIkesVO lvo) {
			session.insert(namespace+".insertLike", lvo);
			
		}

		@Override
		public List<LIkesVO> likeSelectChk(LIkesVO lvo) {
			return session.selectList(namespace+".LikeChk", lvo);
		}

		@Override
		public void updateLike(LIkesVO lvo) {
			session.update(namespace+".updateLikechk", lvo);
		}

		@Override
		public ArrayList<StoreVO> getStoreList(String sido, String sigugun, String totalCount) {
			ArrayList<RestaurantVO> list = new ArrayList<RestaurantVO>();
			ArrayList<StoreVO> list2 = new ArrayList<StoreVO>();
			
			try {
				String path = adao.getPath();
				
				FileInputStream fis=new FileInputStream(path);
				XSSFWorkbook workbook=new XSSFWorkbook(fis);
				int rowindex=0;
				int columnindex=0;
				//시트 수 (첫번째에만 존재하므로 0을 준다)
				//만약 각 시트를 읽기위해서는 FOR문을 한번 더 돌려준다
				XSSFSheet sheet=workbook.getSheetAt(0);
				//행의 수
				int rows=sheet.getPhysicalNumberOfRows();
				for(rowindex=1;rowindex<rows;rowindex++){
					RestaurantVO vo = new RestaurantVO();
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
				                	vo.setSeq(value);
				                	break;
				                case 6 :
				                	vo.setDate(value);
				                	break;
				                default:
				                	break;
				                }
				            }
				        }
		                list.add(vo);
				    }
				}
			
				// 스트링 빌더 - 문자열을 더할 때 String처럼 새로운 객체를 생성하는 것이 아닌 기존의 데이터에 더하는 방식을 사용 	부하적고 속도 빠름
				StringBuilder urlBuilder = new StringBuilder("http://211.237.50.150:7080/openapi/98a7c867e44aca2a9f26374ca140eeb38e928776601b2b26f966d17ec7c37c37/json/Grid_20200713000000000605_1/1/"+totalCount); /*URL*/
				//URLEncoder.encode - URL형식에 맞게 인코딩해줌 //append를통해 파라미터를 넘김
				urlBuilder.append("?" + URLEncoder.encode("RELAX_SI_NM","UTF-8") + "=" + URLEncoder.encode(sido, "UTF-8"));
				urlBuilder.append("&" + URLEncoder.encode("RELAX_SIDO_NM","UTF-8") + "=" + URLEncoder.encode(sigugun, "UTF-8"));/*Service Key*/
		        
				URL url = new URL(urlBuilder.toString());
				HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		        conn.setRequestMethod("GET");
		        conn.setRequestProperty("Content-type", "application/json");
		        //System.out.println("Response code: " + conn.getResponseCode());
		        BufferedReader rd;
		        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
		            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		        } else {
		            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		        }
		        String sb = "";
		        String line;
		        while ((line = rd.readLine()) != null) {
		            sb = sb.concat(line);
		        }
		        rd.close();
		        conn.disconnect();
		        
		        JSONParser par = new JSONParser();
		        JSONObject obj = (JSONObject)par.parse(sb);
		        JSONObject json = (JSONObject)obj.get("Grid_20200713000000000605_1");
		        JSONArray par_arr = (JSONArray)json.get("row");

		        for(int i=0; i<par_arr.size(); i++) {
		        	JSONObject weather = (JSONObject) par_arr.get(i);
		        	StoreVO store = new StoreVO();
		        	store.setRelax_seq((Long)weather.get("RELAX_SEQ"));		// 안심식당 코드
		        	store.setRelax_si_nm((String) weather.get("RELAX_SI_NM"));            // 시도명
		            store.setRelax_sido_nm((String) weather.get("RELAX_SIDO_NM"));    // 시 구 군 명
		            store.setRelax_gubun((String) weather.get("RELAX_GUBUN"));            // 업종
		            store.setRelax_rstrnt_represent((String) weather.get("RELAX_RSTRNT_REPRESENT"));        // 대표자명
		            store.setRelax_add1((String) weather.get("RELAX_ADD1"));        // 주소1
		            store.setRelax_gubun_detail((String) weather.get("RELAX_GUBUN_DETAIL"));        // 업종상제
		            store.setRelax_rstrnt_tel((String) weather.get("RELAX_RSTRNT_TEL"));        // 전화번호
		            store.setRelax_rstrnt_nm((String) weather.get("RELAX_RSTRNT_NM")); 	// 음식점 이름
		            
		            //엑셀에 있는 지정일 추가
		            for(int x=0; x<list.size(); x++) {
		            	Long list_seq = Long.parseLong(list.get(x).getSeq());
		            	if(list_seq.equals(store.getRelax_seq())) {
		            		store.setDate(list.get(x).getDate());
		            	}
		            }
		            list2.add(store);
		        }
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return list2;
		}

		@Override
		public String getCheckStorecode(String storecode) {
			String code = "";
		
			try {
				// 스트링 빌더 - 문자열을 더할 때 String처럼 새로운 객체를 생성하는 것이 아닌 기존의 데이터에 더하는 방식을 사용 	부하적고 속도 빠름
				StringBuilder urlBuilder = new StringBuilder("http://211.237.50.150:7080/openapi/98a7c867e44aca2a9f26374ca140eeb38e928776601b2b26f966d17ec7c37c37/json/Grid_20200713000000000605_1/1/1"); /*URL*/
				//URLEncoder.encode - URL형식에 맞게 인코딩해줌 //append를통해 파라미터를 넘김
				urlBuilder.append("?" + URLEncoder.encode("RELAX_SEQ","UTF-8") + "=" + URLEncoder.encode(storecode, "UTF-8"));
				
				URL url = new URL(urlBuilder.toString());
				HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		        conn.setRequestMethod("GET");
		        conn.setRequestProperty("Content-type", "application/json");
		        //System.out.println("Response code: " + conn.getResponseCode());
		        BufferedReader rd;
		        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
		            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		        } else {
		            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		        }
		        String sb = "";
		        String line;
		        while ((line = rd.readLine()) != null) {
		            sb = sb.concat(line);
		        }
		        rd.close();
		        conn.disconnect();
		        
		        JSONParser par = new JSONParser();
		        JSONObject obj = (JSONObject)par.parse(sb);
		        JSONObject json = (JSONObject)obj.get("Grid_20200713000000000605_1");
		        if(json== null) {
		        	return code;
		        }
		        JSONArray par_arr = (JSONArray)json.get("row");

		        for(int i=0; i<par_arr.size(); i++) {
		        	JSONObject weather = (JSONObject) par_arr.get(i);
		        	code = String.valueOf((Long)weather.get("RELAX_SEQ"));		// 안심식당 코드
		        }
		        
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
				
			return code;
		}

}
