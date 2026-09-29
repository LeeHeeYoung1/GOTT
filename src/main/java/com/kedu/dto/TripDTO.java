package com.kedu.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class TripDTO {
	private int trip_id;
	private String member_id;
	private String region;
	private Date start_date;
	private Date end_date;
	private int headcount;
	private String theme;
	private String is_public;
	private String summary;
	private String thumbnail;
	private int view_count;
	private int like_count;
	private int scrap_count;
	private int origin_trip_id;
	private Timestamp reg_date;
	
	public TripDTO () {}
	
	public TripDTO(int trip_id, String member_id, String region, Date start_date, Date end_date, int headcount,
			String theme, String is_public, String summary, String thumbnail, int view_count, int like_count,
			int scrap_count, int origin_trip_id, Timestamp reg_date) {
		this.trip_id = trip_id;
		this.member_id = member_id;
		this.region = region;
		this.start_date = start_date;
		this.end_date = end_date;
		this.headcount = headcount;
		this.theme = theme;
		this.is_public = is_public;
		this.summary = summary;
		this.thumbnail = thumbnail;
		this.view_count = view_count;
		this.like_count = like_count;
		this.scrap_count = scrap_count;
		this.origin_trip_id = origin_trip_id;
		this.reg_date = reg_date;
	}
	public int getTrip_id() {
		return trip_id;
	}
	public void setTrip_id(int trip_id) {
		this.trip_id = trip_id;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public Date getStart_date() {
		return start_date;
	}
	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}
	public Date getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
	public int getHeadcount() {
		return headcount;
	}
	public void setHeadcount(int headcount) {
		this.headcount = headcount;
	}
	public String getTheme() {
		return theme;
	}
	public void setTheme(String theme) {
		this.theme = theme;
	}
	public String getIs_public() {
		return is_public;
	}
	public void setIs_public(String is_public) {
		this.is_public = is_public;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public String getThumbnail() {
		return thumbnail;
	}
	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}
	public int getView_count() {
		return view_count;
	}
	public void setView_count(int view_count) {
		this.view_count = view_count;
	}
	public int getLike_count() {
		return like_count;
	}
	public void setLike_count(int like_count) {
		this.like_count = like_count;
	}
	public int getScrap_count() {
		return scrap_count;
	}
	public void setScrap_count(int scrap_count) {
		this.scrap_count = scrap_count;
	}
	public int getOrigin_trip_id() {
		return origin_trip_id;
	}
	public void setOrigin_trip_id(int origin_trip_id) {
		this.origin_trip_id = origin_trip_id;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	
}
