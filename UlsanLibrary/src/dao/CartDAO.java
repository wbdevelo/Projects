package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import model.Cart;

public class CartDAO {
	DB db = new DB();
	PreparedStatement pstmt;
	Statement stmt;
	ResultSet rs;
	
	public void insert_cart(Cart c, String gubun) {
		db.getCon();
		
		try {
			
			String sql = "insert into cart (id, title, file, purchase, guest, price, product_num, thum_file, bookfile, point, gubun) values (?,?,?,?,?,?,?,?,?,?,?)";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, c.getId());
			pstmt.setString(2, c.getTitle());
			pstmt.setString(3, c.getFile());
			pstmt.setString(4, c.getPurchase());
			pstmt.setString(5, c.getGuest());
			pstmt.setInt(6, c.getPrice());
			pstmt.setString(7, c.getProduct_num());
			pstmt.setString(8, c.getThum_file());
			pstmt.setString(9, c.getBookfile());
			pstmt.setInt(10, c.getPoint());
			pstmt.setString(11, gubun);
			
			pstmt.executeUpdate();

			
			pstmt.close();
			db.conn.close();
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	

	
	public ArrayList<Cart> select_cart(String jogeon) {
		db.getCon();
		ArrayList<Cart> v = new ArrayList<Cart>();
		
		try {
			
			String sql = "select * from cart where purchase='x' and gubun='' "+jogeon;
			
			stmt = db.conn.createStatement();
			
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				Cart c = new Cart();
				
				c.setFile(rs.getString("file"));
				c.setThum_file(rs.getString("thum_file"));
				c.setId(rs.getString("id"));
				c.setPurchase(rs.getString("purchase"));
				c.setTitle(rs.getString("title"));
				c.setGuest(rs.getString("guest"));
				c.setPrice(rs.getInt("price"));
				c.setProduct_num(rs.getString("product_num"));
				c.setPoint(rs.getInt("point"));
				
				v.add(c);
			}
			
			rs.close();
			stmt.close();
			db.conn.close();
			
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return v;
	}
	
	public void delete_cart(String num) {
		db.getCon();
		
		try {
			
			String sql = "delete from cart where product_num=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, num);
			
			pstmt.executeUpdate();

			
			pstmt.close();
			db.conn.close();
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public Cart num_cart(String num) {
		db.getCon();
		Cart c = new Cart();
		
		try {
			
			String sql ="select * from cart where product_num=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, num);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				c.setGuest(rs.getString("guest"));
				c.setId(rs.getString("id"));
				c.setFile(rs.getString("file"));
				c.setPrice(rs.getInt("price"));
				c.setProduct_num(rs.getString("product_num"));
				c.setPurchase(rs.getString("purchase"));
				c.setTitle(rs.getString("title"));
				c.setThum_file(rs.getString("thum_file"));
				c.setPoint(rs.getInt("point"));
			}
			
			rs.close();
			pstmt.close();
			db.conn.close();
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return c;
	}
	
	
	
	
	public int getAllcount(String id) {
		db.getCon();
		
		int count = 0;
		
		try {
			String sql = "select count(*) from cart where id=? and purchase='o' ";
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			pstmt.close();
			db.conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	
	public ArrayList<Cart> getAllproduct(String id) {
		db.getCon();
		ArrayList<Cart> v = new ArrayList<>();
		
		try {
			String sql= "select * from cart where id=? and purchase='o' ";
			
			pstmt = db.conn.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Cart c = new Cart();
				
				c.setBookfile(rs.getString("bookfile"));
				c.setFile(rs.getString("file"));
				c.setGuest(rs.getString("guest"));
				c.setId(rs.getString("id"));
				c.setPrice(rs.getInt("price"));
				c.setProduct_num(rs.getString("product_num"));
				c.setPurchase(rs.getString("purchase"));
				c.setThum_file(rs.getString("thum_file"));
				c.setTitle(rs.getString("title"));
				
				v.add(c);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		return v;
	}
	
	public int cart_count(String jogeon) {
		db.getCon();
		int count = 0;
		
		try {
			
			String sql = "select count(*) from cart where purchase='x' and gubun='' "+jogeon;
			
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
	
	public void daeki(String num, String bank, String ip) {
		db.getCon();
		
		try {
			
			String sql = "update cart set purchase=?, bank=?, ipkumja=? where product_num=?";
			
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
	
	public void guComp(String product_num, String date) {
		db.getCon();
		
		try {
			
			String sql = "update cart set purchase=?, date=? where product_num=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, "o");
			pstmt.setString(2, date);
			pstmt.setString(3, product_num);
			
			pstmt.executeUpdate();

			pstmt.close();
			db.conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<Cart> get_mokrok(String uid) {
		db.getCon();
		ArrayList<Cart> v = new ArrayList<Cart>();
		
		try {
			
			String sql = "select * from cart where ord_uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Cart c = new Cart();
				
				c.setBank(rs.getString("bank"));
				c.setFile(rs.getString("file"));
				c.setGuest(rs.getString("guest"));
				c.setId(rs.getString("id"));
				c.setIpkumja(rs.getString("ipkumja"));
				c.setPrice(rs.getInt("price"));
				c.setProduct_num(rs.getString("product_num"));
				c.setThum_file(rs.getString("thum_file"));
				c.setTitle(rs.getString("title"));
				c.setDate(rs.getString("date"));
				c.setPurchase(rs.getString("purchase"));
				c.setOrd_uid(rs.getString("ord_uid"));
				c.setCount_uid(rs.getString("count_uid"));
				
				v.add(c);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return v;
	}
	
	public ArrayList<Cart> get_gumae(String uid) {
		db.getCon();
		ArrayList<Cart> v = new ArrayList<Cart>();
		
		try {
			
			String sql = "select * from cart where ord_uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Cart c = new Cart();
				
				c.setBank(rs.getString("bank"));
				c.setGuest(rs.getString("guest"));
				c.setIpkumja(rs.getString("ipkumja"));
				c.setPrice(rs.getInt("price"));
				c.setPurchase(rs.getString("purchase"));
				c.setDate(rs.getString("date"));
				c.setClick(rs.getInt("click"));
				c.setProduct_num(rs.getString("product_num"));
				
				v.add(c);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return v;
	}
	
	public void click_count(String product_num) {
		db.getCon();
		
		try {
			
			String sql = "update cart set click=click+1 where product_num=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, product_num);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public String click_num(String uid) {
		db.getCon();
		String count = "";
		
		try {
			
			String sql = "select max(click) from cart where ord_uid=?";
			
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
	
	public void cancelG(String ord_uid) {
		db.getCon();
		
		try {
			
			String sql = "update cart set purchase=? where ord_uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, "c");
			pstmt.setString(2, ord_uid);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public ArrayList<Cart> show_mycart(String id) {
		db.getCon();
		ArrayList<Cart> v = new ArrayList<>();
		
		try {
			String sql = "select * from cart where id=? and purchase='△'";
			
			pstmt = db.conn.prepareStatement(sql);
			
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Cart c = new Cart();
				
				c.setBookfile(rs.getString("bookfile"));
				c.setFile(rs.getString("file"));
				c.setGuest(rs.getString("guest"));
				c.setId(rs.getString("id"));
				c.setPrice(rs.getInt("price"));
				c.setProduct_num(rs.getString("product_num"));
				c.setPurchase(rs.getString("purchase"));
				c.setThum_file(rs.getString("thum_file"));
				c.setTitle(rs.getString("title"));
				c.setBank(rs.getString("bank"));
				c.setIpkumja(rs.getString("ipkumja"));
				c.setDate(rs.getString("date"));
				
				v.add(c);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return v;
	}
	
	public ArrayList<Cart> view_paycart(String id) {
		db.getCon();
		ArrayList<Cart> v = new ArrayList<>();
		
		try {
			String sql = "select * from cart where id=? and purchase='△' ";
			
			pstmt = db.conn.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Cart c = new Cart();
				
				c.setBookfile(rs.getString("bookfile"));
				c.setFile(rs.getString("file"));
				c.setGuest(rs.getString("guest"));
				c.setId(rs.getString("id"));
				c.setPrice(rs.getInt("price"));
				c.setProduct_num(rs.getString("product_num"));
				c.setPurchase(rs.getString("purchase"));
				c.setThum_file(rs.getString("thum_file"));
				c.setTitle(rs.getString("title"));
				
				v.add(c);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		return v;
	}
	
	public void cancel_complete(String val, String id) {
		db.getCon();
		
		try {
			
			String sql = "update cart set purchase='c' where id=? and product_num=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, val);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void cancel_mu(String uid) {
		db.getCon();
		
		try {
			
			String sql = "update cart set purchase='x' where ord_uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public Cart get_detail(String jogeon, String val) {
		db.getCon();
		Cart c = new Cart();
		
		try {
			
			String sql = "select * from cart where product_num='"+val+"' "+jogeon;
			
			stmt = db.conn.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				
				
				c.setBank(rs.getString("bank"));
				c.setClick(rs.getInt("click"));
				c.setDate(rs.getString("date"));
				c.setFile(rs.getString("file"));
				c.setGuest(rs.getString("guest"));
				c.setId(rs.getString("id"));
				c.setIpkumja(rs.getString("ipkumja"));
				c.setPrice(rs.getInt("price"));
				c.setProduct_num(rs.getString("product_num"));
				c.setThum_file(rs.getString("thum_file"));
				c.setTitle(rs.getString("title"));
				
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return c;
	}
	

	public String uid_count(String ord_uid) {
		db.getCon();
		String count = "";
		
		try {
			
			String sql = "select count(*) from cart where ord_uid=?";
			
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
	
	public void insert_uid(String product_num, String ord_uid) {
		db.getCon();
		
		try {
			
			String sql = "update cart set ord_uid=? where product_num=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, ord_uid);
			pstmt.setString(2, product_num);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void insert_uidCount(String count_uid, String ord_uid) {
		db.getCon();
		
		try {
			
			String sql = "update cart set count_uid=? where ord_uid=?";
			
			pstmt = db.conn.prepareStatement(sql);
			pstmt.setString(1, count_uid);
			pstmt.setString(2, ord_uid);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
}
