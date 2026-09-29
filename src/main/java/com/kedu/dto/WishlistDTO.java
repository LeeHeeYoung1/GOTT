package com.kedu.dto;

import java.sql.Timestamp;

public class WishlistDTO {
	private int wishlist_id;
	private String member_id;
	private String target_type;
	private int target_id;
	private Timestamp reg_date;
	
	public WishlistDTO () {}
	
	public WishlistDTO(int wishlist_id, String member_id, String target_type, int target_id, Timestamp reg_date) {

		this.wishlist_id = wishlist_id;
		this.member_id = member_id;
		this.target_type = target_type;
		this.target_id = target_id;
		this.reg_date = reg_date;
	}
	public int getWishlist_id() {
		return wishlist_id;
	}
	public void setWishlist_id(int wishlist_id) {
		this.wishlist_id = wishlist_id;
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
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	
	
}
