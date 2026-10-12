package com.kedu.dto;

import java.sql.Timestamp;

public class ReviewReplyDTO {

	private int seq;
	private int review_seq;
	private String member_id;
	private String contents;
	private Timestamp reg_date;
	private Integer parent_seq;
	private String nickname;

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
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

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public Timestamp getReg_date() {
		return reg_date;
	}

	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}

	public Integer getParent_seq() {
		return parent_seq;
	}

	public void setParent_seq(Integer parent_seq) {
		this.parent_seq = parent_seq;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
}