package com.kedu.dto;

import java.sql.Timestamp;

public class ReservationHistory {
    private int historyId;
    private int reservationSeq;
    private String paymentId;
    private String reservationPaymentId;
    private String memberId;
    private String paymentType;
    private int amount;
    private String status;
    private Timestamp createdAt;
    
    public ReservationHistory() {}

    public ReservationHistory(int historyId, int reservationSeq, String paymentId, String reservationPaymentId, String memberId, String paymentType, int amount, String status, Timestamp createdAt) {
        this.historyId = historyId;
        this.reservationSeq = reservationSeq;
        this.paymentId = paymentId;
        this.reservationPaymentId = reservationPaymentId;
        this.memberId = memberId;
        this.paymentType = paymentType;
        this.amount = amount;
        this.status = status;
        this.createdAt = createdAt;
    }

	public int getHistoryId() {
		return historyId;
	}

	public void setHistoryId(int historyId) {
		this.historyId = historyId;
	}

	public int getReservationSeq() {
		return reservationSeq;
	}

	public void setReservationSeq(int reservationSeq) {
		this.reservationSeq = reservationSeq;
	}

	public String getPaymentId() {
		return paymentId;
	}

	public void setPaymentId(String paymentId) {
		this.paymentId = paymentId;
	}

	public String getReservationPaymentId() {
		return reservationPaymentId;
	}

	public void setReservationPaymentId(String reservationPaymentId) {
		this.reservationPaymentId = reservationPaymentId;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getPaymentType() {
		return paymentType;
	}

	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
}
