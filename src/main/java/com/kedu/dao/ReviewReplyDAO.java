package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.ReviewReplyDTO;

@Repository
public class ReviewReplyDAO {

	@Autowired
	private JdbcTemplate jdbc;

	public int insert(ReviewReplyDTO dto) {
		if (dto.getParent_seq() == null) {
			String sql = "insert into review_reply (seq, review_seq, member_id, contents) values (review_reply_seq.nextval, ?, ?, ?)";
			return jdbc.update(sql, dto.getReview_seq(), dto.getMember_id(), dto.getContents());
		}

		String sql = "insert into review_reply values (review_reply_seq.nextval, ?, ?, ?, systimestamp, ?)";
		return jdbc.update(sql, dto.getReview_seq(), dto.getMember_id(), dto.getContents(), dto.getParent_seq());
	}

	public List<ReviewReplyDTO> selectAll(int review_seq) {
		String sql = "select rp.*, (select m.nickname from members m where m.id = rp.member_id) as nickname from review_reply rp "
				+ " where rp.review_seq = ? and rp.parent_seq is null order by rp.seq desc";
		return jdbc.query(sql, new BeanPropertyRowMapper<>(ReviewReplyDTO.class), review_seq);
	}

	public int delete(int seq) {
		String sql = "delete from review_reply where seq = ?";
		return jdbc.update(sql, seq);
	}
	
	public int update(int seq, String contents) {
		String sql = "update review_reply set contents = ? where seq = ?";
		return jdbc.update(sql, contents, seq);
	}
	
	public List<ReviewReplyDTO> selectChild(int review_seq) {
		String sql = "select rp.*, (select m.nickname from members m where m.id = rp.member_id) as nickname from review_reply rp "
				+ " where rp.review_seq = ? and rp.parent_seq is not null order by rp.seq asc";
		return jdbc.query(sql, new BeanPropertyRowMapper<>(ReviewReplyDTO.class), review_seq);
	}
	
	
}