package com.kedu.dto;

import java.sql.Date;

public class BannerDTO {
	private int banner_id;
	private String title;
	private String image_name;
	private String link_url;
	private Date start_date;
	private Date end_date;
	private int sort_order;
	
	public BannerDTO () {}
	
	public BannerDTO(int banner_id, String title, String image_name, String link_url, Date start_date, Date end_date,
			int sort_order) {
		this.banner_id = banner_id;
		this.title = title;
		this.image_name = image_name;
		this.link_url = link_url;
		this.start_date = start_date;
		this.end_date = end_date;
		this.sort_order = sort_order;
	}
	public int getBanner_id() {
		return banner_id;
	}
	public void setBanner_id(int banner_id) {
		this.banner_id = banner_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getImage_name() {
		return image_name;
	}
	public void setImage_name(String image_name) {
		this.image_name = image_name;
	}
	public String getLink_url() {
		return link_url;
	}
	public void setLink_url(String link_url) {
		this.link_url = link_url;
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
	public int getSort_order() {
		return sort_order;
	}
	public void setSort_order(int sort_order) {
		this.sort_order = sort_order;
	}
}
