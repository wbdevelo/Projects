package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import model.QnA;



public class QnADAO {

	DB db = new DB();
	
	PreparedStatement pstmt;
	Statement stmt;
	ResultSet rs;
	
	public void insert_qna(QnA qna) {
		db.getCon();
		
		try {
		
			String sql = "insert into qna (title, content, file, thum_file, id, name, fid) values (?,?,?,?,?,?,?)";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, qna.getTitle());
			pstmt.setString(2, qna.getContent());
			pstmt.setString(3, qna.getFile());
			pstmt.setString(4, qna.getThum_file());	
			pstmt.setString(5, qna.getId());
			pstmt.setString(6, qna.getName());
			pstmt.setInt(7, qna.getFid());
			pstmt.executeUpdate();
			
			pstmt.close();
			db.conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}	
	}
	
	public ArrayList<QnA> select_qna(int startRow, int endRow){
		db.getCon();
		
		ArrayList<QnA> v = new ArrayList<>();
		
		try {
			
			String sql = "select * from qna order by fid desc, thread asc limit ?, ?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				QnA qna = new QnA();
				
				qna.setContent(rs.getString("content"));
				qna.setFile(rs.getString("file"));
				qna.setThum_file(rs.getString("thum_file"));
				qna.setTitle(rs.getString("title"));
				qna.setUid(rs.getInt("uid"));
				qna.setFid(rs.getInt("fid"));
				qna.setThread(rs.getString("thread"));
				qna.setId(rs.getString("id"));
				qna.setName(rs.getString("name"));
				
				v.add(qna);
				
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
			
			String sql = "select count(*) from qna";
			
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
	
	public int select_fid() {
		db.getCon();
		
		int fid = 0;
		
		try {
			
			String sql = "select max(fid) from qna";
			
			pstmt = db.conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				fid = rs.getInt(1);
			}
			
			rs.close();
			pstmt.close();
			db.conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return fid;
	}
	
	public QnA view_qna(int uid) {
		db.getCon();
		QnA q = new QnA();
		
		try {
			
			String sql = "select * from qna where uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setInt(1, uid);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				
				q.setContent(rs.getString("content"));
				q.setFid(rs.getInt("fid"));
				q.setFile(rs.getString("file"));
				q.setId(rs.getString("id"));
				q.setName(rs.getString("name"));
				q.setThread(rs.getString("thread"));
				q.setThum_file(rs.getString("thum_file"));
				q.setTitle(rs.getString("title"));
				q.setUid(rs.getInt("uid"));
				
			}
			
			rs.close();
			pstmt.close();
			db.conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return q;
	}
	
	public String select_thread(String fid, String thread) {
		db.getCon();
		
		String o_thread = "";
		String r_thread = "";
		String head_thread = "";
		String new_thread = "";
		char thread_foot = 'A';
		int fid1 = Integer.parseInt(fid);
		
		try {
			
			String sql = "select thread, right(thread, 1) from qna where fid=? and length(thread)=? and locate(?, thread)=1 order by thread desc limit 1";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setInt(1, fid1);
			pstmt.setInt(2, thread.length() + 1);
			pstmt.setString(3, thread);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				o_thread = rs.getString("thread");
				r_thread = rs.getString("right(thread, 1)");
				thread_foot = (char)(r_thread.charAt(0) + 1);
			}
			
			if(o_thread != null && !o_thread.equals("")) {
				head_thread = o_thread.substring(0, o_thread.length()-1);
				new_thread = head_thread + thread_foot;
			}else {
				new_thread = thread + thread_foot;
			}
			
			rs.close();
			pstmt.close();
			db.conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		System.out.println("===========new_thread============" + new_thread);
		return new_thread;
	}
	
	public void answer_qna(QnA q) {
		db.getCon();
		
		try {
			
			String sql = "insert into qna (name, id, title, content, file, fid, thread) values (?,?,?,?,?,?,?)";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, q.getName());
			pstmt.setString(2, q.getId());
			pstmt.setString(3, q.getTitle());
			pstmt.setString(4, q.getContent());
			pstmt.setString(5, q.getFile());
			pstmt.setInt(6, q.getFid());
			pstmt.setString(7, q.getThread());
			pstmt.executeUpdate();
			
			pstmt.close();
			db.conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void delete_qna(int uid) {
		db.getCon();
		
		try {
			
			String sql = "delete from qna where uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setInt(1, uid);
			pstmt.executeUpdate();
			
			pstmt.close();
			db.conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void modify_qna(String title, String content, String file, int uid) {
		db.getCon();
		
		try {
			
			String sql = "update qna set title=?, content=?, file=? where uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setString(3, file);
			pstmt.setInt(4, uid);
			
			pstmt.executeUpdate();
			
			pstmt.close();
			db.conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int check_thread(int fid, String thread) {
		db.getCon();
		
		int count = 0;
		
		try {
			
			String sql = "select count(*) from qna where fid=? and length(thread)=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setInt(1, fid);
			pstmt.setInt(2, thread.length() + 1);
			
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
	
	public ArrayList<QnA> my_q(String id) {
		db.getCon();
		ArrayList<QnA> v = new ArrayList<QnA>();
		
		int fid = 0;
		
		try {
			
			String sql = "select fid from qna where id=? group by fid";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				fid = rs.getInt("fid");
				
				String sql_fid = "select * from qna where fid=? order by fid desc, thread asc";
				
				PreparedStatement pstmt_fid = db.conn.prepareStatement(sql_fid);
				pstmt_fid.setInt(1, fid);
				
				ResultSet rs_fid = pstmt_fid.executeQuery();
				while(rs_fid.next()) {
					QnA q = new QnA();
					
					q.setContent(rs_fid.getString("content"));
					q.setFile(rs_fid.getString("file"));
					q.setId(rs_fid.getString("id"));
					q.setName(rs_fid.getString("name"));
					q.setThread(rs_fid.getString("thread"));
					q.setThum_file(rs_fid.getString("thum_file"));
					q.setTitle(rs_fid.getString("title"));
					q.setUid(rs_fid.getInt("uid"));
					
					v.add(q);
				}
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return v;
	}
	
	public int getNum() {
		db.getCon();
		int number = 0;
		
		try {
			
			String sql = "select count(*) from qna where length(thread)=1";
			
			pstmt = db.conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				number = rs.getInt(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return number;
	}
}
