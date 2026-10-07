package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.PlaceRoomDTO;
import com.kedu.dto.RoomDTO;

@Repository
public class RoomDAO {

	@Autowired
	private JdbcTemplate jdbc;

	public List<RoomDTO> detailList(int placeId, String checkIn, String checkOut) {

		// 날짜를 안 고른 경우 — 전체 객실 수를 그대로 보여줌
		if (checkIn == null || checkOut == null) {

			String sql = "select r.*, r.room_count as remain_count " + "from room r " + "where r.place_id = ? "
					+ "order by r.price_weekday";
			return jdbc.query(sql, new BeanPropertyRowMapper<>(RoomDTO.class), placeId);
		}

		// 날짜를 고른 경우 — 겹치는 예약을 빼고 계산
		String sql = "select r.*, " + "  r.room_count - nvl(( " + "      select count(*) "
				+ "        from reservation v " + "       where v.room_id = r.room_id "
				+ "         and nvl(v.status, '예약완료') <> '예약취소' "
				+ "         and v.check_in  < to_date(?, 'YYYY-MM-DD') "
				+ "         and v.check_out > to_date(?, 'YYYY-MM-DD') " + "  ), 0) as remain_count " + "from room r "
				+ "where r.place_id = ? " + "order by r.price_weekday";

		return jdbc.query(sql, new BeanPropertyRowMapper<>(RoomDTO.class), checkOut, checkIn, placeId);
	}

	public RoomDTO roomOne(int roomId) {
		String sql = "select * from room where room_id = ?";
		return jdbc.queryForObject(sql, new BeanPropertyRowMapper<>(RoomDTO.class), roomId);
	}



	public List<PlaceRoomDTO> selectFromTo(int start, int end) {
		String sql = "select * from ( " + "    select a.*, rownum rn from ( " + "        select p.*, "
				+ "          (select min(r.price_weekday) from room r "
				+ "            where r.place_id = p.place_id) as min_price, "
				+ "          (select count(*) from room r "
				+ "            where r.place_id = p.place_id) as room_kind_count, "
				+ "          (select min(r.amenities) from room r "
				+ "            where r.place_id = p.place_id) as amenities " + "          from place p "
				+ "         where p.place_type = 'STAY' "
				+ "           and exists (select 1 from room r where r.place_id = p.place_id) "
				+ "         order by (select min(r.price_weekday) from room r "
				+ "                    where r.place_id = p.place_id) " + "    ) a where rownum <= ? "
				+ ") where rn >= ?";

		return jdbc.query(sql, new BeanPropertyRowMapper<>(PlaceRoomDTO.class), end, start);
	}
}
