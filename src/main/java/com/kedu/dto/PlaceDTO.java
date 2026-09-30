package com.kedu.dto;

import java.sql.Timestamp;

public class PlaceDTO {

	private int place_Id;
	private String place_Type;
	private String name;
	private String region;
	private String sigungu;
	private String address;
	private Double latitude;
	private Double longitude;
	private String tel;
	private String intro;
	private String imageName;
	private Integer price;
	private Double avg_Rating;
	private Integer review_Count;
	private String api_Content_Id;
	private Timestamp reg_Date;
	private String source;

	// --- 조회 전용 (Room과 JOIN하기 위함) ---
	private Integer minPrice;
	private int roomCount;
	private String roomImg;

	public PlaceDTO() {
	}

	public PlaceDTO(int placeId, String placeType, String name, String region, String sigungu, String address,
			double latitude, double longitude, String tel, String intro, String imageName, int price, double avgRating,
			int reviewCount, String apiContentId, Timestamp regDate, String source) {
		this.place_Id = placeId;
		this.place_Type = placeType;
		this.name = name;
		this.region = region;
		this.sigungu = sigungu;
		this.address = address;
		this.latitude = latitude;
		this.longitude = longitude;
		this.tel = tel;
		this.intro = intro;
		this.imageName = imageName;
		this.price = price;
		this.avg_Rating = avgRating;
		this.review_Count = reviewCount;
		this.api_Content_Id = apiContentId;
		this.reg_Date = regDate;
		this.source = source;
	}

	public int getPlace_Id() {
		return place_Id;
	}

	public void setPlace_Id(int placeId) {
		this.place_Id = placeId;
	}

	public String getPlace_Type() {
		return place_Type;
	}

	public void setPlace_Type(String placeType) {
		this.place_Type = placeType;
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

	public String getSigungu() {
		return sigungu;
	}

	public void setSigungu(String sigungu) {
		this.sigungu = sigungu;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
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

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public String getImageName() {
		return imageName;
	}

	public void setImageName(String imageName) {
		this.imageName = imageName;
	}

	public Integer getPrice() {
		return price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}

	public Double getAvg_Rating() {
		return avg_Rating;
	}

	public void setAvg_Rating(Double avgRating) {
		this.avg_Rating = avgRating;
	}

	public Integer getReview_Count() {
		return review_Count;
	}

	public void setReview_Count(Integer reviewCount) {
		this.review_Count = reviewCount;
	}

	public String getApi_Content_Id() {
		return api_Content_Id;
	}

	public void setApi_Content_Id(String apiContentId) {
		this.api_Content_Id = apiContentId;
	}

	public Timestamp getReg_Date() {
		return reg_Date;
	}

	public void setReg_Date(Timestamp regDate) {
		this.reg_Date = regDate;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public Integer getMinPrice() {
		return minPrice;
	}

	public void setMinPrice(Integer minPrice) {
		this.minPrice = minPrice;
	}

	public int getRoomCount() {
		return roomCount;
	}

	public void setRoomCount(int roomCount) {
		this.roomCount = roomCount;
	}

	public String getRoomImg() {
		return roomImg;
	}

	public void setRoomImg(String roomImg) {
		this.roomImg = roomImg;
	}
}
