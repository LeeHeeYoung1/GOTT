package com.kedu.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class RecommendDAO {

	@Autowired
	private JdbcTemplate jdbc;
	
	public int recommend(int board_seq, String writer) {
	    String sql = "insert into board_recommend values(?, ?, systimestamp)";
	    return jdbc.update(sql, board_seq, writer);
	}
	
	public int recommendCount(int board_seq) {
		String sql = "select count(*) from board_recommend where board_seq = ?";
		return jdbc.queryForObject(sql, Integer.class, board_seq);
	}
	
	public int checkRecommend(int board_seq, String writer) {
		String sql = "select count(*) from board_recommend where board_seq = ? and writer = ?";
		return jdbc.queryForObject(sql, Integer.class, board_seq, writer);
	}
	
	public int deleteRecommend(int board_seq, String writer) {
		String sql = "delete from board_recommend where board_seq = ? and writer = ?";
		return jdbc.update(sql, board_seq, writer);
	}
}
