package controller;

import java.awt.Image;
import java.io.IOException;
import java.net.URLEncoder;
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

import dao.GalleryDAO;
import model.Gallery;

@WebServlet("/gallery/update_gallery.do")@MultipartConfig(
		fileSizeThreshold = 0,
		location = "C:\\JSP\\UlsanLibrary2\\WebContent\\upload" //저장될 경로
)
public class UpdateGallery extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public UpdateGallery() {
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
		
		GalleryDAO gdao = new GalleryDAO();
		Gallery g = new Gallery();
		
		int uid = Integer.parseInt(request.getParameter("uid"));
		String uploadFileName = "";
		String thum_file = "";
		
		
		Part part = request.getPart("file");
		
		if(part.getSize() > 0) {
			String contentDisposition = part.getHeader("content-disposition");
			uploadFileName = getUploadFileName(contentDisposition);
			
			Date today = new Date();
			SimpleDateFormat cal = new SimpleDateFormat("yyyyMMddHHmmss");
			String signdate = cal.format(today);
			
			String filepath = "C:\\JSP\\UlsanLibrary2\\WebContent\\upload\\";
			uploadFileName = signdate + "_" + uploadFileName;
			String orgImg = filepath + uploadFileName;
			thum_file = "thum_" + uploadFileName;
			String thumbImg = filepath + thum_file;
			
			part.write(uploadFileName);
			
			int thumbWidth = 60;
			int thumbHeight = 60;
			
			try {
				Image thumbnail = JimiUtils.getThumbnail(orgImg, thumbWidth, thumbHeight, Jimi.IN_MEMORY);// 썸네일 설정
				Jimi.putImage(thumbnail, thumbImg);// 썸네일 생성
			}catch(Exception e) {
				e.printStackTrace();
			}
			
		}
		
		g.setContent(request.getParameter("content"));
		g.setISBN(request.getParameter("ISBN"));
		g.setLib_name(request.getParameter("lib_name"));
		g.setPub_date(request.getParameter("pub_date"));
		g.setTitle(request.getParameter("title"));
		g.setUid(uid);
		g.setWriter(request.getParameter("writer"));
		g.setDaechul(request.getParameter("daechul"));
		
		if(uploadFileName != null && !uploadFileName.equals("")) {
			g.setFile(uploadFileName);
		}else {
			g.setFile("20201208092834_image.png");
		}
		
		if(thum_file != null && !thum_file.equals("")) {
			g.setThum_file(thum_file);
		}else {
			g.setThum_file(request.getParameter("thum_fileo"));
		}
		
		gdao.update_g(g);
		
		response.sendRedirect("view_g.do?uid="+uid+"&lib_name="+URLEncoder.encode(g.getLib_name()));
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
