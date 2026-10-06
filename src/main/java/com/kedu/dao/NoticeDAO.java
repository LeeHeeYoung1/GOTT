package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.NoticeDTO;

@Repository
public class NoticeDAO {

	@Autowired
	private JdbcTemplate jdbc;
	
	public List<NoticeDTO> list(){
		String sql = "select * from notice";
		return jdbc.query(sql, new BeanPropertyRowMapper<>(NoticeDTO.class));
	}
	
	public NoticeDTO select(int notice_id) {
		String sql = "select * from notice where notice_id = ?";
		return jdbc.queryForObject(sql, new BeanPropertyRowMapper<>(NoticeDTO.class), notice_id);
	}
	
	public int viewCountUpdate(int notice_id) {
		String sql = "update notice set view_count = view_count + 1 where notice_id = ?";
		return jdbc.update(sql, notice_id);
	}
}
