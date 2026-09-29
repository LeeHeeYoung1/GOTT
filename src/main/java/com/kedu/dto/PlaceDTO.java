package com.kedu.dto;

import java.sql.Timestamp;

public class PlaceDTO {

	private int placeId;
	private String placeType;
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
	private Double avgRating;
	private Integer reviewCount;
	private String apiContentId;
	private Timestamp regDate;
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
		this.placeId = placeId;
		this.placeType = placeType;
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
		this.avgRating = avgRating;
		this.reviewCount = reviewCount;
		this.apiContentId = apiContentId;
		this.regDate = regDate;
		this.source = source;
	}

	public int getPlaceId() {
		return placeId;
	}

	public void setPlaceId(int placeId) {
		this.placeId = placeId;
	}

	public String getPlaceType() {
		return placeType;
	}

	public void setPlaceType(String placeType) {
		this.placeType = placeType;
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

	public Double getAvgRating() {
		return avgRating;
	}

	public void setAvgRating(Double avgRating) {
		this.avgRating = avgRating;
	}

	public Integer getReviewCount() {
		return reviewCount;
	}

	public void setReviewCount(Integer reviewCount) {
		this.reviewCount = reviewCount;
	}

	public String getApiContentId() {
		return apiContentId;
	}

	public void setApiContentId(String apiContentId) {
		this.apiContentId = apiContentId;
	}

	public Timestamp getRegDate() {
		return regDate;
	}

	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
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
