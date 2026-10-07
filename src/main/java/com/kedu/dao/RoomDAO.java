package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.PlaceDTO;
import com.kedu.dto.RoomDTO;

@Repository
public class RoomDAO {
	
	@Autowired
	private JdbcTemplate jdbc;
	
	public List<RoomDTO> detailList(int placeId, String checkIn, String checkOut) {

		// 날짜를 안 고른 경우 — 전체 객실 수를 그대로 보여줌
		if (checkIn == null || checkOut == null) {

			String sql = "select r.*, r.room_count as remain_count "
					+ "from room r "
					+ "where r.place_id = ? "
					+ "order by r.price_weekday";
			return jdbc.query(sql, new BeanPropertyRowMapper<>(RoomDTO.class), placeId);
		}

		// 날짜를 고른 경우 — 겹치는 예약을 빼고 계산
		String sql = "select r.*, "
				+ "  r.room_count - nvl(( "
				+ "      select count(*) "
				+ "        from reservation v "
				+ "       where v.room_id = r.room_id "
				+ "         and nvl(v.status, '예약완료') <> '예약취소' "
				+ "         and v.check_in  < to_date(?, 'YYYY-MM-DD') "
				+ "         and v.check_out > to_date(?, 'YYYY-MM-DD') "
				+ "  ), 0) as remain_count "
				+ "from room r "
				+ "where r.place_id = ? "
				+ "order by r.price_weekday";

		return jdbc.query(sql, new BeanPropertyRowMapper<>(RoomDTO.class),
				checkOut, checkIn, placeId);
	}
	
	public RoomDTO roomOne(int roomId) {
		String sql = "select * from room where room_id = ?";
		return jdbc.queryForObject(sql, new BeanPropertyRowMapper<>(RoomDTO.class), roomId);
	}
}
