package com.kedu.dto;

import java.sql.Timestamp;

public class Trip_LikeDTO {
	private int like_id;
	private int trip_id;
	private String member_id;
	private Timestamp reg_date;
	
	public Trip_LikeDTO() {}

	public Trip_LikeDTO(int like_id, int trip_id, String member_id, Timestamp reg_date) {
		super();
		this.like_id = like_id;
		this.trip_id = trip_id;
		this.member_id = member_id;
		this.reg_date = reg_date;
	}

	public int getLike_id() {
		return like_id;
	}

	public void setLike_id(int like_id) {
		this.like_id = like_id;
	}

	public int getTrip_id() {
		return trip_id;
	}

	public void setTrip_id(int trip_id) {
		this.trip_id = trip_id;
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
	};
	
	
}
