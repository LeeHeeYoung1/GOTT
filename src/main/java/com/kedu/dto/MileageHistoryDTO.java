package com.kedu.dto;

import java.sql.Date;

public class MileageHistoryDTO {
    private int seq;
    private String memberId;
    private int reservationId;
    private String paymentId;
    private String type;
    private int amount;
    private int balance;
    private String reason;
    private Date regDate;

    public MileageHistoryDTO() {}
    
    public MileageHistoryDTO(int seq, String memberId, int reservationId, String paymentId,
            String type, int amount, int balance, String reason, Date regDate) {
        this.seq = seq;
        this.memberId = memberId;
        this.reservationId = reservationId;
        this.paymentId = paymentId;
        this.type = type;
        this.amount = amount;
        this.balance = balance;
        this.reason = reason;
        this.regDate = regDate;
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
    public int getReservationId() {
        return reservationId;
    }
    public void setReservationId(int reservationId) {
        this.reservationId = reservationId;
    }
    public String getPaymentId() {
        return paymentId;
    }
    public void setPaymentId(String paymentId) {
        this.paymentId = paymentId;
    }
    public String getType() {
        return type;
    }
    public void setType(String type) {
        this.type = type;
    }
    public int getAmount() {
        return amount;
    }
    public void setAmount(int amount) {
        this.amount = amount;
    }
    public int getBalance() {
        return balance;
    }
    public void setBalance(int balance) {
        this.balance = balance;
    }
    public String getReason() {
        return reason;
    }
    public void setReason(String reason) {
        this.reason = reason;
    }
    public Date getRegDate() {
        return regDate;
    }
    public void setRegDate(Date regDate) {
        this.regDate = regDate;
    }
}