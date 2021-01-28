package org.zerock.domain;

public class ReservationVO {

	private String id;
	private String code;
	private String res_name;
	private String res_tel;
	private String res_date;
	private String res_addr;
	private String reserv_date;
	private String reserv_time;
	private int uid;
	private String peopleNum;
	
	
	
	public String getPeopleNum() {
		return peopleNum;
	}
	public void setPeopleNum(String peopleNum) {
		this.peopleNum = peopleNum;
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
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getRes_name() {
		return res_name;
	}
	public void setRes_name(String res_name) {
		this.res_name = res_name;
	}
	public String getRes_tel() {
		return res_tel;
	}
	public void setRes_tel(String res_tel) {
		this.res_tel = res_tel;
	}
	public String getRes_date() {
		return res_date;
	}
	public void setRes_date(String res_date) {
		this.res_date = res_date;
	}
	public String getRes_addr() {
		return res_addr;
	}
	public void setRes_addr(String res_addr) {
		this.res_addr = res_addr;
	}
	public String getReserv_date() {
		return reserv_date;
	}
	public void setReserv_date(String reserv_date) {
		this.reserv_date = reserv_date;
	}
	public String getReserv_time() {
		return reserv_time;
	}
	public void setReserv_time(String reserv_time) {
		this.reserv_time = reserv_time;
	}
	
}
