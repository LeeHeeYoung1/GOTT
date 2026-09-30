package com.kedu.dto;

import java.sql.Timestamp;

public class PlaceDTO {

	private int place_id;
	private String name;
	private String region;
	private String address;
	private String place_type;
	private String intro;
	private String image_name;
	private Double latitude;
	private Double longitude;
	private Integer price;
	private Double avg_rating;
	private Integer review_count;
	private Timestamp reg_date;
	private String sigungu;
	
	public String getSigungu() {
		return sigungu;
	}

	public PlaceDTO () {}
	
	public PlaceDTO(int place_id, String name, String region, String address, String place_type, String intro,
			String image_name, Double latitude, Double longitude, Integer price, Double avg_rating,
			Integer review_count, Timestamp reg_date, String sigungu, Integer min_price, Integer room_count,
			String room_img, String amenities) {
	
		this.place_id = place_id;
		this.name = name;
		this.region = region;
		this.address = address;
		this.place_type = place_type;
		this.intro = intro;
		this.image_name = image_name;
		this.latitude = latitude;
		this.longitude = longitude;
		this.price = price;
		this.avg_rating = avg_rating;
		this.review_count = review_count;
		this.reg_date = reg_date;
		this.sigungu = sigungu;
		this.min_price = min_price;
		this.room_count = room_count;
		this.room_img = room_img;
		this.amenities = amenities;
	}

	public void setSigungu(String sigungu) {
		this.sigungu = sigungu;
	}

	// --- 조회 전용 (Room 서브쿼리 결과) ---
	private Integer min_price;
	private Integer room_count;
	private String room_img;
	private String amenities;

	public int getPlace_id() {
		return place_id;
	}

	public void setPlace_id(int place_id) {
		this.place_id = place_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPlace_type() {
		return place_type;
	}

	public void setPlace_type(String place_type) {
		this.place_type = place_type;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public String getImage_name() {
		return image_name;
	}

	public void setImage_name(String image_name) {
		this.image_name = image_name;
	}

	public Double getLatitude() {
		return latitude;
	}

	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}

	public Double getLongitude() {
		return longitude;
	}

	public void setLongitude(Double longitude) {
		this.longitude = longitude;
	}

	public Integer getPrice() {
		return price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}

	public Double getAvg_rating() {
		return avg_rating;
	}

	public void setAvg_rating(Double avg_rating) {
		this.avg_rating = avg_rating;
	}

	public Integer getReview_count() {
		return review_count;
	}

	public void setReview_count(Integer review_count) {
		this.review_count = review_count;
	}

	public Timestamp getReg_date() {
		return reg_date;
	}

	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}

	public Integer getMin_price() {
		return min_price;
	}

	public void setMin_price(Integer min_price) {
		this.min_price = min_price;
	}

	public Integer getRoom_count() {
		return room_count;
	}

	public void setRoom_count(Integer room_count) {
		this.room_count = room_count;
	}

	public String getRoom_img() {
		return room_img;
	}

	public void setRoom_img(String room_img) {
		this.room_img = room_img;
	}

	public String getAmenities() {
		return amenities;
	}

	public void setAmenities(String amenities) {
		this.amenities = amenities;
	}
}