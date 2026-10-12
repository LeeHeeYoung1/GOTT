package com.kedu.dto;

import java.sql.Timestamp;

public class ReviewRecommendDTO {

	private int review_seq;
	private String member_id;
	private Timestamp reg_date;
	
	public ReviewRecommendDTO() {}
	
	public ReviewRecommendDTO(int review_seq, String member_id, Timestamp reg_date) {
		this.review_seq = review_seq;
		this.member_id = member_id;
		this.reg_date = reg_date;
	}
	public int getReview_seq() {
		return review_seq;
	}
	public void setReview_seq(int review_seq) {
		this.review_seq = review_seq;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	
	
}
