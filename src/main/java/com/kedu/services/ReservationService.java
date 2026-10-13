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

        // 1. 사용 마일리지 차감
        if (mileage > 0) {
            int mileageResult = rdao.reservationMileage(id, mileage);
            if (mileageResult != 1) {
                throw new Exception("마일리지 차감 실패");
            }
        }

        // 2. 예약 INSERT
        int insertResult = rdao.insert(
                roomDto, checkIn, checkOut, paid, guest, paymentId, session);

        // 3. 예약 INSERT 실패 시 전체 롤백
        if (insertResult != 1) {
            throw new Exception("예약 저장 실패");
        }

        System.out.println("예약 저장 및 마일리지 처리 성공");
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

}