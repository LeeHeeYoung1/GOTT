package com.kedu.dto;

import java.sql.Timestamp;

public class Travel_TypeDTO {
	private int result_id;
	private String member_id;
	private String type_code;
	private Timestamp reg_date;
	
	public Travel_TypeDTO () {}
	
	public Travel_TypeDTO(int result_id, String member_id, String type_code, Timestamp reg_date) {

		this.result_id = result_id;
		this.member_id = member_id;
		this.type_code = type_code;
		this.reg_date = reg_date;
	}
	public int getResult_id() {
		return result_id;
	}
	public void setResult_id(int result_id) {
		this.result_id = result_id;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getType_code() {
		return type_code;
	}
	public void setType_code(String type_code) {
		this.type_code = type_code;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	
	
}
