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
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.sun.jimi.core.Jimi;
import com.sun.jimi.core.JimiUtils;

import dao.GalleryDAO;
import model.Gallery;

@WebServlet("/gallery/insert_G")
@MultipartConfig(
		fileSizeThreshold = 0,
		location = "C:\\JSP\\UlsanLibrary2\\WebContent\\upload" //저장될 경로
)
public class InsertGallery extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public InsertGallery() {
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
		HttpSession session = request.getSession();

		GalleryDAO gd = new GalleryDAO();
		Gallery g = new Gallery();
		
		String uploadFileName = "";
		String thumb_file = "";

		Part part = request.getPart("file");
		
		if(part.getSize() > 0) {
			String contentDisposition = part.getHeader("content-disposition");
			uploadFileName = getUploadFileName(contentDisposition);
			
			Date today = new Date();
			SimpleDateFormat cal = new SimpleDateFormat("yyyyMMddHHmmss");
			String signdate = cal.format(today);
			
			uploadFileName = signdate + "_" + uploadFileName;
			
			  if(uploadFileName == null || uploadFileName.equals("")) { 
				  uploadFileName = "20201208092834_image.png";
			  }
			 
			
			part.write(uploadFileName);
			
			String filepath = "C:\\JSP\\UlsanLibrary2\\WebContent\\upload\\";
			String orgImg = filepath + uploadFileName;
			thumb_file = "thumb_" + uploadFileName;
			String thumbImg = filepath + thumb_file;
			
			int thumbWidth = 200;
			int thumbHeight = 200;
			
			try {
				Image thumbnail = JimiUtils.getThumbnail(orgImg, thumbWidth, thumbHeight, Jimi.IN_MEMORY);// 썸네일 설정
				Jimi.putImage(thumbnail, thumbImg);// 썸네일 생성
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		

		g.setTitle(request.getParameter("title"));
		g.setContent(request.getParameter("content"));
		g.setFile(uploadFileName);
		g.setWriter(request.getParameter("writer"));
		g.setPub_date(request.getParameter("pub_date"));
		g.setISBN(request.getParameter("ISBN"));
		g.setThum_file(thumb_file);
		g.setLib_name(request.getParameter("name"));
		g.setDaechul(request.getParameter("daechul"));
		
		gd.insert_gallery(g);
		
		response.sendRedirect("SelectG");
		
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
