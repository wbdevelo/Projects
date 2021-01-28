package org.zerock.domain;

public class StoreVO {
	
	private Long relax_seq;		// 가게 코드	
	private String relax_si_nm;		// 광역시, 도
	private String relax_sido_nm;	// 시/구/군
	private String relax_rstrnt_nm;	// 사업장명
	private String relax_rstrnt_represent;	// 대표자명
	private String relax_add1;		// 상세 주소
	private String relax_gubun;		// 업종
	private String relax_gubun_detail;	// 업종 상세
	private String relax_rstrnt_tel;	// 가게 전화번호
	private String date;	// 안심식당 지정일
	
	public Long getRelax_seq() {
		return relax_seq;
	}
	public void setRelax_seq(Long relax_seq) {
		this.relax_seq = relax_seq;
	}
	public String getRelax_si_nm() {
		return relax_si_nm;
	}
	public void setRelax_si_nm(String relax_si_nm) {
		this.relax_si_nm = relax_si_nm;
	}
	public String getRelax_sido_nm() {
		return relax_sido_nm;
	}
	public void setRelax_sido_nm(String relax_sido_nm) {
		this.relax_sido_nm = relax_sido_nm;
	}
	public String getRelax_rstrnt_nm() {
		return relax_rstrnt_nm;
	}
	public void setRelax_rstrnt_nm(String relax_rstrnt_nm) {
		this.relax_rstrnt_nm = relax_rstrnt_nm;
	}
	public String getRelax_rstrnt_represent() {
		return relax_rstrnt_represent;
	}
	public void setRelax_rstrnt_represent(String relax_rstrnt_represent) {
		this.relax_rstrnt_represent = relax_rstrnt_represent;
	}
	public String getRelax_add1() {
		return relax_add1;
	}
	public void setRelax_add1(String relax_add1) {
		this.relax_add1 = relax_add1;
	}
	public String getRelax_gubun() {
		return relax_gubun;
	}
	public void setRelax_gubun(String relax_gubun) {
		this.relax_gubun = relax_gubun;
	}
	public String getRelax_gubun_detail() {
		return relax_gubun_detail;
	}
	public void setRelax_gubun_detail(String relax_gubun_detail) {
		this.relax_gubun_detail = relax_gubun_detail;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getRelax_rstrnt_tel() {
		return relax_rstrnt_tel;
	}
	public void setRelax_rstrnt_tel(String relax_rstrnt_tel) {
		this.relax_rstrnt_tel = relax_rstrnt_tel;
	}
	
	
}
