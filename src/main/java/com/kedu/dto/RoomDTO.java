package com.kedu.dto;

import java.sql.Timestamp;

public class RoomDTO {

	private int roomId;
	private int placeId;
	private String roomName;
	private Integer roomCount;
	private Integer baseCount;
	private Integer maxCount;
	private Integer priceWeekday;
	private Integer priceWeekend;
	private String image1;
	private Integer remainCount;
	
	public RoomDTO(int roomId, int placeId, String roomName, Integer roomCount, Integer baseCount, Integer maxCount,
			Integer priceWeekday, Integer priceWeekend, String image1, String image2, String image3, String image4,
			String image5, String amenities, String intro, Timestamp regDate) {
	
		this.roomId = roomId;
		this.placeId = placeId;
		this.roomName = roomName;
		this.roomCount = roomCount;
		this.baseCount = baseCount;
		this.maxCount = maxCount;
		this.priceWeekday = priceWeekday;
		this.priceWeekend = priceWeekend;
		this.image1 = image1;
		this.image2 = image2;
		this.image3 = image3;
		this.image4 = image4;
		this.image5 = image5;
		this.amenities = amenities;
		this.intro = intro;
		this.regDate = regDate;
	}

	private String image2;
	private String image3;
	private String image4;
	private String image5;
	private String amenities;
	private String intro;
	private Timestamp regDate;

	public RoomDTO() {
	}

	public int getRoomId() {
		return roomId;
	}

	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}

	public int getPlaceId() {
		return placeId;
	}

	public void setPlaceId(int placeId) {
		this.placeId = placeId;
	}

	public String getRoomName() {
		return roomName;
	}

	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}

	public Integer getRoomCount() {
		return roomCount;
	}

	public void setRoomCount(Integer roomCount) {
		this.roomCount = roomCount;
	}

	public Integer getBaseCount() {
		return baseCount;
	}

	public void setBaseCount(Integer baseCount) {
		this.baseCount = baseCount;
	}

	public Integer getMaxCount() {
		return maxCount;
	}

	public void setMaxCount(Integer maxCount) {
		this.maxCount = maxCount;
	}

	public Integer getPriceWeekday() {
		return priceWeekday;
	}

	public void setPriceWeekday(Integer priceWeekday) {
		this.priceWeekday = priceWeekday;
	}

	public Integer getPriceWeekend() {
		return priceWeekend;
	}

	public void setPriceWeekend(Integer priceWeekend) {
		this.priceWeekend = priceWeekend;
	}

	public String getImage1() {
		return image1;
	}

	public void setImage1(String image1) {
		this.image1 = image1;
	}

	public String getImage2() {
		return image2;
	}

	public void setImage2(String image2) {
		this.image2 = image2;
	}

	public String getImage3() {
		return image3;
	}

	public void setImage3(String image3) {
		this.image3 = image3;
	}

	public String getImage4() {
		return image4;
	}

	public void setImage4(String image4) {
		this.image4 = image4;
	}

	public String getImage5() {
		return image5;
	}

	public void setImage5(String image5) {
		this.image5 = image5;
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

	public Timestamp getRegDate() {
		return regDate;
	}

	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	public Integer getRemainCount() {
		return remainCount;
	}
	public void setRemainCount(Integer remainCount) {
		this.remainCount = remainCount;
	}
}