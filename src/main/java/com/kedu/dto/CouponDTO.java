package com.kedu.dto;

import java.sql.Date;

public class CouponDTO {
    private int couponId;
    private String couponName;
    private String discountType;
    private int discountValue;
    private int minOrderPrice;
    private Date startDate;
    private Date endDate;
    private String activeYn;
    private int memberCouponId;
    private String memberId;
    private Date issueDate;
    private Date expireDate;
    private String status;
    private Date usedDate;

    // 기본 생성자
    public CouponDTO() {
    }

    // 전체 필드 생성자
    public CouponDTO(int couponId, String couponName, String discountType,
            int discountValue, int minOrderPrice, Date startDate, Date endDate,
            String activeYn, int memberCouponId, String memberId,
            Date issueDate, Date expireDate, String status, Date usedDate) {
        this.couponId = couponId;
        this.couponName = couponName;
        this.discountType = discountType;
        this.discountValue = discountValue;
        this.minOrderPrice = minOrderPrice;
        this.startDate = startDate;
        this.endDate = endDate;
        this.activeYn = activeYn;
        this.memberCouponId = memberCouponId;
        this.memberId = memberId;
        this.issueDate = issueDate;
        this.expireDate = expireDate;
        this.status = status;
        this.usedDate = usedDate;
    }

    public int getCouponId() {
        return couponId;
    }

    public void setCouponId(int couponId) {
        this.couponId = couponId;
    }

    public String getCouponName() {
        return couponName;
    }

    public void setCouponName(String couponName) {
        this.couponName = couponName;
    }

    public String getDiscountType() {
        return discountType;
    }

    public void setDiscountType(String discountType) {
        this.discountType = discountType;
    }

    public int getDiscountValue() {
        return discountValue;
    }

    public void setDiscountValue(int discountValue) {
        this.discountValue = discountValue;
    }

    public int getMinOrderPrice() {
        return minOrderPrice;
    }

    public void setMinOrderPrice(int minOrderPrice) {
        this.minOrderPrice = minOrderPrice;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getActiveYn() {
        return activeYn;
    }

    public void setActiveYn(String activeYn) {
        this.activeYn = activeYn;
    }

    public int getMemberCouponId() {
        return memberCouponId;
    }

    public void setMemberCouponId(int memberCouponId) {
        this.memberCouponId = memberCouponId;
    }

    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public Date getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(Date issueDate) {
        this.issueDate = issueDate;
    }

    public Date getExpireDate() {
        return expireDate;
    }

    public void setExpireDate(Date expireDate) {
        this.expireDate = expireDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getUsedDate() {
        return usedDate;
    }

    public void setUsedDate(Date usedDate) {
        this.usedDate = usedDate;
    }
}