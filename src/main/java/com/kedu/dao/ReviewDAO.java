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
	
	public List<ReviewDTO> selectFromTo(int start, int end){
		String sql = "select * from (select review.*, ROW_NUMBER() OVER(order by seq desc)rn from review) where rn between ? and ?";
		return jdbc.query(sql, new BeanPropertyRowMapper<>(ReviewDTO.class), start, end);
	}
	
	public int selectCount() {
		String sql = "select count(*) from review";
		return jdbc.queryForObject(sql, Integer.class);
	}
	
	public ReviewDTO selectOne(int seq) {
		String sql = "select * from review where seq = ?";
		return jdbc.queryForObject(sql, new BeanPropertyRowMapper<>(ReviewDTO.class), seq);
	}
	
	public String nicknameSearch(int seq) {
		String sql = "select (select m.nickname from members m where m.id = r.member_id) from review r where r.seq = ?"; 
		return jdbc.queryForObject(sql, String.class, seq);
	}
	
	public String targetSearch(int target_id) {
		String sql = "select name from place where place_id = ?";
		return jdbc.queryForObject(sql, String.class, target_id);
	}
	
	public int delete(int seq) {
		String sql = "delete from review where seq = ?";
		return jdbc.update(sql, seq);
	}
}
