package com.kedu.services;

import javax.servlet.http.HttpSession;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.kedu.dao.ReservationDAO;
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
}