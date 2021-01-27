package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.mysql.cj.x.protobuf.MysqlxPrepare.Prepare;

import model.Gallery;
import model.Reservation;
import model.RowNum;

public class ReservDAO {
	DB db = new DB();
	PreparedStatement pstmt;
	Statement stmt;
	ResultSet rs;
	
	public void insert_reserv(Gallery g, String id, String signdate) {
		db.getCon();
		
		try {
			
			String sql = "insert into reservation (book_uid, lib_name, id, ISBN, date, state, title, rowNum) values (?,?,?,?,?,?,?,?)";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setInt(1, g.getUid());
			pstmt.setString(2, g.getLib_name());
			pstmt.setString(3, id);
			pstmt.setString(4, g.getISBN());
			pstmt.setString(5, signdate);
			pstmt.setString(6, "rDaeki");
			pstmt.setString(7, g.getTitle());
			pstmt.setInt(8, 1);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int onePer_id(String id, int uid) {
		db.getCon();
		int count = 0;
		
		try {
			
			String sql = "select count(*) from reservation where id=? and book_uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, uid);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	public ArrayList<Reservation> Select_reserv(String lib_name) {
		db.getCon();
		ArrayList<Reservation> rv = new ArrayList<Reservation>();
		
		try {
			
			String sql = "select * from reservation where lib_name=? order by date asc";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, lib_name);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Reservation r = new Reservation();
				
				r.setBook_uid(rs.getInt("book_uid"));
				r.setDate(rs.getString("date"));
				r.setId(rs.getString("id"));
				r.setISBN(rs.getString("ISBN"));
				r.setLib_name(rs.getString("lib_name"));
				r.setState(rs.getString("state"));
				r.setTitle(rs.getString("title"));
				
				String sql_rd = "select * from alarm where id=? and lib_name=? and book_uid=?";
				
				PreparedStatement pstmt_rd = db.conn.prepareStatement(sql_rd);
				pstmt_rd.setString(1, r.getId());
				pstmt_rd.setString(2, lib_name);
				pstmt_rd.setInt(3, r.getBook_uid());
				
				ResultSet rs_rd = pstmt_rd.executeQuery();
				if(rs_rd.next()) {
					r.setReadDate(rs_rd.getString("readDate"));
					r.setAlarmDate(rs_rd.getString("date"));
				}
				
				rv.add(r);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return rv;
	}
	
	public void update_state(String lib_name, String id, int book_uid) {
		db.getCon();
		
		try {
			
			String sql = "update reservation set state=? where lib_name=? and id=? and book_uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, "alarm");
			pstmt.setString(2, lib_name);
			pstmt.setString(3, id);
			pstmt.setInt(4, book_uid);

			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void update_stateSincheong(String lib_name, String id, int book_uid) {
		db.getCon();
		
		try {
			
			String sql = "update reservation set state=? where lib_name=? and id=? and book_uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, "확정");
			pstmt.setString(2, lib_name);
			pstmt.setString(3, id);
			pstmt.setInt(4, book_uid);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public String get_state(String id, String lib_name, int book_uid) {
		db.getCon();
		String state = "";
		
		try {
			
			String sql = "select state from reservation where id=? and lib_name=? and book_uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, lib_name);
			pstmt.setInt(3, book_uid);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				state = rs.getString(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return state;
	}
	
	public int count_row(Gallery g) {
		db.getCon();
		int count = 0;
		
		try {
			
			String sql = "select count(*) from reservation where book_uid=? and lib_name=? and rowNum>0";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setInt(1, g.getUid());
			pstmt.setString(2, g.getLib_name());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	public void insert_reservRow(Gallery g, String id, String signdate, int rowNum) {
		db.getCon();
		
		try {
			
			String sql = "insert into reservation (book_uid, lib_name, id, ISBN, date, state, title, rowNum) values (?,?,?,?,?,?,?,?)";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setInt(1, g.getUid());
			pstmt.setString(2, g.getLib_name());
			pstmt.setString(3, id);
			pstmt.setString(4, g.getISBN());
			pstmt.setString(5, signdate);
			pstmt.setString(6, "rDaeki");
			pstmt.setString(7, g.getTitle());
			pstmt.setInt(8, rowNum+1);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void update_stateCancel(String id, String lib_name, int book_uid) {
		db.getCon();
		
		try {
			
			String sql = "update reservation set state=? where id=? and lib_name=? and book_uid=?";
			
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
	
	public void delete_reserv(String id, String lib_name, int book_uid) {
		db.getCon();
		
		try {
			
			String sql = "delete from reservation where id=? and lib_name=? and book_uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, lib_name);
			pstmt.setInt(3, book_uid);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void update_rowNum(String lib_name, int book_uid) {
		db.getCon();
		
		try {
			
			String sql = "update reservation set rowNum=rowNum-1 where lib_name=? and book_uid=? and rowNum>0";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, lib_name);
			pstmt.setInt(2, book_uid);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
