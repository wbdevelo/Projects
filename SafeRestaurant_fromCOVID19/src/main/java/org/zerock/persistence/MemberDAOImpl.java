package org.zerock.persistence;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;

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
import org.zerock.domain.MemberVO;
import org.zerock.domain.RestaurantVO;
import org.zerock.domain.StoreMemberVO;
import org.zerock.domain.StoreVO;


@Repository
public class MemberDAOImpl implements MemberDAO{
	
	private static final String namespace = "org.zerock.mapper.MemberMapper";
	
	@Inject
	private SqlSession session;
	@Inject
	private AdminDAO adao;

	@Override
	public String idCheck(String userId) {
		return session.selectOne(namespace+".checkId", userId);
	}
	
	@Override
	public String storeidCheck(String userId) {
		return session.selectOne(namespace+".storecheckId", userId);
	}

	@Override
	public void join(MemberVO vo) {
		session.insert(namespace+".join", vo);		
	}

	@Override
	public int login(MemberVO vo) {
		return session.selectOne(namespace+".login", vo);
	}

	@Override
	public MemberVO searchId(MemberVO vo) {
		return session.selectOne(namespace+".searchId", vo);
	}
	
	@Override
	public StoreMemberVO storesearchId(StoreMemberVO vo) {
		return session.selectOne(namespace+".storesearchId", vo);
	}

	@Override
	public int searchPw(MemberVO vo) {
		return session.selectOne(namespace+".searchPw", vo);
	}
	@Override
	public int StoresearchPw(StoreMemberVO vo) {
		return session.selectOne(namespace+".StoresearchPw", vo);
	}
	@Override
	public void changePw(MemberVO vo) {
		session.update(namespace+".changePw", vo);
	}
	@Override
	public void changePw2(StoreMemberVO vo) {
		session.update(namespace+".changePw2", vo);
	}

	@Override
	public MemberVO oneMember(String id) {
		return session.selectOne(namespace+".oneMember", id);
	}

	@Override
	public void modifyMem(MemberVO vo) {
		session.update(namespace+".modifyMem", vo);
	}

	@Override
	public String getID(String userId) {
		return session.selectOne(namespace+".getId", userId);
	}

	@Override
	public void InsertStoreMember(StoreMemberVO vo) {
		session.insert(namespace+".storememberinsert", vo);
		
	}

	@Override
	public StoreVO getStoreInfo(String storecode) {
		StoreVO svo = new StoreVO();
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
	        	return svo;
	        }
	        JSONArray par_arr = (JSONArray)json.get("row");

	        for(int i=0; i<par_arr.size(); i++) {
	        	JSONObject weather = (JSONObject) par_arr.get(i);
	        	svo.setRelax_seq((Long)weather.get("RELAX_SEQ"));		// 안심식당 코드
	        	svo.setRelax_si_nm((String) weather.get("RELAX_SI_NM"));            // 시도명
	        	svo.setRelax_sido_nm((String) weather.get("RELAX_SIDO_NM"));    // 시 구 군 명
	        	svo.setRelax_gubun((String) weather.get("RELAX_GUBUN"));            // 업종
	        	svo.setRelax_rstrnt_represent((String) weather.get("RELAX_RSTRNT_REPRESENT"));        // 대표자명
	        	svo.setRelax_add1((String) weather.get("RELAX_ADD1"));        // 주소1
	        	svo.setRelax_gubun_detail((String) weather.get("RELAX_GUBUN_DETAIL"));        // 업종상제
	        	svo.setRelax_rstrnt_tel((String) weather.get("RELAX_RSTRNT_TEL"));        // 전화번호
	        	svo.setRelax_rstrnt_nm((String) weather.get("RELAX_RSTRNT_NM")); 	// 음식점 이름
	            
	            //엑셀에 있는 지정일 추가
	            for(int x=0; x<list.size(); x++) {
	            	Long list_seq = Long.parseLong(list.get(x).getSeq());
	            	if(list_seq.equals(svo.getRelax_seq())) {
	            		svo.setDate(list.get(x).getDate());
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
	
		return svo;
	}

	@Override
	public StoreMemberVO getStoreDbInfo(StoreMemberVO vo) {
		return session.selectOne(namespace+".dbstoreInfo", vo);
	}

	@Override
	public void modifyMemStore(StoreMemberVO vo) {
		session.update(namespace+".modifyMemstore", vo);
	}

}
