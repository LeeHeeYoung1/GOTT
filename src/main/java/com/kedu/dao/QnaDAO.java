package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.QnaDTO;

@Repository
public class QnaDAO {
	
	@Autowired
	private JdbcTemplate jdbc;
	
	public int insert(QnaDTO dto) {

	    String sql = "insert into qna values(?, ?, ?, ?, ?, systimestamp, ?, null, ?, 0)";

	    return jdbc.update(sql,
	            dto.getQid(),
	            dto.getMember_id(),
	            dto.getPw() == null ? "" : dto.getPw(),
	            dto.getTitle(),
	            dto.getContents(),
	            dto.getStatus(),
	            dto.getIs_private()
	    );
	}
	
	public int updateViewCount(int qid) {
	    String sql = "update qna set view_count = view_count + 1 where qid = ?";
	    jdbc.update(sql, qid);

	    sql = "select view_count from qna where qid = ?";
	    return jdbc.queryForObject(sql, Integer.class, qid);
	}
	
	public List<QnaDTO> selectQnaList(int start, int end, String keyword) {
	    String sql = "select * from (" +
	            "select q.*, m.nickname as nickname, " +
	            "row_number() over(order by q.qid desc) rn " +
	            "from qna q " +
	            "join members m on q.member_id = m.id " +
	            "where q.title like ? " +
	            "or q.contents like ? " +
	            "or m.nickname like ?" +
	            ") where rn between ? and ?";

	    String searchKeyword = "%" + keyword + "%";

	    return jdbc.query(sql,
	            new BeanPropertyRowMapper<>(QnaDTO.class),
	            searchKeyword, searchKeyword, searchKeyword, start, end);
	}
	
	public int qnaCount(String keyword) {
	    String sql = "select count(*) " +
	            "from qna q " +
	            "join members m on q.member_id = m.id " +
	            "where q.title like ? " +
	            "or q.contents like ? " +
	            "or m.nickname like ?";

	    String searchKeyword = "%" + keyword + "%";

	    return jdbc.queryForObject(sql, Integer.class,
	            searchKeyword, searchKeyword, searchKeyword);
	}
	
	public QnaDTO qnaContent(int qid) {
	    String sql = "select q.*, m.nickname as nickname "
	            + "from qna q "
	            + "join members m on q.member_id = m.id "
	            + "where q.qid = ?";

	    return jdbc.queryForObject(sql,
	            new BeanPropertyRowMapper<>(QnaDTO.class), qid);
	}
	
	public int insertReply(int qid, String reply) {
	    String sql = "update qna "
	            + "set reply = ?, status = '답변완료' "
	            + "where qid = ? and reply is null";

	    return jdbc.update(sql, reply, qid);
	}
	
	public int updateReply(int qid, String reply) {
	    String sql = "update qna "
	            + "set reply = ?, status = '답변완료' "
	            + "where qid = ? and reply is not null";

	    return jdbc.update(sql, reply, qid);
	}

	public int deleteReply(int qid) {
	    String sql = "update qna "
	            + "set reply = null, status = '답변대기' "
	            + "where qid = ? and reply is not null";

	    return jdbc.update(sql, qid);
	}
	
	public int getNextVal() {
	    String sql = "select qna_seq.nextval from dual";
	    return jdbc.queryForObject(sql, Integer.class);
	}
}
