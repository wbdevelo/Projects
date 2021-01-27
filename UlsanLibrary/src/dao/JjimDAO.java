package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import model.EBook;
import model.Jjim;

public class JjimDAO {
	
	DB db = new DB();
	
	PreparedStatement pstmt;
	Statement stmt;
	ResultSet rs;
	
	public int checkId(String id) {
		db.getCon();
		int count = 0;
		
		try {
			
			String sql = "select count(*) from jjim where id=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
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
	
	public void insert_all(String id) {
		db.getCon();
		
		try {
			
			String sql = "select * from ebook";
			
			pstmt = db.conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int title_uid = rs.getInt("uid");
				
				String sql_jjim = "insert into jjim (id, title_uid, jjim_v) values (?,?,?)";
				
				PreparedStatement pstmt_jjim = db.conn.prepareStatement(sql_jjim);
				pstmt_jjim.setString(1, id);
				pstmt_jjim.setInt(2, title_uid);
				pstmt_jjim.setString(3, "0");
				pstmt_jjim.executeUpdate();
				
				pstmt_jjim.close();
				
			}
			
			rs.close();
			pstmt.close();
			db.conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<Jjim> get_jjim(String id) {
		db.getCon();
		ArrayList<Jjim> jv = new ArrayList<Jjim>();
		
		try {
			
			String sql = "select * from jjim where id=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Jjim j = new Jjim();
				
				j.setId(id);
				j.setJjim_v(rs.getString("jjim_v"));
				j.setTitle_uid(rs.getInt("title_uid"));
				
				jv.add(j);
			}
			
			rs.close();
			pstmt.close();
			db.conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return jv;
	}
	
	
	public void update_jjim(Jjim j) {
		db.getCon();
		
		try {
			
			String sql = "update jjim set jjim_v=? where id=? and title_uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, j.getJjim_v());
			pstmt.setString(2, j.getId());
			pstmt.setInt(3, j.getTitle_uid());
			
			pstmt.executeUpdate();
			
			pstmt.close();
			db.conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void insert_new(String id, int startRow, int endRow) {
		db.getCon();
		
		try {
			
			String sql = "select * from ebook limit ?, ?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int title_uid = rs.getInt("uid");
				
				String sql_jjim = "insert into jjim (id, title_uid, jjim_v) values (?,?,?)";
				
				PreparedStatement pstmt_jjim = db.conn.prepareStatement(sql_jjim);
				pstmt_jjim.setString(1, id);
				pstmt_jjim.setInt(2, title_uid);
				pstmt_jjim.setString(3, "0");
				
				pstmt_jjim.executeUpdate();
				
				pstmt_jjim.close();
			}
			
			rs.close();
			pstmt.close();
			db.conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void delete_jjim(int uid) {
		db.getCon();
		
		try {
			
			String sql = "delete from jjim where title_uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setInt(1, uid);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<EBook> select_my(String id) {
		db.getCon();
		ArrayList<EBook> ev = new ArrayList<EBook>();
		
		try {
			
			String sql = "select * from jjim where id=? and jjim_v='1'";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Jjim j = new Jjim();
				
				j.setId(id);
				j.setJjim_v(rs.getString("jjim_v"));
				j.setTitle_uid(rs.getInt("title_uid"));
				
				EBook e = new EBook();
				String sql_e = "select * from ebook where uid=?";
				
				PreparedStatement pstmt_e = db.conn.prepareStatement(sql_e);
				pstmt_e.setInt(1, j.getTitle_uid());
				
				ResultSet rs_e = pstmt_e.executeQuery();
				if(rs_e.next()) {
					e.setTitle(rs_e.getString("title"));
					e.setPub_date(rs_e.getString("pub_date"));
					e.setFile(rs_e.getString("file"));
					e.setThum_file(rs_e.getString("thum_file"));
					e.setWriter(rs_e.getString("writer"));
					e.setPrice(rs_e.getInt("price"));
					e.setPoint(rs_e.getInt("point"));
					e.setUid(rs_e.getInt("uid"));
					
				}
				ev.add(e);
				
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ev;
	}
	
	public void update_all(String id) {
		db.getCon();
		
		try {
			
			String sql = "update jjim set jjim_v='0' where id=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
}
