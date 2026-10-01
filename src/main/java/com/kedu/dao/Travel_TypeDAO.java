package com.kedu.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.Travel_TypeDTO;

@Repository
public class Travel_TypeDAO {
	
	@Autowired
	private JdbcTemplate jdbc;
	
	public void insertType(Travel_TypeDTO dto) {
		String sql = "insert into travel_type values(travel_type_seq.nextval, ?, ?, systimestamp, ?, ?, ?, ?, ?, ?)";
		jdbc.update(sql, dto.getMember_id(), dto.getType_code(), dto.getPlan_score(), dto.getExplore_score(),
				dto.getHealing_score(), dto.getEmotion_score(), dto.getFood_score(), dto.getActivity_score());
	}
	
}
