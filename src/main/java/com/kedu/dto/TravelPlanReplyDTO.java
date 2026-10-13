package com.kedu.dto;

import java.sql.Timestamp;

public class TravelPlanReplyDTO {

	private int seq;
	private int plan_id;
	private String member_id;
	private String contents;
	private Integer parent_seq;
	private Timestamp reg_date;
	private String nickname;

	public TravelPlanReplyDTO() {}

	public TravelPlanReplyDTO(int seq, int plan_id, String member_id, String contents, Integer parent_seq,
			Timestamp reg_date) {
		this.seq = seq;
		this.plan_id = plan_id;
		this.member_id = member_id;
		this.contents = contents;
		this.parent_seq = parent_seq;
		this.reg_date = reg_date;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getPlan_id() {
		return plan_id;
	}

	public void setPlan_id(int plan_id) {
		this.plan_id = plan_id;
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

	public Integer getParent_seq() {
		return parent_seq;
	}

	public void setParent_seq(Integer parent_seq) {
		this.parent_seq = parent_seq;
	}

	public Timestamp getReg_date() {
		return reg_date;
	}

	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	
	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
}