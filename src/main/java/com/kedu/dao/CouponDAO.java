
package com.kedu.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.CouponDTO;

@Repository
public class CouponDAO {
    @Autowired
    private JdbcTemplate jdbc;

    // 1. 회원 쿠폰함 조회
    public List<CouponDTO> selectMyCoupons(String memberId) {
		String sql = "SELECT c.COUPON_ID AS couponId, " + "c.COUPON_NAME AS couponName, "
				+ "c.DISCOUNT_TYPE AS discountType, " + "c.DISCOUNT_VALUE AS discountValue, "
				+ "c.MIN_ORDER_PRICE AS minOrderPrice, " + "c.START_DATE AS startDate, " + "c.END_DATE AS endDate, "
				+ "c.ACTIVE_YN AS activeYn, " + "mc.MEMBER_COUPON_ID AS memberCouponId, " + "mc.MEMBER_ID AS memberId, "
				+ "mc.ISSUE_DATE AS issueDate, " + "mc.EXPIRE_DATE AS expireDate, "
				+ "CASE WHEN mc.STATUS = 'USED' THEN 'USED' " + "WHEN TRUNC(SYSDATE) > TRUNC(mc.EXPIRE_DATE) "
				+ "OR TRUNC(SYSDATE) > TRUNC(c.END_DATE) " + "THEN 'EXPIRED' ELSE mc.STATUS END AS status, "
				+ "mc.USED_DATE AS usedDate " + "FROM COUPON c "
				+ "JOIN MEMBERS_COUPON mc ON c.COUPON_ID = mc.COUPON_ID " + "WHERE mc.MEMBER_ID = ? "
				+ "ORDER BY mc.ISSUE_DATE DESC";

		return jdbc.query(sql, new BeanPropertyRowMapper<CouponDTO>(CouponDTO.class), memberId);
    }

    // 2. 결제 금액에 맞는 사용 가능 쿠폰 조회
    public List<CouponDTO> selectAvailableCoupons(String memberId, int price) {
		String sql = "SELECT c.COUPON_ID AS couponId, " + "c.COUPON_NAME AS couponName, "
				+ "c.DISCOUNT_TYPE AS discountType, " + "c.DISCOUNT_VALUE AS discountValue, "
				+ "c.MIN_ORDER_PRICE AS minOrderPrice, " + "c.START_DATE AS startDate, " + "c.END_DATE AS endDate, "
				+ "c.ACTIVE_YN AS activeYn, " + "mc.MEMBER_COUPON_ID AS memberCouponId, " + "mc.MEMBER_ID AS memberId, "
				+ "mc.ISSUE_DATE AS issueDate, " + "mc.EXPIRE_DATE AS expireDate, " + "mc.STATUS AS status, "
				+ "mc.USED_DATE AS usedDate " + "FROM COUPON c "
				+ "JOIN MEMBERS_COUPON mc ON c.COUPON_ID = mc.COUPON_ID " + "WHERE mc.MEMBER_ID = ? "
				+ "AND mc.STATUS = 'AVAILABLE' " + "AND c.ACTIVE_YN = 'Y' "
				+ "AND TRUNC(SYSDATE) BETWEEN TRUNC(c.START_DATE) AND TRUNC(c.END_DATE) "
				+ "AND TRUNC(SYSDATE) <= TRUNC(mc.EXPIRE_DATE) " + "AND c.MIN_ORDER_PRICE <= ? "
				+ "ORDER BY c.DISCOUNT_VALUE DESC";

		return jdbc.query(sql, new BeanPropertyRowMapper<CouponDTO>(CouponDTO.class), memberId, price);
    }

    // 회원이 보유한 사용 가능 쿠폰 조회 및 최소 결제 금액 검증
	public CouponDTO selectUsableCoupon(String memberId, int memberCouponId, int originalPrice) {
		String sql = "SELECT c.COUPON_ID AS couponId, " + "c.COUPON_NAME AS couponName, "
				+ "c.DISCOUNT_TYPE AS discountType, " + "c.DISCOUNT_VALUE AS discountValue, "
				+ "c.MIN_ORDER_PRICE AS minOrderPrice, " + "c.START_DATE AS startDate, " + "c.END_DATE AS endDate, "
				+ "c.ACTIVE_YN AS activeYn, " + "mc.MEMBER_COUPON_ID AS memberCouponId, " + "mc.MEMBER_ID AS memberId, "
				+ "mc.ISSUE_DATE AS issueDate, " + "mc.EXPIRE_DATE AS expireDate, " + "mc.STATUS AS status, "
				+ "mc.USED_DATE AS usedDate " + "FROM COUPON c "
				+ "JOIN MEMBERS_COUPON mc ON c.COUPON_ID = mc.COUPON_ID " + "WHERE mc.MEMBER_ID = ? "
				+ "AND mc.MEMBER_COUPON_ID = ? " + "AND mc.STATUS = 'AVAILABLE' " + "AND c.ACTIVE_YN = 'Y' "
				+ "AND TRUNC(SYSDATE) BETWEEN TRUNC(c.START_DATE) AND TRUNC(c.END_DATE) "
				+ "AND TRUNC(SYSDATE) <= TRUNC(mc.EXPIRE_DATE) " + "AND c.MIN_ORDER_PRICE <= ?";

		List<CouponDTO> list = jdbc.query(sql, new BeanPropertyRowMapper<CouponDTO>(CouponDTO.class), memberId,
				memberCouponId, originalPrice);

        return list.isEmpty() ? null : list.get(0);
    }

	// 결제 검증 후 쿠폰 사용 처리
	public int useCoupon(String memberId, int memberCouponId, int originalPrice, String paymentId) {
		String sql = "UPDATE MEMBERS_COUPON mc " + "SET STATUS = 'USED', USED_DATE = SYSDATE, USED_PAYMENT_ID = ? "
				+ "WHERE mc.MEMBER_ID = ? " + "AND mc.MEMBER_COUPON_ID = ? " + "AND mc.STATUS = 'AVAILABLE' "
				+ "AND EXISTS (SELECT 1 FROM COUPON c " + "WHERE c.COUPON_ID = mc.COUPON_ID " + "AND c.ACTIVE_YN = 'Y' "
				+ "AND TRUNC(SYSDATE) BETWEEN TRUNC(c.START_DATE) AND TRUNC(c.END_DATE) "
				+ "AND TRUNC(SYSDATE) <= TRUNC(mc.EXPIRE_DATE) " + "AND c.MIN_ORDER_PRICE <= ?)";
	    return jdbc.update(sql, paymentId, memberId, memberCouponId, originalPrice);
	}

	// 예약 취소 시 해당 예약에서 사용한 쿠폰 복구
	public int restoreCoupon(String memberId, String paymentId) {
	    String sql = "UPDATE MEMBERS_COUPON "
	            + "SET STATUS = 'AVAILABLE', USED_DATE = NULL, USED_PAYMENT_ID = NULL "
	            + "WHERE MEMBER_ID = ? AND USED_PAYMENT_ID = ? AND STATUS = 'USED'";
	    return jdbc.update(sql, memberId, paymentId);
	}
	
	//마이페이지 쿠폰 최대 2개만표시
	public ArrayList<CouponDTO> selectMyCoupons2(String memberId) {
		String sql = "SELECT mc.MEMBER_COUPON_ID, c.COUPON_NAME, " + "c.DISCOUNT_RATE, c.MIN_PRICE, mc.EXPIRE_DATE "
				+ "FROM MEMBERS_COUPON mc " + "JOIN COUPON c ON mc.COUPON_ID = c.COUPON_ID " + "WHERE mc.MEMBER_ID = ? "
				+ "AND mc.STATUS = 'AVAILABLE' " + "AND mc.EXPIRE_DATE >= TRUNC(SYSDATE) "
				+ "AND c.START_DATE <= TRUNC(SYSDATE) " + "AND c.END_DATE >= TRUNC(SYSDATE) "
				+ "ORDER BY mc.EXPIRE_DATE";
		return (ArrayList<CouponDTO>) jdbc.query(sql, new BeanPropertyRowMapper<>(CouponDTO.class), memberId);
	}
	

}
