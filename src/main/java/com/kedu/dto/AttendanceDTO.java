package com.kedu.dto;

import java.sql.Date;

public class AttendanceDTO {
	private int attendance_id;
	private String member_id;
	private Date attendance_date;
	private int stampdays;
	
	public AttendanceDTO () {}
	
	public AttendanceDTO(int attendance_id, String member_id, Date attendance_date, int stampdays) {
		this.attendance_id = attendance_id;
		this.member_id = member_id;
		this.attendance_date = attendance_date;
		this.stampdays = stampdays;
	}
	public int getAttendance_id() {
		return attendance_id;
	}
	public void setAttendance_id(int attendance_id) {
		this.attendance_id = attendance_id;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public Date getAttendance_date() {
		return attendance_date;
	}
	public void setAttendance_date(Date attendance_date) {
		this.attendance_date = attendance_date;
	}
	public int getStampdays() {
		return stampdays;
	}
	public void setStampdays(int stampdays) {
		this.stampdays = stampdays;
	}
	
}
