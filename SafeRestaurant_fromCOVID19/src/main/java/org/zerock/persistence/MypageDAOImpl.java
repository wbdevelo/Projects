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
import java.util.List;

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
import org.zerock.domain.AjaxVO;
import org.zerock.domain.LIkesVO;
import org.zerock.domain.MemberVO;
import org.zerock.domain.MenuVO;
import org.zerock.domain.PagingVO;
import org.zerock.domain.ReservationVO;
import org.zerock.domain.RestaurantVO;
import org.zerock.domain.StoreMemberVO;

@Repository
public class MypageDAOImpl implements MypageDAO{

	private static final String namespace = "org.zerock.mapper.MypageMapper";
	
	@Inject
	private SqlSession session;
	
	@Override
	public MemberVO getMemberInfo(String session_id) {
		return session.selectOne(namespace+".memberInfo", session_id);
	}
	
	@Override
	public StoreMemberVO getstoreMemberInfo(String session_id) {
		return session.selectOne(namespace+".storememberInfo", session_id);
	}

	@Override
	public void changePass(MemberVO mvo) {
		session.update(namespace+".changePass", mvo);
	}
	
	@Override
	public void changePassStore(StoreMemberVO svo) {
		session.update(namespace+".changePassStore", svo);
	}

	@Override
	public void secession(String id) {
		session.update(namespace+".secession", id);
	}
	
	@Override
	public void session2(String id) {
		session.update(namespace+".secession2", id);
	}
	
	@Override
	public int totalJjim(PagingVO vo) {
		return session.selectOne(namespace+".countLike", vo);
	}

	@Override
	public ArrayList<AjaxVO> jjimList(PagingVO vo) {
		List<LIkesVO> dbList = session.selectList(namespace+".jjimList", vo);
		ArrayList<AjaxVO> aList = new ArrayList<AjaxVO>();
		ArrayList<RestaurantVO> list = new ArrayList<RestaurantVO>();
		
		for(int i=0; i<dbList.size(); i++) {
			// 스트링 빌더 - 문자열을 더할 때 String처럼 새로운 객체를 생성하는 것이 아닌 기존의 데이터에 더하는 방식을 사용 	부하적고 속도 빠름
			StringBuilder urlBuilder = new StringBuilder("http://211.237.50.150:7080/openapi/98a7c867e44aca2a9f26374ca140eeb38e928776601b2b26f966d17ec7c37c37/json/Grid_20200713000000000605_1/1/1"); /*URL*/
	        
			try {				
				String code = Integer.valueOf(dbList.get(i).getStorecode()).toString();
				//URLEncoder.encode - URL형식에 맞게 인코딩해줌 //append를통해 파라미터를 넘김
				urlBuilder.append("?" + URLEncoder.encode("RELAX_SEQ","UTF-8") + "=" + URLEncoder.encode(code, "UTF-8"));/*Service Key*/
		        
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
		        
		        for(int j=0; j<par_arr.size(); j++) {
		        	AjaxVO avo = new AjaxVO();
		        	JSONObject weather = (JSONObject) par_arr.get(j);
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
		            
		            avo.setSi(RELAX_SI_NM);
		            avo.setTel(RELAX_RSTRNT_TEL);
		            avo.setKind_detail(RELAX_GUBUN_DETAIL);
		            avo.setName(RELAX_RSTRNT_NM);
		            avo.setCode(Long.valueOf(RELAX_SEQ).toString());
		            
		            if(Integer.valueOf(dbList.get(i).getStorecode()).toString().equals(avo.getCode())){
		            	avo.setDate(dbList.get(i).getReg_date());
		            }
		            
			        aList.add(avo);
		          }
			
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return aList;
	}

	@Override
	public void cancel_like(AjaxVO vo) {
		session.update(namespace+".cancelLike", vo);
	}

	@Override
	public List<ReservationVO> reservList(PagingVO vo) {
		return session.selectList(namespace+".reservList", vo);
	}
	
	@Override
	public List<ReservationVO> reservList2(String code) {
		return session.selectList(namespace+".reservList2", code);
	}

	@Override
	public void cancel_reserv(int uid) {
		session.delete(namespace+".cancel_reserv", uid);
	}
	
	@Override
	public int countAsk(String id) {
		return session.selectOne(namespace+".countAsk", id);
	}
	
	@Override
	public int totalReserv(PagingVO vo) {
		return session.selectOne(namespace+".totalReserv", vo);
	}
	
	
	
}
