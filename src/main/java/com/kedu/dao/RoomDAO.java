package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.RoomDTO;

@Repository
public class RoomDAO {
	
	@Autowired
	private JdbcTemplate jdbc;
	
	public List<RoomDTO> detailList(int placeId){
		String sql = "select * from Room where place_id = ? order by price_weekday";
		return jdbc.query(sql, new BeanPropertyRowMapper<>(RoomDTO.class), placeId);
	}
}
