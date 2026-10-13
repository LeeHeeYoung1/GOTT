package com.kedu.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ReviewRecommendDAO {

	@Autowired
	private JdbcTemplate jdbc;

	public int recommendUp(int seq, String loginId) {
		String sql = "insert into review_recommend (review_seq, member_id) values (?, ?)";
		return jdbc.update(sql, seq, loginId);
	}

	public int recommendDown(int seq, String loginId) {
		String sql = "delete from review_recommend where review_seq = ? and member_id = ?";
		return jdbc.update(sql, seq, loginId);
	}

	public int recommendCount(int seq) {
		String sql = "select count(*) from review_recommend where review_seq = ?";
		return jdbc.queryForObject(sql, Integer.class, seq);
	}

	public boolean isRecommend(int seq, String loginId) {
		String sql = "select count(*) from review_recommend where review_seq = ? and member_id = ?";
		return jdbc.queryForObject(sql, Integer.class, seq, loginId) > 0;
	}

	
}