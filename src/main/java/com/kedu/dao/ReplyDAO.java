package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.ReplyDTO;

@Repository
public class ReplyDAO {
	
	@Autowired
	private JdbcTemplate jdbc;
	
	public int insert(ReplyDTO dto) {
		String sql = "insert into reply values(reply_seq.nextval, ?, null, ?, ?, systimestamp)";
		return jdbc.update(sql, dto.getBoard_seq(), dto.getWriter(), dto.getContents());
	}
	
	 public List<ReplyDTO> selectByBoard(int board_seq) {

	        String sql = "select * from reply where board_seq = ? order by seq";

	        return jdbc.query(sql, new BeanPropertyRowMapper<>(ReplyDTO.class), board_seq);
	    }
	 
	 public int update(String contents, int seq, String writer) {
		 	
		 String sql = "update reply set contents = ? where seq = ? and writer = ?";
		 return jdbc.update(sql, contents, seq, writer);
	 }
	 
	 public int delete(int seq, String writer) {
		 String sql = "delete from reply where seq = ? and writer = ?";
		 return jdbc.update(sql, seq, writer);
	 }
	 
}
