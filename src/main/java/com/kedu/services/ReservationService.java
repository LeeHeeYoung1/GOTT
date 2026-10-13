package com.kedu.services;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kedu.dao.ReservationDAO;
import com.kedu.dto.ReservationDTO;
import com.kedu.dto.RoomDTO;

@Service
public class ReservationService {
    @Autowired
    private ReservationDAO rdao;


@Transactional(rollbackFor = Exception.class)
public void saveReservation(String id, int mileage, RoomDTO roomDto,
        String checkIn, String checkOut, int paid, int guest,
        String paymentId, HttpSession session) throws Exception {

    if (mileage < 0 || paid < 0) {
        throw new Exception("결제 금액 또는 사용 마일리지가 올바르지 않습니다.");
    }

    // 1. 사용 마일리지 차감
    if (mileage > 0) {
        int mileageResult = rdao.reservationMileage(id, mileage);
        if (mileageResult != 1) {
            throw new Exception("마일리지 차감 실패");
        }
    }

    // 2. 예약 저장
    int insertResult = rdao.insert(
            roomDto, checkIn, checkOut, paid, guest, paymentId, session);

    if (insertResult != 1) {
        throw new Exception("예약 저장 실패");
    }

    // 3. 사용 마일리지 히스토리 기록
    if (mileage > 0) {
        int historyResult = rdao.insertMileageHistory(
                id, paymentId, "USE", mileage, "숙박 예약 마일리지 사용");
        if (historyResult != 1) {
            throw new Exception("마일리지 사용 내역 저장 실패");
        }
    }

    // 4. 실제 결제 금액 기준 적립 마일리지 계산
    int earnedMileage = (int)(paid * 0.05);

    // 5. 회원 마일리지 적립
    if (earnedMileage > 0) {
        int addResult = rdao.addMileage(id, earnedMileage);
        if (addResult != 1) {
            throw new Exception("마일리지 적립 실패");
        }

        // 6. 적립 히스토리 기록
        int historyResult = rdao.insertMileageHistory(
                id, paymentId, "EARN", earnedMileage, "숙박 예약 결제 마일리지 적립");
        if (historyResult != 1) {
            throw new Exception("마일리지 적립 내역 저장 실패");
        }
    }

    System.out.println("예약 저장 및 마일리지 사용·적립 처리 성공");
}

	@Transactional(rollbackFor = Exception.class)
	public void cancelReservationAndRestoreMileage(String paymentId, String memberId) throws Exception {
	    // 1. 예약완료 상태인 예약만 취소
	    int cancelResult = rdao.cancelReservation(paymentId, memberId);
	    if (cancelResult != 1) {
	        throw new Exception("이미 취소되었거나 취소할 수 없는 예약입니다.");
	    }
	
	    // 2. 해당 예약에서 사용·적립한 마일리지 조회
	    int usedMileage = rdao.selectUsedMileage(paymentId, memberId);
	    int earnedMileage = rdao.selectEarnedMileage(paymentId, memberId);
	
	    // 3. 사용 마일리지 복구
	    if (usedMileage > 0) {
	        int restoreResult = rdao.addMileage(memberId, usedMileage);
	        if (restoreResult != 1) {
	            throw new Exception("사용 마일리지 복구에 실패했습니다.");
	        }
	
	        int historyResult = rdao.insertMileageHistory(
	                memberId, paymentId, "RETURN", usedMileage, "예약 취소로 사용 마일리지 복구");
	        if (historyResult != 1) {
	            throw new Exception("마일리지 복구 내역 저장에 실패했습니다.");
	        }
	    }
	
	    // 4. 해당 예약으로 적립한 마일리지 회수
	    if (earnedMileage > 0) {
	        int subtractResult = rdao.subtractMileage(memberId, earnedMileage);
	        if (subtractResult != 1) {
	            throw new Exception("적립 마일리지 회수 실패: 현재 잔액을 확인해 주세요.");
	        }
	
	        int historyResult = rdao.insertMileageHistory(
	                memberId, paymentId, "REVOKE", earnedMileage, "예약 취소로 적립 마일리지 회수");
	        if (historyResult != 1) {
	            throw new Exception("마일리지 회수 내역 저장에 실패했습니다.");
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

}