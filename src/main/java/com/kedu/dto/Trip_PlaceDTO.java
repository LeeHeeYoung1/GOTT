package com.kedu.dto;

public class Trip_PlaceDTO {
	
	private int trip_place_id;
	private int trip_id;
	private int day_no;
	private int sort_order;
	private int place_id;
	private String visit_time;
	private String memo;
	
	public Trip_PlaceDTO () {}

	public Trip_PlaceDTO(int trip_place_id, int trip_id, int day_no, int sort_order, int place_id, String visit_time,
			String memo) {
		super();
		this.trip_place_id = trip_place_id;
		this.trip_id = trip_id;
		this.day_no = day_no;
		this.sort_order = sort_order;
		this.place_id = place_id;
		this.visit_time = visit_time;
		this.memo = memo;
	}

	public int getTrip_place_id() {
		return trip_place_id;
	}

	public void setTrip_place_id(int trip_place_id) {
		this.trip_place_id = trip_place_id;
	}

	public int getTrip_id() {
		return trip_id;
	}

	public void setTrip_id(int trip_id) {
		this.trip_id = trip_id;
	}

	public int getDay_no() {
		return day_no;
	}

	public void setDay_no(int day_no) {
		this.day_no = day_no;
	}

	public int getSort_order() {
		return sort_order;
	}

	public void setSort_order(int sort_order) {
		this.sort_order = sort_order;
	}

	public int getPlace_id() {
		return place_id;
	}

	public void setPlace_id(int place_id) {
		this.place_id = place_id;
	}

	public String getVisit_time() {
		return visit_time;
	}

	public void setVisit_time(String visit_time) {
		this.visit_time = visit_time;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	};
	
	
}
