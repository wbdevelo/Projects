package model;

public class Order {
	private String id;
	private String guest;
	private String state;
	private String product_num;
	private String bank;
	private String ipkumja;
	private String price;
	private int uid;
	private String password;
	private String date;
	private String whereis;
	
	
	public String getWhereis() {
		return whereis;
	}
	public void setWhereis(String whereis) {
		this.whereis = whereis;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getGuest() {
		return guest;
	}
	public void setGuest(String guest) {
		this.guest = guest;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getProduct_num() {
		return product_num;
	}
	public void setProduct_num(String product_num) {
		this.product_num = product_num;
	}
	public String getBank() {
		return bank;
	}
	public void setBank(String bank) {
		this.bank = bank;
	}
	public String getIpkumja() {
		return ipkumja;
	}
	public void setIpkumja(String ipkumja) {
		this.ipkumja = ipkumja;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	
}
