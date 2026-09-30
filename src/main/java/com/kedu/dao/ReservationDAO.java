package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.PlaceDTO;

@Repository
public class ReservationDAO {

	@Autowired
	private JdbcTemplate jdbc;

	public PlaceDTO placeOne(int placeId) {
		String sql = "SELECT * FROM Place WHERE place_id = ?";
		return jdbc.queryForObject(sql, new BeanPropertyRowMapper<>(PlaceDTO.class), placeId);
	}
	
	public List<PlaceDTO> roomList() {
		String sql = "SELECT * FROM (" + "  SELECT p.*,"
				+ "         (SELECT MIN(r.price_weekday) FROM Room r WHERE r.place_id = p.place_id) AS min_price,"
				+ "         (SELECT COUNT(*)             FROM Room r WHERE r.place_id = p.place_id) AS room_count,"
				+ "         (SELECT MAX(r.amenities)     FROM Room r WHERE r.place_id = p.place_id) AS amenities,"
				+ "         COALESCE(" + "           (SELECT MAX(r.image1) FROM Room r WHERE r.place_id = p.place_id),"
				+ "           p.image_name" + "         ) AS room_img" + "    FROM Place p"
				+ "   WHERE p.place_type = 'STAY'" + "   ORDER BY p.name" + ") WHERE ROWNUM <= 50";

		return jdbc.query(sql, new BeanPropertyRowMapper<>(PlaceDTO.class));
	}

	public List<PlaceDTO> searchList(PlaceDTO pdto, String[] amenity, Integer maxPrice, String checkIn, String checkOut, Integer adult, Integer child) {

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
		
		Integer guest = null;
		int a = adult.intValue();
		int c = child.intValue();

		String sql =  "SELECT * FROM ("
				+ "  SELECT p.*,"
				+ "         (SELECT MIN(r.price_weekday) FROM Room r WHERE r.place_id = p.place_id) AS min_price,"
				+ "         (SELECT COUNT(*)             FROM Room r WHERE r.place_id = p.place_id) AS room_count,"
				+ "         (SELECT MAX(r.amenities)     FROM Room r WHERE r.place_id = p.place_id) AS amenities,"
				+ "         COALESCE("
				+ "           (SELECT MAX(r.image1) FROM Room r WHERE r.place_id = p.place_id),"
				+ "           p.image_name"
				+ "         ) AS room_img"
				+ "    FROM Place p"
				+ "   WHERE p.place_type = 'STAY'"

				// 지역
				+ "     AND (? IS NULL OR p.region = ?)"

				// 편의시설 5칸
				+ "     AND (? IS NULL OR EXISTS (SELECT 1 FROM Room r"
				+ "                                WHERE r.place_id = p.place_id"
				+ "                                  AND r.amenities LIKE ?))"
				+ "     AND (? IS NULL OR EXISTS (SELECT 1 FROM Room r"
				+ "                                WHERE r.place_id = p.place_id"
				+ "                                  AND r.amenities LIKE ?))"
				+ "     AND (? IS NULL OR EXISTS (SELECT 1 FROM Room r"
				+ "                                WHERE r.place_id = p.place_id"
				+ "                                  AND r.amenities LIKE ?))"
				+ "     AND (? IS NULL OR EXISTS (SELECT 1 FROM Room r"
				+ "                                WHERE r.place_id = p.place_id"
				+ "                                  AND r.amenities LIKE ?))"
				+ "     AND (? IS NULL OR EXISTS (SELECT 1 FROM Room r"
				+ "                                WHERE r.place_id = p.place_id"
				+ "                                  AND r.amenities LIKE ?))"

				// 1박 가격 (최저가 기준)
				+ "     AND (? IS NULL OR"
				+ "          (SELECT MIN(r.price_weekday) FROM Room r"
				+ "            WHERE r.place_id = p.place_id) <= ?)"

				// 인원 + 날짜 : 조건을 만족하는 객실이 하나라도 있어야 함
				+ "     AND EXISTS ("
				+ "           SELECT 1 FROM Room r"
				+ "            WHERE r.place_id = p.place_id"
				+ "              AND (? IS NULL OR r.max_count >= ?)"
				+ "              AND (? IS NULL OR ? IS NULL OR NOT EXISTS ("
				+ "                    SELECT 1 FROM Reservation v"
				+ "                     WHERE v.room_id = r.room_id"
				+ "                       AND NVL(v.status, '예약완료') <> '취소'"
				+ "                       AND v.check_in  < TO_DATE(?, 'YYYY-MM-DD')"
				+ "                       AND v.check_out > TO_DATE(?, 'YYYY-MM-DD')))"
				+ "         )"

				+ "   ORDER BY p.name"
				+ ") WHERE ROWNUM <= 50";

		return jdbc.query(sql, new BeanPropertyRowMapper<>(PlaceDTO.class), pdto.getRegion(), pdto.getRegion(), a1, a1,
				a2, a2, a3, a3, a4, a4, a5, a5, maxPrice, maxPrice, guest, guest, checkIn, checkOut, checkOut, checkIn);
	}
}
