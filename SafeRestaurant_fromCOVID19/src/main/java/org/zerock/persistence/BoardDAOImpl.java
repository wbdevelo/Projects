package org.zerock.persistence;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

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
import org.zerock.domain.CommentVO;
import org.zerock.domain.MenuVO;
import org.zerock.domain.ReservationVO;
import org.zerock.domain.RestaurantVO;
import org.zerock.domain.ReviewVO;
import org.zerock.domain.StoreMemberVO;
import org.zerock.domain.StoreVO;

import com.fasterxml.jackson.databind.util.JSONPObject;

@Repository
public class BoardDAOImpl implements BoardDAO{
	
	private static final String namespace = "org.zerock.mapper.BoardrMapper";

	@Inject
	private SqlSession session;
	
	@Override
	public void reviewInsert(ReviewVO vo) {
		session.insert(namespace+".reviewInsert", vo);
	}

	@Override
	public List<ReviewVO> getReview(String code) {
		return session.selectList(namespace+".reviewSelect", code);
	}
	
	@Override
	public void reviewDelete(int uid) {
		session.delete(namespace+".reviewDelete", uid);
	}

	@Override
	public Map<String, String> getDetail(String rname) {
		Map<String, String> map = new HashMap<String, String>();
		try {
			FileInputStream fis=new FileInputStream("C:\\jsp\\Ksm_Project3\\src\\main\\webapp\\resources\\xlsx\\안심식당+정보_20210106.xlsx");
			XSSFWorkbook workbook=new XSSFWorkbook(fis);
			int rowindex=0;
			int columnindex=0;
			//시트 수 (첫번째에만 존재하므로 0을 준다)
			//만약 각 시트를 읽기위해서는 FOR문을 한번 더 돌려준다
			XSSFSheet sheet=workbook.getSheetAt(0);
			//행의 수
			int rows=sheet.getPhysicalNumberOfRows();
			for(rowindex=1;rowindex<rows;rowindex++){
				String code = "";
				String date = "";
				String name = "";
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
			                	code = value;
			                	break;
			                case 4 :
			                	name = value;
			                case 6 :
			                	date = value;
			                	break;
			                default:
			                	break;
			                }
			            }
			        }
	                if(name.contains(rname)) {
	                	map.put("code", code);
	                	map.put("date", date);
	                }
			    }
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return map;
	}
	// 겟 공공데이터 토탈 카운트 출력
	@Override
	public String GetcountTotal() {
		String count = "";
		
		StringBuilder urlBuilder = new StringBuilder("http://211.237.50.150:7080/openapi/98a7c867e44aca2a9f26374ca140eeb38e928776601b2b26f966d17ec7c37c37/json/Grid_20200713000000000605_1/1/1");
		
		try {
			
			//urlBuilder에 담김 주소값을 URL처리
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
	        //JSON데이터를 넣어 JSON Object 로 만들어 준다.
	        JSONObject obj = (JSONObject)par.parse(sb);
	        
	        //Grid_20200713000000000605_1의 배열을 추출
	        JSONObject json = (JSONObject)obj.get("Grid_20200713000000000605_1");
	        //배열의 key값으로 토탈카운트 추출
	        //System.out.println("=================================="+json.get("totalCnt"));
	        
	        count =  String.valueOf(json.get("totalCnt"));
			
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return count;
		
	}
	// 겟으로 들어올시 공공데이터 출력 함수 여기에 넣기
	@Override
	public ArrayList<StoreVO> getStoreListGet(String category, String totalcnt) {
		ArrayList<StoreVO> categorylist = new ArrayList<StoreVO>();
		
		long beforeTime = System.currentTimeMillis();
		
		try {
			int indexStart = 0; // 시작 인덱스
			int indexEnd = 0;	// 마지막 인덱스
			int cnt = 1;
			int avg = 1000;	//출력 평균수
			
			while(true) {
				if(cnt == 1) {
					indexStart = 1;
					indexEnd = 1000;
				} else {
					indexStart = ((cnt-1)*avg)+1;
					indexEnd = (indexStart+avg)-1;
					
					if(indexEnd>Integer.parseInt(totalcnt)) {
						indexEnd = Integer.parseInt(totalcnt);
					}
				}
				
				//StringBuilder urlBuilder = new StringBuilder("http://211.237.50.150:7080/openapi/98a7c867e44aca2a9f26374ca140eeb38e928776601b2b26f966d17ec7c37c37/json/Grid_20200713000000000605_1/"+startIndex+"/"+endIndex); /*URL*/
				StringBuilder urlBuilder = new StringBuilder("http://211.237.50.150:7080/openapi/98a7c867e44aca2a9f26374ca140eeb38e928776601b2b26f966d17ec7c37c37/json/Grid_20200713000000000605_1/"+indexStart+"/"+indexEnd); /*URL*/
				
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
		        //System.out.println(sb.toString());
		        
		        JSONParser par = new JSONParser();
		        JSONObject obj = (JSONObject)par.parse(sb);
		        JSONObject json = (JSONObject)obj.get("Grid_20200713000000000605_1");
		        JSONArray par_arr = (JSONArray)json.get("row");
		        
		        for(int i=0; i<par_arr.size(); i++) {
		        	JSONObject store = (JSONObject) par_arr.get(i);
		        	
		        	String relax_rstrnt_nm =(String) store.get("RELAX_RSTRNT_NM");
		        	relax_rstrnt_nm = relax_rstrnt_nm.replace("\n", "");
		        	
		        	String relax_rstrnt_represent = (String) store.get("RELAX_RSTRNT_REPRESENT");
		        	relax_rstrnt_represent = relax_rstrnt_represent.replace("\n", ""); 
		        	
		        	String relax_rstrnt_tel = (String) store.get("RELAX_RSTRNT_TEL");
		        	relax_rstrnt_tel = relax_rstrnt_tel.replace("\n", "");
		        	
	        		StoreVO svo = new StoreVO();
	        		svo.setRelax_seq((Long)store.get("RELAX_SEQ")); 			// 안심식당 코드
	        		svo.setRelax_si_nm((String) store.get("RELAX_SI_NM"));		// 시도명
		        	svo.setRelax_sido_nm((String) store.get("RELAX_SIDO_NM"));	// 시 구 군 명
		        	svo.setRelax_gubun((String) store.get("RELAX_GUBUN"));		// 업종
		        	svo.setRelax_rstrnt_represent(relax_rstrnt_represent);	// 대표자명
		            svo.setRelax_add1((String) store.get("RELAX_ADD1"));		// 주소1
		            svo.setRelax_rstrnt_tel(relax_rstrnt_tel);				//	전화번호
		            svo.setRelax_rstrnt_nm(relax_rstrnt_nm);					//	가게명
		            svo.setRelax_gubun_detail((String) store.get("RELAX_GUBUN_DETAIL"));			// 업종
		            
		            categorylist.add(svo);
		        }
		       
		        if(categorylist.size() == Integer.parseInt(totalcnt)) {
		        	break;
		        } else {
		        	cnt++;
		        	continue;
		        }
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		long afterTime = System.currentTimeMillis(); 
		long secDiffTime = (afterTime - beforeTime)/1000;
		System.out.println("시간차이(m) : "+secDiffTime);

		return categorylist;
	}

	// 포스트로 넘어온 공공데이터의 모든 데이터의 카운트를 구하는 함수
	public String countTotal(String sido, String sigugun) {
		String count = "";
		
		StringBuilder urlBuilder = new StringBuilder("http://211.237.50.150:7080/openapi/98a7c867e44aca2a9f26374ca140eeb38e928776601b2b26f966d17ec7c37c37/json/Grid_20200713000000000605_1/1/1");
		
		try {
			urlBuilder.append("?" + URLEncoder.encode("RELAX_SI_NM","UTF-8") + "=" + URLEncoder.encode(sido, "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("RELAX_SIDO_NM","UTF-8") + "=" + URLEncoder.encode(sigugun, "UTF-8"));/*Service Key*/
			
			//urlBuilder에 담김 주소값을 URL처리
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
	        //JSON데이터를 넣어 JSON Object 로 만들어 준다.
	        JSONObject obj = (JSONObject)par.parse(sb);
	        
	        //Grid_20200713000000000605_1의 배열을 추출
	        JSONObject json = (JSONObject)obj.get("Grid_20200713000000000605_1");
	        //배열의 key값으로 토탈카운트 추출
	        //System.out.println("=================================="+json.get("totalCnt"));
	        
	        count =  String.valueOf(json.get("totalCnt"));
			
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return count;
	}

	@Override
	public ArrayList<StoreVO> getStoreList(String totalcnt, String category, String sido, String sigugun) {
		ArrayList<StoreVO> categorylist = new ArrayList<StoreVO>();
		
		try {
			StringBuilder urlBuilder = new StringBuilder("http://211.237.50.150:7080/openapi/98a7c867e44aca2a9f26374ca140eeb38e928776601b2b26f966d17ec7c37c37/json/Grid_20200713000000000605_1/1/"+totalcnt); /*URL*/
			
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
	        //System.out.println(sb.toString());
	        
	        JSONParser par = new JSONParser();
	        JSONObject obj = (JSONObject)par.parse(sb);
	        JSONObject json = (JSONObject)obj.get("Grid_20200713000000000605_1");
	        
	        if(json == null) {
	        	return categorylist;
	        }
	        
	        JSONArray par_arr = (JSONArray)json.get("row");
	        
	        for(int i=0; i<par_arr.size(); i++) {
	        	JSONObject store = (JSONObject) par_arr.get(i);
	        	String RELAX_GUBUN_DETAIL  = (String) store.get("RELAX_GUBUN_DETAIL");        // 업종상제
	        	
	        	if(category.equals(RELAX_GUBUN_DETAIL) || (RELAX_GUBUN_DETAIL.contains("기타") && category.contains("기타"))) {
	        		StoreVO svo = new StoreVO();
	        		svo.setRelax_seq((Long)store.get("RELAX_SEQ")); 			// 안심식당 코드
	        		svo.setRelax_si_nm((String) store.get("RELAX_SI_NM"));		// 시도명
		        	svo.setRelax_sido_nm((String) store.get("RELAX_SIDO_NM"));	// 시 구 군 명
		        	svo.setRelax_gubun((String) store.get("RELAX_GUBUN"));		// 업종
		        	svo.setRelax_rstrnt_represent((String) store.get("RELAX_RSTRNT_REPRESENT"));	// 대표자명
		            svo.setRelax_add1((String) store.get("RELAX_ADD1"));		// 주소1
		            svo.setRelax_rstrnt_tel((String) store.get("RELAX_RSTRNT_TEL"));				//	전화번호
		            svo.setRelax_rstrnt_nm((String) store.get("RELAX_RSTRNT_NM"));					//	가게명
		            svo.setRelax_gubun_detail(RELAX_GUBUN_DETAIL);				// 업종
		            
		            categorylist.add(svo);
	        	}
	        }
	        
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		return categorylist;
	}
	
	@Override
	public void insertReserv_inStore(ReservationVO vo) {
		session.insert(namespace+".inStore", vo);
	}

	@Override
	public List<ReservationVO> getReservList(ReservationVO vo) {
		return session.selectList(namespace+".reservList", vo);
	}

	@Override
	public ArrayList<StoreVO> getAllList(String totalcnt, String category, String sido, String sigugun) {
		ArrayList<StoreVO> categorylist = new ArrayList<StoreVO>();
		
		try {
			StringBuilder urlBuilder = new StringBuilder("http://211.237.50.150:7080/openapi/98a7c867e44aca2a9f26374ca140eeb38e928776601b2b26f966d17ec7c37c37/json/Grid_20200713000000000605_1/1/"+totalcnt); /*URL*/
			
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
	        //System.out.println(sb.toString());
	        
	        JSONParser par = new JSONParser();
	        JSONObject obj = (JSONObject)par.parse(sb);
	        JSONObject json = (JSONObject)obj.get("Grid_20200713000000000605_1");
	        
	        if(json == null) {
	        	return categorylist;
	        }
	        
	        JSONArray par_arr = (JSONArray)json.get("row");
	        
	        for(int i=0; i<par_arr.size(); i++) {
	        	JSONObject store = (JSONObject) par_arr.get(i);     
        		StoreVO svo = new StoreVO();
        		svo.setRelax_seq((Long)store.get("RELAX_SEQ")); 			// 안심식당 코드
        		svo.setRelax_si_nm((String) store.get("RELAX_SI_NM"));		// 시도명
	        	svo.setRelax_sido_nm((String) store.get("RELAX_SIDO_NM"));	// 시 구 군 명
	        	svo.setRelax_gubun((String) store.get("RELAX_GUBUN"));		// 업종
	        	svo.setRelax_rstrnt_represent((String) store.get("RELAX_RSTRNT_REPRESENT"));	// 대표자명
	            svo.setRelax_add1((String) store.get("RELAX_ADD1"));		// 주소1
	            svo.setRelax_rstrnt_tel((String) store.get("RELAX_RSTRNT_TEL"));				//	전화번호
	            svo.setRelax_rstrnt_nm((String) store.get("RELAX_RSTRNT_NM"));					//	가게명
	            svo.setRelax_gubun_detail((String) store.get("RELAX_GUBUN_DETAIL"));			 // 업종상제
	            
	            categorylist.add(svo);
        	}
	        
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		return categorylist;
	}

	@Override
	public StoreMemberVO getStoreMember(String code) {
		return session.selectOne(namespace+".StroeGetMember", code);
	}

	@Override
	public void InsertMenu(MenuVO vo) {
		session.insert(namespace+".menuInsert", vo);
	}

	@Override
	public List<MenuVO> getMenu(String code) {
		return session.selectList(namespace+".ListMenuGet", code);
	}

	@Override
	public void DeleteMenu(String uid) {
		session.delete(namespace+".deletemenu", uid);
	}
	
	@Override
	public void UpdateMenu(MenuVO vo) {
		session.update(namespace+".updatemenu", vo);
		
	}

	@Override
	public int getFid(String code) {
		return session.selectOne(namespace+".getfid", code);
	}

	@Override
	public ReviewVO getFidwhereUid(ReviewVO vo) {
		return session.selectOne(namespace+".getFidwhereUid", vo);
	}

	@Override
	public void replyInset(CommentVO vo) {
		session.insert(namespace+".insertReplay", vo);
		
	}

	@Override
	public List<CommentVO> getComment(String code) {
		return session.selectList(namespace+".listcomment", code);
	}

	@Override
	public int getcountFid(String code) {
		return session.selectOne(namespace+".getFidcnt", code);
	}		

}
