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
		String sql = "insert into board values(?,?,?,0,systimestamp,?)";
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
	public int count(int seq) {
		String sql = "update board set view_count = view_count + 1 where seq = ?";
		return jdbc.update(sql, seq);
	}
}
