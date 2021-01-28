package org.zerock.domain;

import java.util.Date;

public class ReviewVO {
	private int uid;
	private String id;
	private String storecode;
	private String dosi;
	private String sigugun;
	private String address;
	private String starpoint;
	private String comment;
	private String flie_o;
	private String flie_s;
	private String signdate;
	private String storename;
	private int fid;
	private String thread;
	
	public String getStorename() {
		return storename;
	}
	public void setStorename(String storename) {
		this.storename = storename;
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
	
	public String getStorecode() {
		return storecode;
	}
	public void setStorecode(String storecode) {
		this.storecode = storecode;
	}
	
	public String getDosi() {
		return dosi;
	}
	public void setDosi(String dosi) {
		this.dosi = dosi;
	}
	
	public String getSigugun() {
		return sigugun;
	}
	public void setSigugun(String sigugun) {
		this.sigugun = sigugun;
	}
	
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	public String getStarpoint() {
		return starpoint;
	}
	public void setStarpoint(String starpoint) {
		this.starpoint = starpoint;
	}
	
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	
	public String getFlie_o() {
		return flie_o;
	}
	public void setFlie_o(String flie_o) {
		this.flie_o = flie_o;
	}
	
	public String getFlie_s() {
		return flie_s;
	}
	public void setFlie_s(String flie_s) {
		this.flie_s = flie_s;
	}
	
	public String getSigndate() {
		return signdate;
	}
	public void setSigndate(String signdate) {
		this.signdate = signdate;
	}
	
	public int getFid() {
		return fid;
	}
	public void setFid(int fid) {
		this.fid = fid;
	}
	
	public String getThread() {
		return thread;
	}
	public void setThread(String thread) {
		this.thread = thread;
	}
	
}
