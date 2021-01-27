package e_controller;

import java.awt.Image;
import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.sun.jimi.core.Jimi;
import com.sun.jimi.core.JimiUtils;

import dao.EBookDAO;
import model.EBook;


@WebServlet("/e_book/update_E.do")
@MultipartConfig(
		fileSizeThreshold = 0,
		location = "C:\\JSP\\UlsanLibrary\\WebContent\\upload" //저장될 경로
)
public class UpdateE_Book extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public UpdateE_Book() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doALL(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doALL(request, response);
	}
	
	protected void doALL(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		EBookDAO ed = new EBookDAO();
		EBook eb = new EBook();
		
		int uid = Integer.parseInt(request.getParameter("uid"));
		
		String file1="";
		String file2 = "";
		//썸네일
		String thum_file1="";
		
		String file_o = request.getParameter("file");
		String bookfile = request.getParameter("bookfile");
		
		for(Part part:request.getParts()) {//getName():Part객체의 이름을 String타입으로 반환한다.
			if((part.getName().equals("file1") || part.getName().equals("file2")) && part.getSize() > 0) {//전송된 파라미터중 writer가 아닌것
				
				String contentDisposition = part.getHeader("content-disposition");//getSize():파일의 크기를 바이트 단위의 long탄입으로 반환한다.
				String uploadFileName = getUploadFileName(contentDisposition);//사용자가 업로드한 파일명을 얻어오는 부분이다.
				
				//오늘 날짜 구하기
				java.util.Date today = new java.util.Date();
				SimpleDateFormat cal = new SimpleDateFormat("yyMMddhhmmss");
				String signdate = cal.format(today);

				//중복 파일 피하기 위한 처리 
				uploadFileName = signdate+"_"+uploadFileName;
				part.write(uploadFileName);
				
				//file1
				if(part.getName().equals("file1")) {//getName():Part객체의 이름을 String타입으로 반환한다.
					file1 = uploadFileName;
				}
				//file2
				if(part.getName().equals("file2")) {
					file2 = uploadFileName;
				}
				
				//썸네일
				String filePath ="C:\\JSP\\UlsanLibrary\\WebContent\\upload\\";
				
				String orgImg = filePath+file1;//원본 파일
				thum_file1 = "thumb_"+file1;//썸네일 파일명
				String thumbImg = filePath+thum_file1;//파일경로+파일명
				
				int thumbWidth=250;//가로
				int thumbHeight=250;//세로
				
				try {
					
				Image thumbnail = JimiUtils.getThumbnail(orgImg, thumbWidth, thumbHeight, Jimi.IN_MEMORY);// 썸네일 설정
				Jimi.putImage(thumbnail, thumbImg);
				}catch(Exception e) {
					e.printStackTrace();
			}
		}
	}
		
		if(file1 != null && file2 != null ) {
			eb.setFile(file_o);
			eb.setBook_file(bookfile);
		}else {
			eb.setFile(file1);
			eb.setBook_file(file2);
		}
		
		eb.setTitle(request.getParameter("title"));
		eb.setContent(request.getParameter("content"));
		eb.setWriter(request.getParameter("writer"));
		eb.setPub_date(request.getParameter("pub_date"));
		eb.setDevice_pc(request.getParameter("device_pc"));
		eb.setDevice_mobile(request.getParameter("device_mobile"));
		eb.setDevice_tablet(request.getParameter("device_tablet"));
		eb.setThum_file(thum_file1);
		eb.setWrittenbyid(request.getParameter("id"));
		eb.setWrittenbyname(request.getParameter("name"));
		eb.setPrice(Integer.parseInt(request.getParameter("price")));
		eb.setUid(uid);
		
		ed.update_E(eb);
		
		response.sendRedirect("SelectE");
		
	}
	
	private String getUploadFileName(String contentDisposition) {


		String uploadFileName = null;

		String[] contentSplitStr = contentDisposition.split(";");

		int firstQutosIndex = contentSplitStr[2].indexOf("\"");

		int lastQutosIndex = contentSplitStr[2].lastIndexOf("\"");

		uploadFileName = contentSplitStr[2].substring(firstQutosIndex + 1, lastQutosIndex);

		return uploadFileName;

	}

}
