package com.kedu.dto;

import java.sql.Date;
import java.sql.Timestamp;

import org.springframework.stereotype.Repository;

@Repository
public class ReservationDTO {

	private int seq;
	private String memberId;
	private Timestamp reserveDate;
	private int price;
	private Date checkIn;
	private Date checkOut;
	private int guestNum;
	private String status;
	private int mileage;
	private int roomId;
	
	public ReservationDTO() {}
	
	public ReservationDTO(int seq, String memberId, Timestamp reserveDate, int price, Date checkIn, Date checkOut,
			int guestNum, String status, int mileage, int roomId) {
		this.seq = seq;
		this.memberId = memberId;
		this.reserveDate = reserveDate;
		this.price = price;
		this.checkIn = checkIn;
		this.checkOut = checkOut;
		this.guestNum = guestNum;
		this.status = status;
		this.mileage = mileage;
		this.roomId = roomId;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public Timestamp getReserveDate() {
		return reserveDate;
	}
	public void setReserveDate(Timestamp reserveDate) {
		this.reserveDate = reserveDate;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public Date getCheckIn() {
		return checkIn;
	}
	public void setCheckIn(Date checkIn) {
		this.checkIn = checkIn;
	}
	public Date getCheckOut() {
		return checkOut;
	}
	public void setCheckOut(Date checkOut) {
		this.checkOut = checkOut;
	}
	public int getGuestNum() {
		return guestNum;
	}
	public void setGuestNum(int guestNum) {
		this.guestNum = guestNum;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getMileage() {
		return mileage;
	}
	public void setMileage(int mileage) {
		this.mileage = mileage;
	}
	public int getRoomId() {
		return roomId;
	}
	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}
	
}
