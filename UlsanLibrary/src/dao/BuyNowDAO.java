package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import model.BuyNow;
import model.Cart;

public class BuyNowDAO {
	DB db = new DB();
	PreparedStatement pstmt;
	Statement stmt;
	ResultSet rs;
	
	public void insert_buynow(BuyNow bn) {
		db.getCon();
		
		try {
			String sql = "insert into buynow (id, title, file, purchase, guest, price, product_num, thum_file, bookfile, point, whereis) values (?,?,?,?,?,?,?,?,?,?,?)";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, bn.getId());
			pstmt.setString(2, bn.getTitle());
			pstmt.setString(3, bn.getFile());
			pstmt.setString(4, bn.getPurchase());
			pstmt.setString(5, bn.getGuest());
			pstmt.setInt(6, bn.getPrice());
			pstmt.setString(7, bn.getProduct_num());
			pstmt.setString(8, bn.getThum_file());
			pstmt.setString(9, bn.getBookfile());
			pstmt.setInt(10, bn.getPoint());
			pstmt.setString(11, bn.getWhereis());
			
			pstmt.executeUpdate();

			
			pstmt.close();
			db.conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int buy_count(String jogeon) {
		db.getCon();
		int count = 0;
		
		try {
			
			String sql = "select count(*) from buynow where purchase='x' "+jogeon;
			
			stmt = db.conn.createStatement();
			
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				count = rs.getInt(1);
			}

			
			rs.close();
			stmt.close();
			db.conn.close();
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	public ArrayList<BuyNow> select_buy(String jogeon) {
		db.getCon();
		ArrayList<BuyNow> v = new ArrayList<>();
		
		try {
			
			String sql = "select * from buynow where purchase='x' "+jogeon;
			
			stmt = db.conn.createStatement();
			
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				BuyNow bn = new BuyNow();
				
				bn.setFile(rs.getString("file"));
				bn.setThum_file(rs.getString("thum_file"));
				bn.setId(rs.getString("id"));
				bn.setPurchase(rs.getString("purchase"));
				bn.setTitle(rs.getString("title"));
				bn.setGuest(rs.getString("guest"));
				bn.setPrice(rs.getInt("price"));
				bn.setProduct_num(rs.getString("product_num"));
				bn.setPoint(rs.getInt("point"));
				
				v.add(bn);
			}
			
			rs.close();
			stmt.close();
			db.conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return v;
	}
	
	public BuyNow num_buy(String num) {
		db.getCon();
		BuyNow bn = new BuyNow();
		
		try {
			
			String sql ="select * from buynow where product_num=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, num);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bn.setGuest(rs.getString("guest"));
				bn.setId(rs.getString("id"));
				bn.setFile(rs.getString("file"));
				bn.setPrice(rs.getInt("price"));
				bn.setProduct_num(rs.getString("product_num"));
				bn.setPurchase(rs.getString("purchase"));
				bn.setTitle(rs.getString("title"));
				bn.setThum_file(rs.getString("thum_file"));
				bn.setWhereis(rs.getString("whereis"));
			}
			
			rs.close();
			pstmt.close();
			db.conn.close();
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return bn;
	}
	
	
	public ArrayList<BuyNow> getproduct(String id) {
		db.getCon();
		ArrayList<BuyNow> b = new ArrayList<>();
		
		try {
			String sql = "select * from buynow where id=? and purchase='x'";
			
			pstmt = db.conn.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BuyNow bn = new BuyNow();
				
				bn.setPrice(rs.getInt("price"));
				bn.setThum_file(rs.getString("thum_file"));
				bn.setTitle(rs.getString("title"));
				bn.setPoint(rs.getInt("point"));
				
				b.add(bn);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return b;
	}
	
	
	public void daeki(String num, String bank, String ip) {
		db.getCon();
		
		try {
			
			String sql = "update buynow set purchase=?, bank=?, ipkumja=? where product_num=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, "△");
			pstmt.setString(2, bank);
			pstmt.setString(3, ip);
			pstmt.setString(4, num);
			
			pstmt.executeUpdate();

			
			pstmt.close();
			db.conn.close();
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public void insert_uid(String product_num, String ord_uid) {
		db.getCon();
		
		try {
			
			String sql = "update buynow set ord_uid=? where product_num=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, ord_uid);
			pstmt.setString(2, product_num);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public String uid_count(String ord_uid) {
		db.getCon();
		String count = "";
		
		try {
			
			String sql = "select count(*) from buynow where ord_uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, ord_uid);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getString(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	public void insert_uidCount(String count_uid, String ord_uid) {
		db.getCon();
		
		try {
			
			String sql = "update buynow set count_uid=? where ord_uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, count_uid);
			pstmt.setString(2, ord_uid);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<BuyNow> get_mokrok(String uid, String whereis) {
		db.getCon();
		ArrayList<BuyNow> b = new ArrayList<BuyNow>();
		
		try {
			
			String sql = "select * from buynow where ord_uid=? and whereis='bn'";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BuyNow bn = new BuyNow();
				
				bn.setBank(rs.getString("bank"));
				bn.setFile(rs.getString("file"));
				bn.setGuest(rs.getString("guest"));
				bn.setId(rs.getString("id"));
				bn.setIpkumja(rs.getString("ipkumja"));
				bn.setPrice(rs.getInt("price"));
				bn.setProduct_num(rs.getString("product_num"));
				bn.setThum_file(rs.getString("thum_file"));
				bn.setTitle(rs.getString("title"));
				bn.setDate(rs.getString("date"));
				bn.setPurchase(rs.getString("purchase"));
				bn.setOrd_uid(rs.getString("ord_uid"));
				bn.setCount_uid(rs.getString("count_uid"));
				bn.setWhereis(rs.getString("whereis"));
				
				b.add(bn);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return b;
	}

	public String click_num(String uid) {
		db.getCon();
		String count = "";
		
		try {
			
			String sql = "select max(click) from buynow where ord_uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getString(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}
}
