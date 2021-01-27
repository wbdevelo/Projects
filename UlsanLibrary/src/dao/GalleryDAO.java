package dao;

import java.sql.*;
import java.util.ArrayList;

import model.Gallery;
import model.QnA;

public class GalleryDAO {

	DB db = new DB();
	
	PreparedStatement pstmt;
	Statement stmt;
	ResultSet rs;
	
	public void insert_gallery(Gallery g){
		db.getCon();
		
		try {
			String sql = "insert into gallery (title, content, file, thum_file, writer, pub_date, ISBN, lib_name, daechul) values (?,?,?,?,?,?,?,?,?)";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, g.getTitle());
			pstmt.setString(2, g.getContent());
			pstmt.setString(3, g.getFile());
			pstmt.setString(4, g.getThum_file());
			pstmt.setString(5, g.getWriter());
			pstmt.setString(6, g.getPub_date());
			pstmt.setString(7, g.getISBN());
			pstmt.setString(8, g.getLib_name());
			pstmt.setString(9, g.getDaechul());
			pstmt.executeUpdate();
			
			pstmt.close();
			db.conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<Gallery> select_gallery(int startRow, int endRow, String jogeon) {
		db.getCon();
		
		ArrayList<Gallery> v = new ArrayList<>();
		
		try {
			
			String sql = "select * from gallery where (1) "+jogeon+" group by title, lib_name limit ?,?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {

				Gallery g = new Gallery();
				
				g.setContent(rs.getString("content"));
				g.setFile(rs.getString("file"));
				g.setISBN(rs.getString("ISBN"));
				g.setLib_name(rs.getString("lib_name"));
				g.setPub_date(rs.getString("pub_date"));
				g.setThum_file(rs.getString("thum_file"));
				g.setTitle(rs.getString("title"));
				g.setUid(rs.getInt("uid"));
				g.setWriter(rs.getString("writer"));
				g.setDaechul(rs.getString("daechul"));
				
				v.add(g);
				
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
			
			String sql = "select count(*) from gallery";
			
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
	
	public ArrayList<Gallery> view_gallery(int uid, String title, String lib_name, String id) {
		db.getCon();
		ArrayList<Gallery> v = new ArrayList<Gallery>();
		
		try {
			
			String sql = "select * from gallery where uid=? or (title=? and lib_name=?) order by uid asc";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setInt(1, uid);
			pstmt.setString(2, title);
			pstmt.setString(3, lib_name);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Gallery g = new Gallery();
				
				g.setContent(rs.getString("content"));
				g.setFile(rs.getString("file"));
				g.setISBN(rs.getString("ISBN"));
				g.setLib_name(rs.getString("lib_name"));
				g.setPub_date(rs.getString("pub_date"));
				g.setThum_file(rs.getString("thum_file"));
				g.setTitle(rs.getString("title"));
				g.setUid(rs.getInt("uid"));
				g.setWriter(rs.getString("writer"));
				g.setDaechul(rs.getString("daechul"));
				
				String sql_r = "select count(*) from reservation where book_uid=? and state=?";
				
				PreparedStatement pstmt_r = db.conn.prepareStatement(sql_r);
				pstmt_r.setInt(1, g.getUid());
				pstmt_r.setString(2, "rDaeki");
				
				ResultSet rs_r = pstmt_r.executeQuery();
				if(rs_r.next()) {
					g.setReserv(rs_r.getString(1));
				}
				
				String sql_rn = "select rowNum from reservation where book_uid=? and state=? and id=? and lib_name=?";
				
				PreparedStatement pstmt_rn = db.conn.prepareStatement(sql_rn);
				pstmt_rn.setInt(1, g.getUid());
				pstmt_rn.setString(2, "rDaeki");
				pstmt_rn.setString(3, id);
				pstmt_rn.setString(4, lib_name);
				
				ResultSet rs_rn = pstmt_rn.executeQuery();
				if(rs_rn.next()) {
					g.setRowNum(rs_rn.getInt(1));
				}
				
				v.add(g);
				
				rs_r.close();
			}
			
			rs.close();
			pstmt.close();
			db.conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return v;
	}
	
	public void delete_g(int uid) {
		db.getCon();
		
		try {
			
			String sql = "delete from gallery where uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setInt(1, uid);
			pstmt.executeUpdate();
			
			pstmt.close();
			db.conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void update_g(Gallery g) {
		db.getCon();
		
		try {
			
			String sql = "update gallery set title=?, content=?, writer=?, ISBN=?, lib_name=?, pub_date=?, file=?, thum_file=?, daechul=? where uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, g.getTitle());
			pstmt.setString(2, g.getContent());
			pstmt.setString(3, g.getWriter());
			pstmt.setString(4, g.getISBN());
			pstmt.setString(5, g.getLib_name());
			pstmt.setString(6, g.getPub_date());
			pstmt.setString(7, g.getFile());
			pstmt.setString(8, g.getThum_file());
			pstmt.setString(9, g.getDaechul());
			pstmt.setInt(10, g.getUid());
			pstmt.executeUpdate();
			
			pstmt.close();
			db.conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<Gallery> my_g(String lib_name) {
		db.getCon();
		ArrayList<Gallery> v = new ArrayList<>();
		
		try {
			
			String sql = "select * from gallery where lib_name=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, lib_name);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Gallery g = new Gallery();
				
				g.setContent(rs.getString("content"));
				g.setDaechul(rs.getString("daechul"));
				g.setFile(rs.getString("file"));
				g.setISBN(rs.getString("ISBN"));
				g.setLib_name(rs.getString("lib_name"));
				g.setPub_date(rs.getString("pub_date"));
				g.setThum_file(rs.getString("thum_file"));
				g.setTitle(rs.getString("title"));
				g.setUid(rs.getInt("uid"));
				g.setWriter(rs.getString("writer"));
				
				v.add(g);
				
			}
			
			rs.close();
			pstmt.close();
			db.conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return v;
	}
	
	public ArrayList<Gallery> search_gallery(String search, int startRow, int endRow, String jogeon) {
		db.getCon();
		ArrayList<Gallery> v = new ArrayList<Gallery>();
		
		try {
			
			String sql = "select * from gallery where (title like '%" + search + "%' or writer like '%" + search + "%' or lib_name like '%" + search + "%' or ISBN like '%" + search + "%' or content like '%" + search + "%') "+jogeon+" group by title limit " + startRow + ", " + endRow + "";
			
			stmt = db.conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				Gallery g = new Gallery();
				
				g.setContent(rs.getString("content"));
				g.setDaechul(rs.getString("daechul"));
				g.setFile(rs.getString("file"));
				g.setISBN(rs.getString("ISBN"));
				g.setLib_name(rs.getString("lib_name"));
				g.setPub_date(rs.getString("pub_date"));
				g.setThum_file(rs.getString("thum_file"));
				g.setTitle(rs.getString("title"));
				g.setUid(rs.getInt("uid"));
				g.setWriter(rs.getString("writer"));
				
				v.add(g);
			}
			
			rs.close();
			pstmt.close();
			db.conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return v;
	}
	
	public Gallery modify_gallery(int uid) {
		db.getCon();
		Gallery g = new Gallery();
		
		try {
			
			String sql = "select * from gallery where uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setInt(1, uid);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				g.setContent(rs.getString("content"));
				g.setDaechul(rs.getString("daechul"));
				g.setFile(rs.getString("file"));
				g.setISBN(rs.getString("ISBN"));
				g.setLib_name(rs.getString("lib_name"));
				g.setPub_date(rs.getString("pub_date"));
				g.setThum_file(rs.getString("thum_file"));
				g.setTitle(rs.getString("title"));
				g.setUid(rs.getInt("uid"));
				g.setWriter(rs.getString("writer"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return g;
	}
	
	public int search_count(String search, String jogeon) {
		db.getCon();
		int count = 0;
		
		try {
			
			String sql = "select count(*) from gallery where (title like '%" + search + "%' or writer like '%" + search + "%' or ISBN like '%" + search + "%' or lib_name like '%" + search + "%' or content like '%" + search + "%')" + jogeon + "";
			
			stmt = db.conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}
}
