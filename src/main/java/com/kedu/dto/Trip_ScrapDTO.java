package com.kedu.dto;

import java.sql.Timestamp;

public class Trip_ScrapDTO {
	private int scrap_id;
	private int trip_id;
	private String member_id;
	private Timestamp reg_date;
	
	public Trip_ScrapDTO () {}
	
	public Trip_ScrapDTO(int scrap_id, int trip_id, String member_id, Timestamp reg_date) {

		this.scrap_id = scrap_id;
		this.trip_id = trip_id;
		this.member_id = member_id;
		this.reg_date = reg_date;
	}
	public int getScrap_id() {
		return scrap_id;
	}
	public void setScrap_id(int scrap_id) {
		this.scrap_id = scrap_id;
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
	}
}
