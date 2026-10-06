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
		  System.out.println("title = " + dto.getTitle());
		    System.out.println("contents = " + dto.getContents());
		    System.out.println("writer = " + dto.getWriter());
		String sql = "insert into board values(board_seq.nextval, ?, ?, ?, 0, systimestamp)";
		 return jdbc.update(sql,
		            dto.getTitle(),
		            dto.getContents(),
		            dto.getWriter());
	}
	
	public List<BoardDTO> selectAll() {
		String sql = "select * from board order by seq desc";
		return jdbc.query(sql, new BeanPropertyRowMapper<>(BoardDTO.class));
	}
	
	public BoardDTO boardContent(int seq) {
		String sql = "select * from board where seq = ?";
		return jdbc.queryForObject(sql, new BeanPropertyRowMapper<>(BoardDTO.class), seq);
	}
}
