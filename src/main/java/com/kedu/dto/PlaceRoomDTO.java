package com.kedu.dto;

public class PlaceRoomDTO {

	private int place_id;
	private String name;
	private String region;
	private String address;
	private String place_type;
	private String image_name;
	private Double latitude;
	private Double longitude;
	private Double avg_rating;
	private Integer min_price;
	private Integer total_room_count;
	private String amenities;
	private String alter_image;
	
	
	public PlaceRoomDTO() {}
	
	public PlaceRoomDTO(int place_id, String name, String region, String address, String place_type, String image_name,
			Double latitude, Double longitude, Double avg_rating, Integer min_price, Integer total_room_count,
			String amenities, String alter_image) {
		this.place_id = place_id;
		this.name = name;
		this.region = region;
		this.address = address;
		this.place_type = place_type;
		this.image_name = image_name;
		this.latitude = latitude;
		this.longitude = longitude;
		this.avg_rating = avg_rating;
		this.min_price = min_price;
		this.total_room_count = total_room_count;
		this.amenities = amenities;
		this.alter_image = alter_image;
	}
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
	public Double getAvg_rating() {
		return avg_rating;
	}
	public void setAvg_rating(Double avg_rating) {
		this.avg_rating = avg_rating;
	}
	public Integer getMin_price() {
		return min_price;
	}
	public void setMin_price(Integer min_price) {
		this.min_price = min_price;
	}
	public Integer getTotal_room_count() {
		return total_room_count;
	}
	public void setTotal_room_count(Integer total_room_count) {
		this.total_room_count = total_room_count;
	}
	public String getAmenities() {
		return amenities;
	}
	public void setAmenities(String amenities) {
		this.amenities = amenities;
	}
	public String getAlter_image() {
		return alter_image;
	}
	public void setAlter_image(String alter_image) {
		this.alter_image = alter_image;
	}
	
	
}
