package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import model.Alarm;

public class AlarmDAO {
	DB db = new DB();
	
	PreparedStatement pstmt;
	Statement stmt;
	ResultSet rs;
	
	
	public void insert_alarm(Alarm a) {
		db.getCon();
		
		try {
			
			String sql = "insert into alarm (id, lib_name, book_uid, date, title) values (?,?,?,?,?)";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, a.getId());
			pstmt.setString(2, a.getLib_name());
			pstmt.setInt(3, a.getBook_uid());
			pstmt.setString(4, a.getDate());
			pstmt.setString(5, a.getTitle());
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<Alarm> select_alarm(String id) {
		db.getCon();
		ArrayList<Alarm> av = new ArrayList<Alarm>();
		
		try {
			
			String sql = "select * from alarm where id=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Alarm a = new Alarm();
				
				a.setBook_uid(rs.getInt("book_uid"));
				a.setDate(rs.getString("date"));
				a.setId(rs.getString("id"));
				a.setLib_name(rs.getString("lib_name"));
				a.setReadDate(rs.getString("readDate"));
				a.setReadNum(rs.getInt("readNum"));
				a.setUid(rs.getInt("uid"));
				a.setTitle(rs.getString("title"));
				
				av.add(a);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return av;
	}
	
	public void update_readNumDate(int uid, String readDate) {
		db.getCon();
		
		try {
			
			String sql = "update alarm set readNum=readNum+1, readDate=? where uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, readDate);
			pstmt.setInt(2, uid);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void update_readNum(int uid) {
		db.getCon();
		
		try {
			
			String sql = "update alarm set readNum=readNum+1 where uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setInt(1, uid);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public Alarm select_detail(int uid) {
		db.getCon();
		Alarm a = new Alarm();
		
		try {
			
			String sql = "select * from alarm where uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setInt(1, uid);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				
				a.setBook_uid(rs.getInt("book_uid"));
				a.setDate(rs.getString("date"));
				a.setId(rs.getString("id"));
				a.setLib_name(rs.getString("lib_name"));
				a.setReadDate(rs.getString("readDate"));
				a.setReadNum(rs.getInt("readNum"));
				a.setUid(rs.getInt("uid"));
				a.setTitle(rs.getString("title"));
			
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return a;
	}
	
	public Alarm select_uid(String id, String lib_name, int book_uid) {
		db.getCon();
		Alarm a = new Alarm();
		
		try {
			
			String sql = "select * from alarm where id=? and lib_name=? and book_uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, lib_name);
			pstmt.setInt(3, book_uid);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				a.setReadNum(rs.getInt("readNum"));
				a.setUid(rs.getInt("uid"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return a;
	}
	
	public int get_count(String id) {
		db.getCon();
		int count = 0;
		
		try {
			
			String sql = "select count(*) from alarm where id=? and readNum=0";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	public void update_state(String id, String lib_name, int book_uid) {
		db.getCon();
		
		try {
			
			String sql = "update alarm set state=? where id=? and lib_name=? and book_uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, "취소");
			pstmt.setString(2, id);
			pstmt.setString(3, lib_name);
			pstmt.setInt(4, book_uid);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void insert_hwackDate(int uid, String readDate) {
		db.getCon();
		
		try {
			
			String sql = "update alarm set hwack_date=? where uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, readDate);
			pstmt.setInt(2, uid);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<Alarm> select_LibAlarm(String lib_name) {
		db.getCon();
		ArrayList<Alarm> av = new ArrayList<Alarm>();
		
		try {
			
			String sql = "select * from alarm where lib_name=? and id=''";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, lib_name);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Alarm a = new Alarm();
				
				a.setDate(rs.getString("date").substring(0, 4)+"-"+rs.getString("date").substring(4, 6)+"-"+rs.getString("date").substring(6, 8));
				
				av.add(a);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return av;
	}
	
	public void update_LibReadNum(String lib_name) {
		db.getCon();
		
		try {
			
			String sql = "update alarm set readNum=1 where lib_name=? and id=''";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, lib_name);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int set_alarmCount(String lib_name) {
		db.getCon();
		int count = 0;
		
		try {
			
			String sql = "select count(*) from alarm where lib_name=? and id='' and readNum=0";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, lib_name);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	public void delete_LibAlarm(String lib_name) {
		db.getCon();
		
		try {
			
			String sql = "delete from alarm where lib_name=? and id=''";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, lib_name);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void delete_Alarm(String id) {
		db.getCon();
		
		try {
			
			String sql = "delete from alarm where id=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			pstmt.executeUpdate();
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int count_alarm(String id) {
		db.getCon();
		int count = 0;
		
		try {
			
			String sql = "select count(*) from alarm where id=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}
}
