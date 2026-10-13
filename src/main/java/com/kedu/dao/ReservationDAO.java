package com.kedu.dao;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.commons.NullZeroUtil;
import com.kedu.commons.PriceUtil;
import com.kedu.dto.PlaceDTO;
import com.kedu.dto.PlaceRoomDTO;
import com.kedu.dto.ReservationDTO;
import com.kedu.dto.RoomDTO;

@Repository
public class ReservationDAO {

	@Autowired
	private JdbcTemplate jdbc;

	public PlaceDTO placeOne(int placeId) {
		String sql = "SELECT * FROM Place WHERE place_id = ?";
		return jdbc.queryForObject(sql, new BeanPropertyRowMapper<>(PlaceDTO.class), placeId);
	}

	public int insert(RoomDTO dto, String checkIn, String checkOut, int price, int guest, String paymentId, HttpSession session) {
	    String sql = "INSERT INTO RESERVATION (SEQ, MEMBER_ID, RESERVE_DATE, PRICE, CHECK_IN, CHECK_OUT, GUEST_NUM, STATUS, MILEAGE, ROOM_ID, PAYMENT_ID, TOTAL_PRICE) "
	            + "VALUES (RESERVATION_SEQ.NEXTVAL, ?, SYSTIMESTAMP, ?, ?, ?, ?, '예약완료', ?, ?, ?, ?)";
	    int mileage = (int)(price * 0.05);
		return jdbc.update(sql, session.getAttribute("loginId"), price, checkIn, checkOut, guest, mileage,
				dto.getRoomId(), paymentId,PriceUtil.totalPrice(checkIn, checkOut, dto.getPriceWeekday(), dto.getPriceWeekend()));
	}
	
	public int delete(String paymentId) {
		String sql = "update reservation set status = '예약취소' where payment_Id = ?";
	    return jdbc.update(sql,paymentId);
	}
	
	public int reservationMileage(String id,int mileage) {
		String sql = "update members set mileage = mileage - ? where id = ? and mileage >= ?";
		return jdbc.update(sql,mileage,id,mileage);
	}
	
	public ArrayList<ReservationDTO> myRsList(String memberId) {
		String sql = "SELECT reservation.*, room.room_name, room.image1 " + "FROM reservation " + "JOIN room "
				+ "ON reservation.room_id = room.room_id " + "WHERE reservation.member_id = ? "
				+ "ORDER BY reservation.reserve_date DESC";
		ArrayList<ReservationDTO> list = (ArrayList<ReservationDTO>) jdbc.query(sql, new BeanPropertyRowMapper<>(ReservationDTO.class), memberId);
		return list;
	}
	
	// 이용 예정 예약 목록
	public ArrayList<ReservationDTO> myUpcomingList(String memberId) {
	    String sql = "SELECT r.*, rm.room_name, rm.image1 "
	            + "FROM reservation r "
	            + "JOIN room rm ON r.room_id = rm.room_id "
	            + "WHERE r.member_id = ? "
	            + "AND r.status = '예약완료' "
	            + "AND r.check_out >= TRUNC(SYSDATE) "
	            + "ORDER BY r.check_in ASC";
	    return (ArrayList<ReservationDTO>) jdbc.query(
	            sql,
	            new BeanPropertyRowMapper<>(ReservationDTO.class),
	            memberId
	    );
	}

	// 이용 완료 예약 목록
	public ArrayList<ReservationDTO> myCompletedList(String memberId) {
	    String sql = "SELECT r.*, rm.room_name, rm.image1,\r\n"
	    		+ "       CASE\r\n"
	    		+ "           WHEN r.status = '예약취소' THEN 'cancelled'\r\n"
	    		+ "           WHEN r.check_out < TRUNC(SYSDATE) THEN 'completed'\r\n"
	    		+ "           ELSE 'upcoming'\r\n"
	    		+ "       END AS reservation_type\r\n"
	    		+ "FROM reservation r\r\n"
	    		+ "JOIN room rm ON r.room_id = rm.room_id\r\n"
	    		+ "WHERE r.member_id = ?\r\n"
	    		+ "ORDER BY r.reserve_date DESC";
	    return (ArrayList<ReservationDTO>) jdbc.query(
	            sql,
	            new BeanPropertyRowMapper<>(ReservationDTO.class),
	            memberId
	    );
	}
	
	// 다가오는 예약 건수
	public int upcomingReservationCount(String memberId) {
	    String sql = "SELECT COUNT(*) FROM reservation "
	            + "WHERE member_id = ? "
	            + "AND status = '예약완료' "
	            + "AND check_out >= TRUNC(SYSDATE)";
	    return jdbc.queryForObject(sql, Integer.class, memberId);
	}
	
	public int reservationCount(String memberId) {
	    String sql = "SELECT COUNT(*) FROM reservation WHERE member_id = ?";
	    return jdbc.queryForObject(sql, Integer.class, memberId);
	}
	
	public int updateReservation(String paymentId, String status) {
	    String sql = "UPDATE RESERVATION SET status = ? WHERE payment_Id = ?";
	    return jdbc.update(sql, status, paymentId);
	}
	
	public ArrayList<ReservationDTO> myRsList(String memberId, int cpage, int pagesize) {
	    int start = (cpage - 1) * pagesize + 1;
	    int end = cpage * pagesize;

	    String sql = "SELECT * FROM ( "
	            + "SELECT reservation.*, room.room_name, room.image1, "
	            + "ROW_NUMBER() OVER (ORDER BY reservation.reserve_date DESC) AS rn "
	            + "FROM reservation "
	            + "JOIN room ON reservation.room_id = room.room_id "
	            + "WHERE reservation.member_id = ? "
	            + ") WHERE rn BETWEEN ? AND ?";

	    ArrayList<ReservationDTO> list = (ArrayList<ReservationDTO>) jdbc.query(
	            sql,
	            new BeanPropertyRowMapper<>(ReservationDTO.class),
	            memberId, start, end
	    );

	    return list;
	}
	public ReservationDTO reservationOne(String paymentId) {
	    String sql = "SELECT r.*, rm.room_name, rm.image1, rm.place_id "
	            + "FROM reservation r "
	            + "JOIN room rm ON r.room_id = rm.room_id "
	            + "WHERE r.payment_id = ?";
	    return jdbc.queryForObject(sql, new BeanPropertyRowMapper<>(ReservationDTO.class), paymentId);
	}
	
	public int updateReservationDetails(String paymentId, String memberId, int roomId,
	        java.sql.Date checkIn, java.sql.Date checkOut, int guestNum, int totalPrice) {
	    String sql = "UPDATE RESERVATION SET ROOM_ID = ?, CHECK_IN = ?, CHECK_OUT = ?, "
	            + "GUEST_NUM = ?, TOTAL_PRICE = ? "
	            + "WHERE PAYMENT_ID = ? AND MEMBER_ID = ? AND STATUS = '예약완료'";
	    return jdbc.update(sql, roomId, checkIn, checkOut, guestNum,totalPrice, paymentId, memberId);
	}
	
	public int ReservationHistory(int reservationSeq, String paymentId, String reservationPaymentId, String memberId, String paymentType, int amount, String status) {
	    String sql = "INSERT INTO RESERVATION_HISTORY (HISTORY_ID, RESERVATION_SEQ, PAYMENT_ID, RESERVATION_PAYMENT_ID, MEMBER_ID, PAYMENT_TYPE, AMOUNT, STATUS, CREATED_AT) "
	            + "VALUES (RESERVATION_HISTORY_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, SYSTIMESTAMP)";
	    return jdbc.update(sql, reservationSeq, paymentId, reservationPaymentId, memberId, paymentType, amount, status);
	}
	
	public int updateReservationAfterAdditionalPayment(String paymentId, String memberId,
	        int roomId, java.sql.Date checkIn, java.sql.Date checkOut,
	        int guestNum, int additionalPaid, int newTotalPrice) {
	    String sql = "UPDATE RESERVATION SET ROOM_ID = ?, CHECK_IN = ?, CHECK_OUT = ?, "
	            + "GUEST_NUM = ?, PRICE = PRICE + ?, TOTAL_PRICE = ? "
	            + "WHERE PAYMENT_ID = ? AND MEMBER_ID = ? AND STATUS = '예약완료'";
	    return jdbc.update(sql, roomId, checkIn, checkOut, guestNum,
	            additionalPaid, newTotalPrice, paymentId, memberId);
	}
	
	public int updateReservationAfterRefund(String paymentId, String memberId, int roomId, java.sql.Date checkIn,
			java.sql.Date checkOut, int guestNum, int refundAmount, int newTotalPrice) {
		String sql = "UPDATE RESERVATION SET ROOM_ID = ?, CHECK_IN = ?, CHECK_OUT = ?, "
				+ "GUEST_NUM = ?, PRICE = PRICE - ?, TOTAL_PRICE = ? "
				+ "WHERE PAYMENT_ID = ? AND MEMBER_ID = ? AND STATUS = '예약완료' AND PRICE >= ?";
		return jdbc.update(sql, roomId, checkIn, checkOut, guestNum, refundAmount, newTotalPrice, paymentId, memberId,
				refundAmount);
	}
	
	public int countRePaymentHistory(String newPaymentId) {
	    String sql = "SELECT COUNT(*) FROM RESERVATION_HISTORY WHERE RESERVATION_PAYMENT_ID = ?";
	    return jdbc.queryForObject(sql, Integer.class, newPaymentId);
	}
	
	
	public int selectCount() {
		String sql = "select count(*) from place p " + " where p.place_type = 'STAY' "
				+ "   and exists (select 1 from room r where r.place_id = p.place_id)";
		return jdbc.queryForObject(sql, Integer.class);
	}
	public List<PlaceRoomDTO> searchFromTo(PlaceDTO pdto, String[] amenity, Integer maxPrice, String checkIn,
			String checkOut, Integer adult, Integer child, int start, int end) {

		String a1 = null;
		String a2 = null;
		String a3 = null;
		String a4 = null;
		String a5 = null;

		if (amenity != null) {
			if (amenity.length > 0)
				a1 = "%" + amenity[0] + "%";
			if (amenity.length > 1)
				a2 = "%" + amenity[1] + "%";
			if (amenity.length > 2)
				a3 = "%" + amenity[2] + "%";
			if (amenity.length > 3)
				a4 = "%" + amenity[3] + "%";
			if (amenity.length > 4)
				a5 = "%" + amenity[4] + "%";
		}

		String region = NullZeroUtil.nullZero(pdto.getRegion());
		String in = NullZeroUtil.nullZero(checkIn);
		String out = NullZeroUtil.nullZero(checkOut);

		int a = (adult == null) ? 0 : adult;
		int c = (child == null) ? 0 : child;
		Integer guest = (a + c > 0) ? Integer.valueOf(a + c) : null;

		String sql = "select * from ("
				+ "select x.*, rownum rn from ("
				+ "select t.place_id, t.name, t.region, t.address, t.place_type, t.image_name, t.latitude, t.longitude, t.avg_rating, "
				+ "min(t.price_weekday) as min_price, sum(t.room_count) as total_room_count, max(t.amenities) as amenities, max(t.image1) as alter_image from "
				+ "(select p.place_id, p.name, p.region, p.address, p.place_type, p.image_name, p.latitude, p.longitude, p.avg_rating, "
				+ "r.price_weekday, r.room_count, r.amenities, r.image1 " + "from place p "
				+ "join room r on p.place_id = r.place_id " + "where p.place_type='STAY' "

				// 지역
				+ "and (? is null or p.region = ?) "

				// 편의시설 5칸
				+ "and (? is null or r.amenities like ?) " + "and (? is null or r.amenities like ?) "
				+ "and (? is null or r.amenities like ?) " + "and (? is null or r.amenities like ?) "
				+ "and (? is null or r.amenities like ?) "

				// 인원
				+ "and (? is null or r.max_count >= ?) "

				// 날짜 겹침
				+ "and (? is null or ? is null or not exists (" + "      select 1 from reservation v "
				+ "       where v.room_id = r.room_id " + "         and nvl(v.status, '예약완료') <> '예약취소' "
				+ "         and v.check_in  < to_date(?, 'YYYY-MM-DD') "
				+ "         and v.check_out > to_date(?, 'YYYY-MM-DD'))) "

				+ ") t "
				+ "group by t.place_id, t.name, t.region, t.address, t.place_type, t.image_name, t.latitude, t.longitude, t.avg_rating "

				// 1박 가격 — 집계 결과를 거르니 having
				+ "having (? is null or min(t.price_weekday) <= ?) " + "order by min(t.price_weekday)"
				+ ") x where rownum <= ?"
				+ ") where rn >= ?";

		return jdbc.query(sql, new BeanPropertyRowMapper<>(PlaceRoomDTO.class), region, region, a1, a1, a2, a2, a3, a3,
				a4, a4, a5, a5, guest, guest, in, out, out, in, maxPrice, maxPrice, end, start);
	}
	
	public int searchCount(PlaceDTO pdto, String[] amenity, Integer maxPrice, String checkIn, String checkOut,
			Integer adult, Integer child) {

		String a1 = null;
		String a2 = null;
		String a3 = null;
		String a4 = null;
		String a5 = null;

		if (amenity != null) {
			if (amenity.length > 0)
				a1 = "%" + amenity[0] + "%";
			if (amenity.length > 1)
				a2 = "%" + amenity[1] + "%";
			if (amenity.length > 2)
				a3 = "%" + amenity[2] + "%";
			if (amenity.length > 3)
				a4 = "%" + amenity[3] + "%";
			if (amenity.length > 4)
				a5 = "%" + amenity[4] + "%";
		}

		String region = NullZeroUtil.nullZero(pdto.getRegion());
		String in = NullZeroUtil.nullZero(checkIn);
		String out = NullZeroUtil.nullZero(checkOut);

		int a = (adult == null) ? 0 : adult;
		int c = (child == null) ? 0 : child;
		Integer guest = (a + c > 0) ? Integer.valueOf(a + c) : null;

		String sql = "select count(*) from ("
				+ "select t.place_id from "
				+ "(select p.place_id, p.region, p.place_type, "
				+ "r.price_weekday, r.room_count, r.amenities, r.max_count, r.room_id " + "from place p "
				+ "join room r on p.place_id = r.place_id " + "where p.place_type='STAY' "

				+ "and (? is null or p.region = ?) "

				+ "and (? is null or r.amenities like ?) " + "and (? is null or r.amenities like ?) "
				+ "and (? is null or r.amenities like ?) " + "and (? is null or r.amenities like ?) "
				+ "and (? is null or r.amenities like ?) "

				+ "and (? is null or r.max_count >= ?) "

				+ "and (? is null or ? is null or not exists (" + "      select 1 from reservation v "
				+ "       where v.room_id = r.room_id " + "         and nvl(v.status, '예약완료') <> '예약취소' "
				+ "         and v.check_in  < to_date(?, 'YYYY-MM-DD') "
				+ "         and v.check_out > to_date(?, 'YYYY-MM-DD'))) "

				+ ") t "
				+ "group by t.place_id "
				+ "having (? is null or min(t.price_weekday) <= ?)"
				+ ")";

		return jdbc.queryForObject(sql, Integer.class, region, region, a1, a1, a2, a2, a3, a3,
				a4, a4, a5, a5, guest, guest, in, out, out, in, maxPrice, maxPrice);
	}
}
