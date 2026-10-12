package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.FaqDTO;

@Repository
public class FaqDAO {

	@Autowired
	private JdbcTemplate jdbc;
	
	public int insert(FaqDTO dto) {
	    String sql = "insert into faq values(faq_seq.nextval, ?, ?, ?, sysdate)";
	    return jdbc.update(sql, dto.getWriter(), dto.getTitle(), dto.getContent());
	}
	
	
	
	public List<FaqDTO> faqList() {
	    String sql = "select * from faq order by faq_id desc";
	    return jdbc.query(sql, new BeanPropertyRowMapper<>(FaqDTO.class));
	}
}
