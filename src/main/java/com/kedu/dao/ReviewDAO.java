package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.ReviewDTO;

@Repository
public class ReviewDAO {
	
	@Autowired
	private JdbcTemplate jdbc;
	
	public int insert(ReviewDTO dto) {
		String sql = "insert into review values(review_seq.nextval, ?, ?, ?, ?, systimestamp, ?, ?, ?)";
		
		return jdbc.update(sql, dto.getMember_id(), dto.getTarget_type(), dto.getTarget_id(), dto.getRating(), dto.getTag(), dto.getContents(), dto.getImage1());
	}
	
	public List<ReviewDTO> selectAll(){
		String sql = "select * from review order by seq desc";
		return jdbc.query(sql, new BeanPropertyRowMapper<>(ReviewDTO.class));
	}
}
