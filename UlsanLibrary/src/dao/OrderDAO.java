package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import model.Order;

public class OrderDAO {
	DB db = new DB();
	PreparedStatement pstmt;
	Statement stmt;
	ResultSet rs;
	
	public void insert_info(Order o) {
		db.getCon();
		
		try {
			
			String sql = "insert into order2 (id, guest, product_num, bank, ipkumja, price, state, password) values(?,?,?,?,?,?,?,?)";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, o.getId());
			pstmt.setString(2, o.getGuest());
			pstmt.setString(3, o.getProduct_num());
			pstmt.setString(4, o.getBank());
			pstmt.setString(5, o.getIpkumja());
			pstmt.setString(6, o.getPrice());
			pstmt.setString(7, "△");
			pstmt.setString(8, o.getPassword());
			
			pstmt.executeUpdate();
			
			pstmt.close();
			db.conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<Order> get_daeki() {
		db.getCon();
		ArrayList<Order> v = new ArrayList<Order>();
		
		try {
			
			String sql = "select * from order2 where state=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, "△");
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Order o = new Order();
				
				o.setBank(rs.getString("bank"));
				o.setGuest(rs.getString("guest"));
				o.setId(rs.getString("id"));
				o.setIpkumja(rs.getString("ipkumja"));
				o.setPrice(rs.getString("price"));
				o.setProduct_num(rs.getString("product_num"));
				o.setUid(rs.getInt("uid"));
				o.setState(rs.getString("state"));
				
				v.add(o);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return v;
	}
	
	public void gumaeComplete(String product_num, String date) {
		db.getCon();
		
		try {
			
			String sql = "update order2 set state='o', date=? where product_num=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, date);
			pstmt.setString(2, product_num);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int check_mok(String guest, String pass) {
		db.getCon();
		int count = 0;
		
		try{
			
			String sql = "select count(*) from order2 where guest=? and password=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, guest);
			pstmt.setString(2, pass);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	public String get_pass(String guest) {
		db.getCon();
		String pass = "";
		
		try {
			
			String sql = "select password from order2 where guest=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, guest);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				pass = rs.getString("password");
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return pass;
	}
	
	public void cancelGumae(String ord_uid) {
		db.getCon();
		
		try {
			
			String sql = "update order2 set state=? where uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, "cdaeki");
			pstmt.setString(2, ord_uid);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<Order> get_gumae() {
		db.getCon();
		ArrayList<Order> ov = new ArrayList<Order>();
		
		try {
			
			String sql = "select * from order2 where state='o'";
			
			pstmt = db.conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Order o = new Order();
				
				o.setBank(rs.getString("bank"));
				o.setDate(rs.getString("date"));
				o.setGuest(rs.getString("guest"));
				o.setId(rs.getString("id"));
				o.setIpkumja(rs.getString("ipkumja"));
				o.setPassword(rs.getString("password"));
				o.setPrice(rs.getString("price"));
				o.setProduct_num(rs.getString("product_num"));
				o.setState(rs.getString("state"));
				o.setUid(rs.getInt("uid"));
				
				ov.add(o);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ov;
	}
	
	public ArrayList<Order> select_cancel() {
		db.getCon();
		ArrayList<Order> ov = new ArrayList<Order>();
		
		try {
			
			String sql = "select * from order2 where state='c'";
			
			stmt = db.conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				Order o = new Order();
				
				o.setBank(rs.getString("bank"));
				o.setDate(rs.getString("date"));
				o.setGuest(rs.getString("guest"));
				o.setId(rs.getString("id"));
				o.setIpkumja(rs.getString("ipkumja"));
				o.setPassword(rs.getString("password"));
				o.setPrice(rs.getString("price"));
				o.setProduct_num(rs.getString("product_num"));
				o.setState(rs.getString("state"));
				o.setUid(rs.getInt("uid"));
				
				ov.add(o);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ov;
	}
	
	public void cancel_complete(String product_num, String id) {
		db.getCon();
		
		try {
			
			String sql = "update order2 set state='c' where id=? and product_num=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, product_num);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int count_product(String product_num) {
		db.getCon();
		int count = 0;
		
		try {
			
			String sql = "select count(*) from order2 where product_num=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, product_num+",");
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	public String select_uid(Order o) {
		db.getCon();
		String uid = "";
		
		try {
			
			String sql = "select uid from order2 where product_num=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, o.getProduct_num());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				uid = rs.getString(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return uid;
	}
	
	public ArrayList<Order> get_mokrok(String jogeon) {
		db.getCon();
		ArrayList<Order> ov = new ArrayList<Order>();
		
		try {
			
			String sql = "select * from order2 where (1) " + jogeon;
			
			stmt = db.conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				Order o = new Order();
				
				o.setBank(rs.getString("bank"));
				o.setDate(rs.getString("date"));
				o.setGuest(rs.getString("guest"));
				o.setId(rs.getString("id"));
				o.setIpkumja(rs.getString("ipkumja"));
				o.setPassword(rs.getString("password"));
				o.setPrice(rs.getString("price"));
				o.setProduct_num(rs.getString("product_num"));
				o.setState(rs.getString("state"));
				o.setUid(rs.getInt("uid"));
				
				ov.add(o);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ov;
	}
	
	public void cancel_mu(String uid) {
		db.getCon();
		
		try {
			
			String sql = "update order2 set state='c' where uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<Order> get_cDaeki() {
		db.getCon();
		ArrayList<Order> ov = new ArrayList<Order>();
		
		try {
			
			String sql = "select * from order2 where state='cDaeki'";
			
			stmt = db.conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				Order o = new Order();
				
				o.setBank(rs.getString("bank"));
				o.setDate(rs.getString("date"));
				o.setGuest(rs.getString("guest"));
				o.setId(rs.getString("id"));
				o.setIpkumja(rs.getString("ipkumja"));
				o.setPassword(rs.getString("password"));
				o.setPrice(rs.getString("price"));
				o.setProduct_num(rs.getString("product_num"));
				o.setState(rs.getString("state"));
				o.setUid(rs.getInt("uid"));
				
				ov.add(o);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ov;
	}
	
	public ArrayList<Order> get_all() {
		db.getCon();
		ArrayList<Order> ov = new ArrayList<Order>();
		
		try {
			
			String sql = "select * from order2";
			
			pstmt = db.conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Order o = new Order();
				
				o.setBank(rs.getString("bank"));
				o.setDate(rs.getString("date"));
				o.setGuest(rs.getString("guest"));
				o.setId(rs.getString("id"));
				o.setIpkumja(rs.getString("ipkumja"));
				o.setPassword(rs.getString("password"));
				o.setPrice(rs.getString("price"));
				o.setProduct_num(rs.getString("product_num"));
				o.setState(rs.getString("state"));
				o.setUid(rs.getInt("uid"));
				
				ov.add(o);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ov;
	}
	public ArrayList<Order> get_gumae(String guest) {
		db.getCon();
		ArrayList<Order> ov = new ArrayList<Order>();
		
		try {
			
			String sql = "select * from order2 where guest=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, guest);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Order o = new Order();
				
				o.setBank(rs.getString("bank"));
				o.setDate(rs.getString("date"));
				o.setGuest(rs.getString("guest"));
				o.setId(rs.getString("id"));
				o.setIpkumja(rs.getString("ipkumja"));
				o.setPassword(rs.getString("password"));
				o.setPrice(rs.getString("price"));
				o.setProduct_num(rs.getString("product_num"));
				o.setState(rs.getString("state"));
				o.setUid(rs.getInt("uid"));
				
				ov.add(o);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ov;
	}
	
	public int get_count(String jogeon) {
		db.getCon();
		int count = 0;
		
		try {
			
			String sql = "select count(*) from order2 where (1)" + jogeon;
			
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
