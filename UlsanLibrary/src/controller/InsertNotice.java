package controller;

import java.awt.Image;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.sun.jimi.core.Jimi;
import com.sun.jimi.core.JimiUtils;

import dao.NoticeDAO;
import model.Nnotice;

@WebServlet("/notice/insertN")
@MultipartConfig(
		fileSizeThreshold = 0,
		location = "C:\\JSP\\UlsanLibrary\\WebContent\\upload" //저장될 경로
)
public class InsertNotice extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public InsertNotice() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAll(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAll(request, response);
	}
	
	protected void doAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		NoticeDAO ndao = new NoticeDAO();
		Nnotice notice = new Nnotice();
		
		Part part = request.getPart("file");
		
		String uploadFileName = "";
		String thum_file = "";
		
		if(part.getSize() > 0) {
			String contentDisposition = part.getHeader("content-disposition");
			uploadFileName = getUploadFileName(contentDisposition);
			
			Date today = new Date();
			SimpleDateFormat cal = new SimpleDateFormat("yyyyMMddHHmmss");
			String signdate = cal.format(today);
			
			uploadFileName = signdate + "_" + uploadFileName;
			
			part.write(uploadFileName);
			
			String filepath = "C:\\JSP\\UlsanLibrary\\WebContent\\upload";
			String orgImg = filepath + uploadFileName;
			thum_file = "thum_" + uploadFileName;
			String thumbImg = filepath + thum_file;

			int thumbWidth = 60;
			int thumbHeight = 60;
			
			try {
				Image thumbnail = JimiUtils.getThumbnail(orgImg, thumbWidth, thumbHeight, Jimi.IN_MEMORY);// 썸네일 설정
				Jimi.putImage(thumbnail, thumbImg);// 썸네일 생성
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		notice.setContent(request.getParameter("content"));
		notice.setFile(uploadFileName);
		notice.setThum_file(thum_file);
		notice.setTitle(request.getParameter("title"));
		notice.setId(request.getParameter("id"));
		notice.setName(request.getParameter("name"));
		
		ndao.insert_notice(notice);
		
		response.sendRedirect("SelectN");
		
	}
	private String getUploadFileName(String contentDisposition) {
		String uploadFileName = null;
		String[] contentSplitStr = contentDisposition.split(";");
		
		//사용자 브라우저가 크롬계열일 경우
		int firstQutosIndex = contentSplitStr[2].indexOf("\"");
		int lastQutosIndex = contentSplitStr[2].lastIndexOf("\"");

		uploadFileName = contentSplitStr[2].substring(firstQutosIndex + 1, lastQutosIndex);
		
		// 사용자 브라우저가 IE일 경우
		// int lastPathSeparatorIndex = contentSplitStr[2].lastIndexOf("\\");
		// int lastQutosIndex =contentSplitStr[2].lastIndexOf("\"");
		// uploadFileName = contentSplitStr[2].substring(lastPathSeparatorIndex + 1, lastQutosIndex);
		
		return uploadFileName;
	}

}
