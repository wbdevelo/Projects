package model;

public class Cart {
	
	private String title;
	private String id;
	private String file;
	private String purchase;
	private String guest;
	private int price;
	private String product_num;
	private String thum_file;
	private String bank;
	private String ipkumja;
	private String date;
	private int click;		//다운로드 유무확인
	private int point;
	private String ord_uid;  // order
	private String count_uid;// 같은 ord_uid상품을 몇개나 구매했는지 확인용
	private String bookfile;
	private String hereis;
	private String gubun;
	
	
	
	
	public String getGubun() {
		return gubun;
	}
	public void setGubun(String gubun) {
		this.gubun = gubun;
	}
	public String getHereis() {
		return hereis;
	}
	public void setHereis(String hereis) {
		this.hereis = hereis;
	}
	public String getBookfile() {
		return bookfile;
	}
	public void setBookfile(String bookfile) {
		this.bookfile = bookfile;
	}
	public String getCount_uid() {
		return count_uid;
	}
	public void setCount_uid(String count_uid) {
		this.count_uid = count_uid;
	}
	public String getOrd_uid() {
		return ord_uid;
	}
	public void setOrd_uid(String ord_uid) {
		this.ord_uid = ord_uid;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public int getClick() {
		return click;
	}
	public void setClick(int click) {
		this.click = click;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
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
	public String getThum_file() {
		return thum_file;
	}
	public void setThum_file(String thum_file) {
		this.thum_file = thum_file;
	}
	public String getProduct_num() {
		return product_num;
	}
	public void setProduct_num(String product_num) {
		this.product_num = product_num;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getGuest() {
		return guest;
	}
	public void setGuest(String guest) {
		this.guest = guest;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	public String getPurchase() {
		return purchase;
	}
	public void setPurchase(String purchase) {
		this.purchase = purchase;
	}

}
