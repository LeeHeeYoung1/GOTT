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
	    String sql;

	    if (dto.getParent_seq() == null) {
	        sql = "insert into reply values(reply_seq.nextval, ?, null, ?, ?, systimestamp)";
	        return jdbc.update(sql,
	                dto.getBoard_seq(),
	                dto.getWriter(),
	                dto.getContents());
	    } else {
	        sql = "insert into reply values(reply_seq.nextval, ?, ?, ?, ?, systimestamp)";
	        return jdbc.update(sql,
	                dto.getBoard_seq(),
	                dto.getParent_seq(),
	                dto.getWriter(),
	                dto.getContents());
	    }
	}
	
	public List<ReplyDTO> selectByBoard(int board_seq) {
	    String sql = "select * from reply where board_seq = ? "
	            + "order by nvl(parent_seq, seq), "
	            + "case when parent_seq is null then 0 else 1 end, seq";

	    return jdbc.query(sql,
	            new BeanPropertyRowMapper<>(ReplyDTO.class),
	            board_seq);
	}
	 
	 public int update(String contents, int seq, String writer) {
		 	
		 String sql = "update reply set contents = ? where seq = ? and writer = ?";
		 return jdbc.update(sql, contents, seq, writer);
	 }
	 
	 public int delete(int seq) {
		 String sql = "delete from reply where seq = ?";
		 return jdbc.update(sql, seq);
	 }
	 
	 public int deleteByBoard(int seq) {
		 String sql = "delete from reply where board_seq = ?";
		 return jdbc.update(sql, seq);
	 }
	 
	 public int deleteChild(int seq) {
		 String sql = "delete from reply where parent_seq = ?";
		 return jdbc.update(sql, seq);
	 }
	 
	 public int replyCount(int board_seq) {
		    String sql = "select count(*) from reply where board_seq = ?";
		    return jdbc.queryForObject(sql, Integer.class, board_seq);
		}
}
