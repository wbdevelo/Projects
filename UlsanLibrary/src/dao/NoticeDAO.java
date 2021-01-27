package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import model.Nnotice;

public class NoticeDAO {
	
	DB db = new DB();
	
	PreparedStatement pstmt;
	Statement stmt;
	ResultSet rs;
	
	public void insert_notice(Nnotice notice) {
		db.getCon();
		
		try {
		
			String sql = "insert into notice (title, content, file, thum_file, id, name) values (?,?,?,?,?,?)";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, notice.getTitle());
			pstmt.setString(2, notice.getContent());
			pstmt.setString(3, notice.getFile());
			pstmt.setString(4, notice.getThum_file());	
			pstmt.setString(5, notice.getId());
			pstmt.setString(6, notice.getName());
			pstmt.executeUpdate();
			
			pstmt.close();
			db.conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}	
	}
	
	public ArrayList<Nnotice> select_notice(int startRow, int endRow){
		db.getCon();
		
		ArrayList<Nnotice> v = new ArrayList<>();
		
		try {
			
			String sql = "select * from notice limit ?, ?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Nnotice notice = new Nnotice();
				
				notice.setContent(rs.getString("content"));
				notice.setFile(rs.getString("file"));
				notice.setThum_file(rs.getString("thum_file"));
				notice.setTitle(rs.getString("title"));
				notice.setId(rs.getString("id"));
				notice.setName(rs.getString("name"));
				notice.setUid(rs.getInt("uid"));
				
				v.add(notice);
				
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
			
			String sql = "select count(*) from notice";
			
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
	
	
	public Nnotice view_n(int uid) {
		db.getCon();
		Nnotice n = new Nnotice();
		
		try {
			String sql = "select * from notice where uid=?";
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setInt(1, uid);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				n.setName(rs.getString("name"));
				n.setId(rs.getString("id"));
				n.setTitle(rs.getString("title"));
				n.setContent(rs.getString("content"));
				n.setFile(rs.getString("file"));
				n.setUid(rs.getInt("uid"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return n;
	}

	public void modify_notice(int uid , String name , String title, String content, String file) {
		db.getCon();
		
		try {
			String sql = "update notice set name=?, title=?, content=? , file=? where uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			
			pstmt.setString(1, name);
			pstmt.setString(2, title);
			pstmt.setString(3, content);
			pstmt.setString(4, file);
			pstmt.setInt(5, uid);
			pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public void delete_n(int uid) {
		db.getCon();
		
		try {
			String sql = "delete from notice where uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			
			pstmt.setInt(1, uid);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
}
























