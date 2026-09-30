package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.PlaceDTO;

@Repository
public class PlaceDAO {

	@Autowired
	private JdbcTemplate jdbc;
	
	public List<PlaceDTO> search(String keyword, int start, int end) {

	    String sql = "select * from "
	    	   + "(select Place.*, row_number() over(order by name) rn "
	           + "from Place " 
	           + "where name like ? " 
	           + "or region like ? " 	
	           + "or sigungu LIKE ? " 
	           + "or address LIKE ?) " 
	           + "where rn between ? and ?";

	    String search = "%" + keyword + "%";

	    return jdbc.query(sql, new BeanPropertyRowMapper<>(PlaceDTO.class),
	            search, search, search, search, start, end);
	}
	
	public int searchCount(String keyword) {
		String sql = "select count(*) from Place "
				+ "where name like ? "
				+ "or region like ? "
				+ "or sigungu like ? "
				+ "or address like ?";
		
		String search = "%" + keyword + "%";
		
		return jdbc.queryForObject(sql, Integer.class, search, search, search, search);
	}
}
