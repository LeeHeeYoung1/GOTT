package com.kedu.dto;

import java.sql.Timestamp;

public class ReviewDTO {
	private int seq;
	private String member_id;
	private String target_type;
	private int target_id;
	private String contents;
	private int rating;
	private Timestamp reg_date;
	
	public ReviewDTO () {}
	
	public ReviewDTO(int seq, String member_id, String target_type, int target_id, String contents, int rating,
			Timestamp reg_date) {
		this.seq = seq;
		this.member_id = member_id;
		this.target_type = target_type;
		this.target_id = target_id;
		this.contents = contents;
		this.rating = rating;
		this.reg_date = reg_date;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getTarget_type() {
		return target_type;
	}
	public void setTarget_type(String target_type) {
		this.target_type = target_type;
	}
	public int getTarget_id() {
		return target_id;
	}
	public void setTarget_id(int target_id) {
		this.target_id = target_id;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	
}
