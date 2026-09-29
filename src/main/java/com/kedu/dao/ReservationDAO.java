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
	
	public List<PlaceDTO> roomList(){
		String sql = "SELECT * FROM ("
				+ "  SELECT p.*,"
				+ "         (SELECT MIN(r.price_weekday) FROM Room r WHERE r.place_id = p.place_id) AS min_price,"
				+ "         (SELECT COUNT(*)             FROM Room r WHERE r.place_id = p.place_id) AS room_count,"
				+ "         COALESCE("
				+ "           (SELECT MAX(r.image1) FROM Room r WHERE r.place_id = p.place_id),"
				+ "           p.image_name"
				+ "         ) AS room_img"
				+ "    FROM Place p"
				+ "   WHERE p.place_type = 'STAY'"
				+ "   ORDER BY CASE WHEN p.image_name IS NULL THEN 1 ELSE 0 END,"
				+ "            p.name"
				+ ") WHERE ROWNUM <= 50";
		
		return jdbc.query(sql, new BeanPropertyRowMapper<>(PlaceDTO.class));
	}
	
	public List<PlaceDTO> searchList(PlaceDTO pdto){
		String sql = "SELECT * FROM ("
				+ "  SELECT p.*,"
				+ "         (SELECT MIN(r.price_weekday) FROM Room r WHERE r.place_id = p.place_id) AS min_price,"
				+ "         (SELECT COUNT(*)             FROM Room r WHERE r.place_id = p.place_id) AS room_count,"
				+ "         COALESCE("
				+ "           (SELECT MAX(r.image1) FROM Room r WHERE r.place_id = p.place_id),"
				+ "           p.image_name"
				+ "         ) AS room_img"
				+ "    FROM Place p"
				+ "   WHERE p.place_type = 'STAY' AND region = ? "
				+ "   ORDER BY CASE WHEN p.image_name IS NULL THEN 1 ELSE 0 END,"
				+ "            p.name"
				+ ") WHERE ROWNUM <= 50";
		
		return jdbc.query(sql, new BeanPropertyRowMapper<>(PlaceDTO.class), pdto.getRegion());
	}
}
