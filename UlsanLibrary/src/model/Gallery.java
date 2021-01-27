package model;

public class Gallery {
	
	private String title;
	private String content;
	private String writer;
	private int uid;
	private String ISBN;
	private String lib_name;
	private String pub_date;
	private String file;
	private String thum_file;
	private int stock;
	private String daechul;
	private String reserv;
	private int rowNum;
	
	
	
	public int getRowNum() {
		return rowNum;
	}
	public void setRowNum(int rowNum) {
		this.rowNum = rowNum;
	}
	public String getReserv() {
		return reserv;
	}
	public void setReserv(String reserv) {
		this.reserv = reserv;
	}
	public String getDaechul() {
		return daechul;
	}
	public void setDaechul(String daechul) {
		this.daechul = daechul;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	public String getThum_file() {
		return thum_file;
	}
	public void setThum_file(String thum_file) {
		this.thum_file = thum_file;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}
	public String getISBN() {
		return ISBN;
	}
	public void setISBN(String iSBN) {
		ISBN = iSBN;
	}
	public String getLib_name() {
		return lib_name;
	}
	public void setLib_name(String lib_name) {
		this.lib_name = lib_name;
	}
	public String getPub_date() {
		return pub_date;
	}
	public void setPub_date(String pub_date) {
		this.pub_date = pub_date;
	}
	
	
}
