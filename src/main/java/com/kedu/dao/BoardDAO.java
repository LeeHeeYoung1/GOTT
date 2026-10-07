package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.BoardDTO;

@Repository
public class BoardDAO {
	
	@Autowired
	private JdbcTemplate jdbc;
	
	public int insert(BoardDTO dto) {
		String sql = "insert into board values(?,?,?,0,systimestamp,?)";
		System.out.println("seq : " + dto.getSeq());
	    System.out.println("title : " + dto.getTitle());
	    System.out.println("writer : " + dto.getWriter());
	    System.out.println("contents : " + dto.getContents());

		 return jdbc.update(sql,
				 	dto.getSeq(),
		            dto.getTitle(),
		            dto.getWriter(),
		            dto.getContents());
	}
	
	public int getNextVal() {
		String sql = "select board_seq.nextval from dual";
		return jdbc.queryForObject(sql, Integer.class);
	}
	
	public List<BoardDTO> selectAll() {
		String sql = "select * from board order by seq desc";
		return jdbc.query(sql, new BeanPropertyRowMapper<>(BoardDTO.class));
	}
	
	public BoardDTO boardContent(int seq) {
		String sql = "select * from board where seq = ?";
		return jdbc.queryForObject(sql, new BeanPropertyRowMapper<>(BoardDTO.class), seq);
	}
	public int viewCount(int seq) {
		String sql = "update board set view_count = view_count + 1 where seq = ?";
		return jdbc.update(sql, seq);
	}
	public int boardCount() {
		String sql = "select count(*) from board";
		return jdbc.queryForObject(sql, Integer.class);
	}
	
	
	public List<BoardDTO> selectFromTo(int start, int end) {
		String sql = "select * from (select board.*, row_number() over(order by seq desc) rn from board) where rn between ? and ?";
		return jdbc.query(sql, new BeanPropertyRowMapper<>(BoardDTO.class),start, end);
	}
}
