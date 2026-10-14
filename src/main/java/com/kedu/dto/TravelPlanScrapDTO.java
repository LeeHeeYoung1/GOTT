package com.kedu.dto;

import java.sql.Timestamp;

public class TravelPlanScrapDTO {

	private int scrap_id;
	private int plan_id;
	private String member_id;
	private Timestamp reg_date;

	public TravelPlanScrapDTO() {}
	
	public TravelPlanScrapDTO(int scrap_id, int plan_id, String member_id, Timestamp reg_date) {
		super();
		this.scrap_id = scrap_id;
		this.plan_id = plan_id;
		this.member_id = member_id;
		this.reg_date = reg_date;
	}

	public int getScrap_id() {
		return scrap_id;
	}

	public void setScrap_id(int scrap_id) {
		this.scrap_id = scrap_id;
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

	public Timestamp getReg_date() {
		return reg_date;
	}

	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
}