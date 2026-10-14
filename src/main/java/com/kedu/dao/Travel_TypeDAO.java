package com.kedu.dao;

import java.util.List;

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
	
	public String selectMyType(String memberId) {
	    String sql = "select type_code from ("
	            + "select type_code from travel_type "
	            + "where member_id = ? "
	            + "order by reg_date desc"
	            + ") where rownum = 1";

	    List<String> list = jdbc.queryForList(sql, String.class, memberId);

	    if (list.size() > 0) {
	        return list.get(0);
	    }

	    return null;
	}
	
}
