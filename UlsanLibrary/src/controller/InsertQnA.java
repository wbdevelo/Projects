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

import dao.QnADAO;
import model.QnA;

@WebServlet("/qna/insertQ")
@MultipartConfig(
		fileSizeThreshold = 0,
		location = "C:\\JSP\\UlsanLibrary\\WebContent\\upload" //저장될 경로
)
public class InsertQnA extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public InsertQnA() {
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
		
		QnADAO qdao = new QnADAO();
		QnA qna = new QnA();
		
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
			
			String filepath = "C:\\JSP\\UlsanLibrary\\WebContent\\upload\\";
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
		
		int fid = qdao.select_fid();
		if(fid > 0) {
			qna.setFid(fid+1);
		}else {
			qna.setFid(1);
		}
		
		qna.setContent(request.getParameter("content"));
		qna.setFile(uploadFileName);
		qna.setThum_file(thum_file);
		qna.setTitle(request.getParameter("title"));
		qna.setId(request.getParameter("id"));
		qna.setName(request.getParameter("name"));
		
		qdao.insert_qna(qna);
		
		response.sendRedirect("SelectQ");
		
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
