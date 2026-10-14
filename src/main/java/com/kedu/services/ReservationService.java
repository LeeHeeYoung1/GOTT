package com.kedu.services;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kedu.commons.PriceUtil;
import com.kedu.dao.CouponDAO;
import com.kedu.dao.ReservationDAO;
import com.kedu.dto.CouponDTO;
import com.kedu.dto.ReservationDTO;
import com.kedu.dto.RoomDTO;

@Service
public class ReservationService {
    @Autowired
    private ReservationDAO rdao;
    
    @Autowired
    private CouponDAO cdao;



	@Transactional(rollbackFor = Exception.class)
	public void saveReservation(String id, int mileage, RoomDTO roomDto,
	        String checkIn, String checkOut, int paid, int guest,
	        String paymentId, Integer memberCouponId, HttpSession session) throws Exception {
	
	    if (id == null || roomDto == null || paymentId == null
	            || paymentId.trim().isEmpty() || mileage < 0 || paid <= 0 || guest <= 0) {
	        throw new Exception("예약 정보가 올바르지 않습니다.");
	    }
	
	    // 1. 서버에서 객실 원래 금액 재계산
	    int originalPrice = PriceUtil.totalPrice(
	            checkIn, checkOut,
	            roomDto.getPriceWeekday(),
	            roomDto.getPriceWeekend()
	    );
	
	    if (originalPrice <= 0) {
	        throw new Exception("객실 금액이 올바르지 않습니다.");
	    }
	
	    // 2. 쿠폰 검증 및 할인액 계산
	    int couponDiscount = 0;
	    if (memberCouponId != null && memberCouponId > 0) {
	        CouponDTO coupon = cdao.selectUsableCoupon(id, memberCouponId, originalPrice);
	
	        if (coupon == null) {
	            throw new Exception("사용할 수 없는 쿠폰입니다.");
	        }
	
	        if ("FIXED".equals(coupon.getDiscountType())) {
	            couponDiscount = coupon.getDiscountValue();
	        } else if ("PERCENT".equals(coupon.getDiscountType())) {
	            couponDiscount = (int) (originalPrice * coupon.getDiscountValue() / 100.0);
	        } else {
	            throw new Exception("쿠폰 할인 유형이 올바르지 않습니다.");
	        }
	
	        // 할인액이 객실 금액 이상이면 결제 금액이 0원이 되므로 거부
	        if (couponDiscount <= 0 || couponDiscount >= originalPrice) {
	            throw new Exception("쿠폰 할인 금액이 올바르지 않습니다.");
	        }
	    } else {
	        memberCouponId = null;
	    }
	
	    // 3. 마일리지 사용액 검증
	    int priceAfterCoupon = originalPrice - couponDiscount;
	
	    if (mileage % 100 != 0 || mileage >= priceAfterCoupon) {
	        throw new Exception("사용할 마일리지가 올바르지 않습니다.");
	    }
	
	    // 4. 실제 PortOne 결제 금액과 서버 계산 금액 비교
	    int expectedPaid = priceAfterCoupon - mileage;
	
	    if (paid != expectedPaid) {
	        throw new Exception("실제 결제 금액과 예약 금액이 일치하지 않습니다.");
	    }
	
	    // 5. 사용 마일리지 차감
	    if (mileage > 0) {
	        int mileageResult = rdao.reservationMileage(id, mileage);
	        if (mileageResult != 1) {
	            throw new Exception("마일리지 차감 실패");
	        }
	    }
	
	    // 6. 예약 저장
	    int insertResult = rdao.insert(
	            roomDto, checkIn, checkOut, paid, guest, paymentId, session);
	
	    if (insertResult != 1) {
	        throw new Exception("예약 저장 실패");
	    }
	
	    // 7. 사용 마일리지 히스토리 기록
	    if (mileage > 0) {
	        int historyResult = rdao.insertMileageHistory(
	                id, paymentId, "USE", mileage, "숙박 예약 마일리지 사용");
	
	        if (historyResult != 1) {
	            throw new Exception("마일리지 사용 내역 저장 실패");
	        }
	    }
	
	    // 8. 쿠폰 사용 처리
	    if (memberCouponId != null) {
	        int couponResult = cdao.useCoupon(id, memberCouponId, originalPrice);
	
	        if (couponResult != 1) {
	            throw new Exception("쿠폰 사용 처리 실패");
	        }
	    }
	
	    // 9. 실제 결제 금액 기준 적립 마일리지 계산
	    int earnedMileage = (int) (paid * 0.05);
	
	    if (earnedMileage > 0) {
	        int addResult = rdao.addMileage(id, earnedMileage);
	
	        if (addResult != 1) {
	            throw new Exception("마일리지 적립 실패");
	        }
	
	        int historyResult = rdao.insertMileageHistory(
	                id, paymentId, "EARN", earnedMileage, "숙박 예약 결제 마일리지 적립");
	
	        if (historyResult != 1) {
	            throw new Exception("마일리지 적립 내역 저장 실패");
	        }
	    }
	}


    
    @Transactional(rollbackFor = Exception.class)
    public void saveReservationHistory(int reservationSeq, String paymentId,
            String reservationPaymentId, String memberId, String paymentType,
            int amount, String status) throws Exception {
		int result = rdao.ReservationHistory(reservationSeq, paymentId, reservationPaymentId, memberId, paymentType,
				amount, status);
        if (result != 1) {
            throw new Exception("예약 결제 이력 저장 실패");
        }
    }
    

	@Transactional(rollbackFor = Exception.class)
	public void completeReservationUpdatePayment(ReservationDTO reservation,
	        String newPaymentId, String memberId, int roomId,
	        java.sql.Date checkIn, java.sql.Date checkOut,
	        int guestNum, int additionalPaid, int newTotalPrice) throws Exception {
	
	    int updateResult = rdao.updateReservationAfterAdditionalPayment(
	            reservation.getPaymentId(), memberId, roomId,
	            checkIn, checkOut, guestNum, additionalPaid, newTotalPrice);
	
	    if (updateResult != 1) {
	        throw new Exception("예약 변경 저장에 실패했습니다.");
	    }
	
	    int historyResult = rdao.ReservationHistory(
	            reservation.getSeq(),
	            reservation.getPaymentId(),
	            newPaymentId,
	            memberId,
	            "ADDITIONAL_PAYMENT",
	            additionalPaid,
	            "COMPLETED");
	
	    if (historyResult != 1) {
	        throw new Exception("추가 결제 이력 저장에 실패했습니다.");
	    }
	}
	
	@Transactional(rollbackFor = Exception.class)
	public void completeReservationUpdateRefund(ReservationDTO reservation,
	        String memberId, int roomId,
	        java.sql.Date checkIn, java.sql.Date checkOut,
	        int guestNum, int refundAmount, int newTotalPrice) throws Exception {

	    if (reservation == null || refundAmount <= 0) {
	        throw new Exception("환불 정보가 올바르지 않습니다.");
	    }

	    int updateResult = rdao.updateReservationAfterRefund(
	            reservation.getPaymentId(), memberId, roomId,
	            checkIn, checkOut, guestNum, refundAmount, newTotalPrice);

	    if (updateResult != 1) {
	        throw new Exception("환불 후 예약 변경 저장에 실패했습니다.");
	    }

	    int historyResult = rdao.ReservationHistory(
	            reservation.getSeq(),
	            reservation.getPaymentId(),
	            reservation.getPaymentId(),
	            memberId,
	            "REFUND",
	            refundAmount,
	            "COMPLETED");

	    if (historyResult != 1) {
	        throw new Exception("환불 이력 저장에 실패했습니다.");
	    }
	}
	
	@Transactional(rollbackFor = Exception.class)
	public void cancelReservationAndRestoreMileage(String paymentId, String memberId) throws Exception {
	    if (paymentId == null || paymentId.trim().isEmpty()
	            || memberId == null || memberId.trim().isEmpty()) {
	        throw new Exception("예약 취소 정보가 올바르지 않습니다.");
	    }

	    // 1. 예약 취소 처리
	    int cancelResult = rdao.cancelReservation(paymentId, memberId);
	    if (cancelResult != 1) {
	        throw new Exception("예약이 없거나 이미 취소된 예약입니다.");
	    }

	    // 2. 해당 예약에서 사용한 마일리지 조회
	    int usedMileage = rdao.selectUsedMileage(paymentId, memberId);

	    // 3. 해당 예약으로 적립한 마일리지 조회
	    int earnedMileage = rdao.selectEarnedMileage(paymentId, memberId);

	    // 4. 사용했던 마일리지 복구
	    if (usedMileage > 0) {
	        int restoreResult = rdao.addMileage(memberId, usedMileage);
	        if (restoreResult != 1) {
	            throw new Exception("사용 마일리지 복구에 실패했습니다.");
	        }

	        int historyResult = rdao.insertMileageHistory(
	                memberId, paymentId, "RESTORE",
	                usedMileage, "예약 취소로 사용 마일리지 복구");

	        if (historyResult != 1) {
	            throw new Exception("마일리지 복구 내역 저장에 실패했습니다.");
	        }
	    }

	    
	    // 5. 예약으로 적립한 마일리지 회수
	    if (earnedMileage > 0) {
	        int revokeResult = rdao.subtractMileage(memberId, earnedMileage);
	        if (revokeResult != 1) {
	            throw new Exception("적립 마일리지 회수에 실패했습니다. 보유 마일리지를 확인해 주세요.");
	        }

	        int revokeHistoryResult = rdao.insertMileageHistory(
	                memberId, paymentId, "REVOKE",
	                earnedMileage, "예약 취소로 적립 마일리지 회수");

	        if (revokeHistoryResult != 1) {
	            throw new Exception("마일리지 회수 내역 저장에 실패했습니다.");
	        }
	    }
	}

}