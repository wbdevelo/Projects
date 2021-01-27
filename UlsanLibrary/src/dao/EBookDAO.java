package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.Cookie;

import model.EBook;

public class EBookDAO {

	DB db = new DB();
	
	PreparedStatement pstmt;
	Statement stmt;
	ResultSet rs;
	
	public void insert_ebook(EBook eb) { 
		db.getCon();
		
		try {
			String sql = "insert into ebook (title,content,writer,pub_date,device_pc,device_mobile,device_tablet,file,thum_file,bookfile,writtenbyid,writtenbyname,price,category,point) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			
			pstmt = db.conn.prepareStatement(sql);
			
			pstmt.setString(1, eb.getTitle());
			pstmt.setString(2, eb.getContent());
			pstmt.setString(3, eb.getWriter());
			pstmt.setString(4, eb.getPub_date());
			pstmt.setString(5, eb.getDevice_pc());
			pstmt.setString(6, eb.getDevice_mobile());
			pstmt.setString(7, eb.getDevice_tablet());
			pstmt.setString(8, eb.getFile());
			pstmt.setString(9, eb.getThum_file());
			pstmt.setString(10, eb.getBook_file());
			pstmt.setString(11, eb.getWrittenbyid());
			pstmt.setString(12, eb.getWrittenbyname());
			pstmt.setInt(13, eb.getPrice());
			pstmt.setString(14, eb.getCategory());
			pstmt.setInt(15, (int)(eb.getPrice()*0.05));
			
			pstmt.executeUpdate();
			
			pstmt.close();
			db.conn.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	public ArrayList<EBook> select_ebook(int startRow, int endRow, String jogeon) {
		db.getCon();
		
		ArrayList<EBook> v = new ArrayList<>();
		
		try {
			
			String sql = "select * from ebook"+jogeon+" limit ?,?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {

				EBook e = new EBook();
				
				e.setTitle(rs.getString("title"));
				e.setContent(rs.getString("content"));
				e.setWriter(rs.getString("writer"));
				e.setUid(rs.getInt("uid"));
				e.setPub_date(rs.getString("pub_date"));
				e.setDevice_pc(rs.getString("device_pc"));
				e.setDevice_mobile(rs.getString("device_mobile"));
				e.setDevice_tablet(rs.getString("device_tablet"));
				e.setFile(rs.getString("file"));
				e.setThum_file(rs.getString("thum_file"));
				e.setBook_file(rs.getString("bookfile"));
				e.setWrittenbyid(rs.getString("writtenbyid"));
				e.setPrice(rs.getInt("price"));
				e.setPoint(rs.getInt("point"));
				
				v.add(e);
				
			}
			
			rs.close();
			pstmt.close();
			db.conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return v;
	}
	
	
	public int getAllCount() {
		db.getCon();
		
		int count = 0;
		
		try {
			
			String sql = "select count(*) from ebook";
			
			pstmt = db.conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
			rs.close();
			pstmt.close();
			db.conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	
	public EBook view_ebook(int uid) {
		db.getCon();
		EBook e = new EBook();
		
		try {
			String sql = "select * from ebook where uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setInt(1, uid);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				e.setTitle(rs.getString("title"));
				e.setContent(rs.getString("content"));
				e.setWriter(rs.getString("writer"));
				e.setUid(rs.getInt("uid"));
				e.setPub_date(rs.getString("pub_date"));
				e.setDevice_pc(rs.getString("device_pc"));
				e.setDevice_mobile(rs.getString("device_mobile"));
				e.setDevice_tablet(rs.getString("device_tablet"));
				e.setFile(rs.getString("file"));
				e.setThum_file(rs.getString("thum_file"));
				e.setBook_file(rs.getString("bookfile"));
				e.setWrittenbyid(rs.getString("writtenbyid"));
				e.setWrittenbyname(rs.getString("writtenbyname"));
				e.setPrice(rs.getInt("price"));
				e.setPoint(rs.getInt("point"));
			}
			rs.close();
			pstmt.close();
			db.conn.close();
			
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		return e;
	}
	
	public ArrayList<EBook> view_otherbook(String writer) {
		db.getCon();
		ArrayList<EBook> v = new ArrayList<>();
		try {
			String sql = "select * from ebook where writer=? limit 0, 4";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, writer);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				EBook eb = new EBook();
				eb.setUid(rs.getInt("uid"));
				eb.setThum_file(rs.getString("thum_file"));
				eb.setTitle(rs.getString("title"));
				
				v.add(eb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return v;
	}
	
	
	public ArrayList<EBook> get_writerbook(String writer) {
		db.getCon();
		
		ArrayList<EBook> v = new ArrayList<>();
		
		try {
			String sql = "select * from ebook where writer = ? ";
			
			pstmt = db.conn.prepareStatement(sql);
			
			pstmt.setString(1, writer);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				EBook eb = new EBook();
				
				eb.setThum_file(rs.getString("thum_file"));
				eb.setTitle(rs.getString("title"));
				eb.setWriter(rs.getString("writer"));
				eb.setPub_date(rs.getString("pub_date"));
				eb.setPrice(rs.getInt("price"));
				eb.setContent(rs.getString("content"));
				eb.setUid(rs.getInt("uid"));
				
				v.add(eb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return v;
	}
	

	public void update_E(EBook eb) {
		db.getCon();
		
		try {
			
			String sql = "update ebook set title=?, content=?, writer=?, pub_date=?, device_pc=?, device_mobile=?, device_tablet=?, file=?, thum_file=?, bookfile=?, price=?, writtenbyid=?, writtenbyname=?, point=?  where uid=? ";
			
			pstmt = db.conn.prepareStatement(sql);
			
			pstmt.setString(1, eb.getTitle());
			pstmt.setString(2, eb.getContent());
			pstmt.setString(3, eb.getWriter());
			pstmt.setString(5, eb.getPub_date());
			pstmt.setString(6, eb.getDevice_pc());
			pstmt.setString(7, eb.getDevice_mobile());
			pstmt.setString(8, eb.getDevice_tablet());
			pstmt.setString(9, eb.getFile());
			pstmt.setString(10, eb.getThum_file());
			pstmt.setString(11, eb.getBook_file());
			pstmt.setInt(12, eb.getPrice());
			pstmt.setString(13, eb.getWrittenbyid());
			pstmt.setString(14, eb.getWrittenbyname());
			pstmt.setInt(15, (int)(eb.getPrice()*0.05));
			pstmt.setInt(16, eb.getUid());
			pstmt.executeUpdate();
			
			pstmt.close();
			db.conn.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public ArrayList<EBook> search_ebook(String search, int startRow, int endRow, String jogeon) {
		db.getCon();
		
		ArrayList<EBook> v = new ArrayList<EBook>();
		
		try {
			
			String sql = "select * from ebook where title like '%" + search + "%' or writer like '%" + search + "%'  or ISBN like '%" + search + "%' or content like '%" + search + "%'"+jogeon+" limit " + startRow + ", " + endRow + "";
			
			stmt = db.conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				EBook e = new EBook();
				
				e.setTitle(rs.getString("title"));
				e.setContent(rs.getString("content"));
				e.setWriter(rs.getString("writer"));
				e.setUid(rs.getInt("uid"));
				e.setPub_date(rs.getString("pub_date"));
				e.setDevice_pc(rs.getString("device_pc"));
				e.setDevice_mobile(rs.getString("device_mobile"));
				e.setDevice_tablet(rs.getString("device_tablet"));
				e.setFile(rs.getString("file"));
				e.setThum_file(rs.getString("thum_file"));
				e.setBook_file(rs.getString("bookfile"));
				e.setPrice(rs.getInt("price"));
				e.setPoint(rs.getInt("point"));
				
				v.add(e);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return v;
	}
	
	//e-book정보 삭제
	public void delete_e(int uid) {
		db.getCon();
		
		try {
			String sql = "delete from ebook where uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			
			pstmt.setInt(1, uid);
			
			pstmt.executeUpdate();
			
			pstmt.close();
			db.conn.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	
	public ArrayList<EBook> getBook_writer(String writer){
		db.getCon();
		ArrayList<EBook> ev = new ArrayList<EBook>();
		
		try {
			
			String sql = "select * from ebook where writer=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, writer);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				EBook e = new EBook();
				
				e.setBook_file(rs.getString("bookfile"));
				e.setContent(rs.getString("content"));
				e.setDevice_mobile(rs.getString("device_mobile"));
				e.setDevice_pc(rs.getString("device_pc"));
				e.setDevice_tablet(rs.getString("device_tablet"));
				e.setFile(rs.getString("file"));
				e.setPoint(rs.getInt("point"));
				e.setPrice(rs.getInt("price"));
				e.setPub_date(rs.getString("pub_date"));
				e.setThum_file(rs.getString("thum_file"));
				e.setTitle(rs.getString("title"));
				e.setUid(rs.getInt("uid"));
				e.setWriter(rs.getString("writer"));
				e.setWrittenbyid(rs.getString("writtenbyid"));
				e.setWrittenbyname(rs.getString("writtenbyname"));
				
				ev.add(e);
				
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ev;
	}
	
	public ArrayList<EBook> get_best() {
		db.getCon();
		ArrayList<EBook> ev = new ArrayList<EBook>();
		
		try {
			
			String sql = "select * from ebook order by sell desc limit 0, 3";
			
			pstmt = db.conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				EBook e = new EBook();
				
				e.setBook_file(rs.getString("bookfile"));
				e.setContent(rs.getString("content"));
				e.setDevice_mobile("device_mobile");
				e.setDevice_pc(rs.getString("device_pc"));
				e.setDevice_tablet(rs.getString("device_tablet"));
				e.setFile(rs.getString("file"));
				e.setPrice(rs.getInt("price"));
				e.setPub_date(rs.getString("pub_date"));
				e.setThum_file(rs.getString("thum_file"));
				e.setTitle(rs.getString("title"));
				e.setUid(rs.getInt("uid"));
				e.setWriter(rs.getString("writer"));
				e.setWrittenbyid(rs.getString("writtenbyid"));
				e.setWrittenbyname(rs.getString("writtenbyname"));
				
				ev.add(e);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ev;
	}
	
	public ArrayList<EBook> searchNcategory(String search, int startRow, int endRow, String category, String jogeon) {
		db.getCon();
		
		ArrayList<EBook> v = new ArrayList<EBook>();
		
		try {
			
			String sql = "select * from ebook where category='" + category + "' and title like '%" + search + "%' or writer like '%" + search + "%'  or ISBN like '%" + search + "%' or content like '%" + search + "%'"+jogeon+" limit " + startRow + ", " + endRow + "";
			
			stmt = db.conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				EBook e = new EBook();
				
				e.setTitle(rs.getString("title"));
				e.setContent(rs.getString("content"));
				e.setWriter(rs.getString("writer"));
				e.setUid(rs.getInt("uid"));
				e.setPub_date(rs.getString("pub_date"));
				e.setDevice_pc(rs.getString("device_pc"));
				e.setDevice_mobile(rs.getString("device_mobile"));
				e.setDevice_tablet(rs.getString("device_tablet"));
				e.setFile(rs.getString("file"));
				e.setThum_file(rs.getString("thum_file"));
				e.setBook_file(rs.getString("bookfile"));
				e.setPrice(rs.getInt("price"));
				e.setPoint(rs.getInt("point"));
				
				v.add(e);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return v;
	}
	
	public ArrayList<EBook> category_ebook(int startRow, int endRow, String category, String jogeon) {
		db.getCon();
		
		ArrayList<EBook> v = new ArrayList<>();
		
		try {
			
			String sql = "select * from ebook where category=?"+jogeon+" limit ?,?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, category);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {

				EBook e = new EBook();
				
				e.setTitle(rs.getString("title"));
				e.setContent(rs.getString("content"));
				e.setWriter(rs.getString("writer"));
				e.setUid(rs.getInt("uid"));
				e.setPub_date(rs.getString("pub_date"));
				e.setDevice_pc(rs.getString("device_pc"));
				e.setDevice_mobile(rs.getString("device_mobile"));
				e.setDevice_tablet(rs.getString("device_tablet"));
				e.setFile(rs.getString("file"));
				e.setThum_file(rs.getString("thum_file"));
				e.setBook_file(rs.getString("bookfile"));
				e.setPrice(rs.getInt("price"));
				e.setPoint(rs.getInt("point"));
				
				v.add(e);
				
			}
			
			rs.close();
			pstmt.close();
			db.conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return v;
	}

	public ArrayList<EBook> adminSearch_ebook(String search, int startRow, int endRow) {
		db.getCon();
		
		ArrayList<EBook> v = new ArrayList<EBook>();
		
		try {
			
			String sql = "select * from ebook where title like '%" + search + "%' or writer like '%" + search + "%'  or ISBN like '%" + search + "%' or content like '%" + search + "%' limit " + startRow + ", " + endRow + "";
			
			stmt = db.conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				EBook e = new EBook();
				
				e.setTitle(rs.getString("title"));
				e.setContent(rs.getString("content"));
				e.setWriter(rs.getString("writer"));
				e.setUid(rs.getInt("uid"));
				e.setPub_date(rs.getString("pub_date"));
				e.setDevice_pc(rs.getString("device_pc"));
				e.setDevice_mobile(rs.getString("device_mobile"));
				e.setDevice_tablet(rs.getString("device_tablet"));
				e.setFile(rs.getString("file"));
				e.setThum_file(rs.getString("thum_file"));
				e.setBook_file(rs.getString("bookfile"));
				e.setPrice(rs.getInt("price"));
				e.setPoint(rs.getInt("point"));
				
				v.add(e);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return v;
	}
	

	public ArrayList<EBook> adminSelect_ebook(int startRow, int endRow) {
		db.getCon();
		
		ArrayList<EBook> v = new ArrayList<>();
		
		try {
			
			String sql = "select * from ebook limit ?,?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {

				EBook e = new EBook();
				
				e.setTitle(rs.getString("title"));
				e.setContent(rs.getString("content"));
				e.setWriter(rs.getString("writer"));
				e.setUid(rs.getInt("uid"));
				e.setPub_date(rs.getString("pub_date"));
				e.setDevice_pc(rs.getString("device_pc"));
				e.setDevice_mobile(rs.getString("device_mobile"));
				e.setDevice_tablet(rs.getString("device_tablet"));
				e.setFile(rs.getString("file"));
				e.setThum_file(rs.getString("thum_file"));
				e.setBook_file(rs.getString("bookfile"));
				e.setWrittenbyid(rs.getString("writtenbyid"));
				e.setPrice(rs.getInt("price"));
				e.setPoint(rs.getInt("point"));
				
				v.add(e);
				
			}
			
			rs.close();
			pstmt.close();
			db.conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return v;
	}
	
	public EBook get_recent(String euid) {
		db.getCon();
		EBook eb = new EBook();
		
		try {
			
			String sql = "select * from ebook where uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, euid);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				eb.setTitle(rs.getString("title"));
				eb.setThum_file(rs.getString("thum_file"));
				eb.setUid(rs.getInt("uid"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return eb;
	}
	

	public ArrayList<EBook> get_best5() {
		db.getCon();
		ArrayList<EBook> ev = new ArrayList<EBook>();
		
		try {
			
			String sql = "select * from ebook order by sell desc limit 0, 5";
			
			pstmt = db.conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				EBook e = new EBook();
				
				e.setBook_file(rs.getString("bookfile"));
				e.setContent(rs.getString("content"));
				e.setDevice_mobile("device_mobile");
				e.setDevice_pc(rs.getString("device_pc"));
				e.setDevice_tablet(rs.getString("device_tablet"));
				e.setFile(rs.getString("file"));
				e.setPrice(rs.getInt("price"));
				e.setPub_date(rs.getString("pub_date"));
				e.setThum_file(rs.getString("thum_file"));
				e.setTitle(rs.getString("title"));
				e.setUid(rs.getInt("uid"));
				e.setWriter(rs.getString("writer"));
				e.setWrittenbyid(rs.getString("writtenbyid"));
				e.setWrittenbyname(rs.getString("writtenbyname"));
				
				ev.add(e);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ev;
	}
}













