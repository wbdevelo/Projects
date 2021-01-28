package org.zerock.domain;

public class LIkesVO {
	private int uid;
	private int storecode;
	private String id;
	private int likechk;
	private String reg_date;
	
	
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}
	
	public int getStorecode() {
		return storecode;
	}
	public void setStorecode(int storecode) {
		this.storecode = storecode;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public int getLikechk() {
		return likechk;
	}
	public void setLikechk(int likechk) {
		this.likechk = likechk;
	}
}
