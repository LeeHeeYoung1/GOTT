package com.kedu.dto;

import java.sql.Timestamp;

public class RoomDTO {
	private int room_id;
	private int place_id;
	private String room_name;
	private int room_count;
	private int base_count;
	private int max_count;
	private int price_weekday;
	private int price_weekend;
	private String image1;
	private String amenities;
	private String intro;
	private Timestamp reg_date;
	
	public RoomDTO () {}
	
	public RoomDTO(int room_id, int place_id, String room_name, int room_count, int base_count, int max_count,
			int price_weekday, int price_weekend, String image1, String amenities, String intro, Timestamp reg_date) {

		this.room_id = room_id;
		this.place_id = place_id;
		this.room_name = room_name;
		this.room_count = room_count;
		this.base_count = base_count;
		this.max_count = max_count;
		this.price_weekday = price_weekday;
		this.price_weekend = price_weekend;
		this.image1 = image1;
		this.amenities = amenities;
		this.intro = intro;
		this.reg_date = reg_date;
	}
	public int getRoom_id() {
		return room_id;
	}
	public void setRoom_id(int room_id) {
		this.room_id = room_id;
	}
	public int getPlace_id() {
		return place_id;
	}
	public void setPlace_id(int place_id) {
		this.place_id = place_id;
	}
	public String getRoom_name() {
		return room_name;
	}
	public void setRoom_name(String room_name) {
		this.room_name = room_name;
	}
	public int getRoom_count() {
		return room_count;
	}
	public void setRoom_count(int room_count) {
		this.room_count = room_count;
	}
	public int getBase_count() {
		return base_count;
	}
	public void setBase_count(int base_count) {
		this.base_count = base_count;
	}
	public int getMax_count() {
		return max_count;
	}
	public void setMax_count(int max_count) {
		this.max_count = max_count;
	}
	public int getPrice_weekday() {
		return price_weekday;
	}
	public void setPrice_weekday(int price_weekday) {
		this.price_weekday = price_weekday;
	}
	public int getPrice_weekend() {
		return price_weekend;
	}
	public void setPrice_weekend(int price_weekend) {
		this.price_weekend = price_weekend;
	}
	public String getImage1() {
		return image1;
	}
	public void setImage1(String image1) {
		this.image1 = image1;
	}
	public String getAmenities() {
		return amenities;
	}
	public void setAmenities(String amenities) {
		this.amenities = amenities;
	}
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	
	
}
