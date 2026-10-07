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
	
	public List<PlaceDTO> search(String keyword,String type, int start, int end) {
	
		String search = "%" + keyword + "%";
		
		if(type.equals("전체")) {
			   String sql = "select * from "
			            + "(select Place.*, row_number() over(order by name) rn "
			            + "from Place "
			            + "where name like ? "
			            + "or region like ? "
			            + "or sigungu like ?) "
			            + "where rn between ? and ?";

	

	    return jdbc.query(sql, new BeanPropertyRowMapper<>(PlaceDTO.class),
	            search, search, search, start, end);
	} else {
		String dbType = type;
		
		if(type.equals("관광지")) {
			dbType = "SPOT";
		}
		
		if(type.equals("맛집")) {
			dbType = "FOOD";
		}
		
		if(type.equals("숙박업소")) {
			dbType = "STAY";
		}
		
		String sql = "select * from "
				+ "(select place.*, row_number() over(order by name) rn "
				+ "from place "
				+ "where (name like ? "
				+ "or region like ? "
				+ "or sigungu like ?) "
				+ "and place_type = ?) "
				+ "where rn between ? and ?";
		
		return jdbc.query(sql, new BeanPropertyRowMapper<>(PlaceDTO.class),search, search, search,
                dbType, start, end);
		}
	}
	
	public int searchCount(String keyword, String type) {

	    String search = "%" + keyword + "%";

	    if(type.equals("전체")) {

	        String sql = "select count(*) from Place "
	                + "where name like ? "
	                + "or region like ? "
	                + "or sigungu like ? ";

	        return jdbc.queryForObject(
	                sql,
	                Integer.class,
	                search, search, search
	        );

	    } else {

	        String dbType = type;

	        if(type.equals("관광지")) {
	            dbType = "SPOT";
	        }

	        if(type.equals("맛집")) {
	            dbType = "FOOD";
	        }

	        if(type.equals("숙박업소")) {
	            dbType = "STAY";
	        }

	        String sql = "select count(*) from Place "
	                + "where (name like ? "
	                + "or region like ? "
	                + "or sigungu like ?) "
	                + "and place_type = ?";

	        return jdbc.queryForObject(
	                sql,
	                Integer.class,
	                search, search, search, dbType
	        );
	    }
	}
	
	public List<String> searchKeyword(String keyword) {

	    String sql = "SELECT area "
	               + "FROM ("
	               + "    SELECT DISTINCT region AS area, 1 AS type_order "
	               + "    FROM Place "
	               + "    WHERE region LIKE ? "
	               + "    UNION "
	               + "    SELECT DISTINCT sigungu AS area, 2 AS type_order "
	               + "    FROM Place "
	               + "    WHERE sigungu LIKE ? "
	               + ") "
	               + "ORDER BY "
	               + "type_order, "
	               + "CASE WHEN area LIKE ? THEN 1 ELSE 2 END, "
	               + "area";

	    String search = "%" + keyword + "%";
	    String startSearch = keyword + "%";

	    return jdbc.queryForList(
	        sql,
	        String.class,
	        search,
	        search,
	        startSearch
	    );
	}
	
	public List<PlaceDTO> placeList(String placeType, String region){
		String sql = "select * from place where place_type = ? and region = ?";
		return jdbc.query(sql, new BeanPropertyRowMapper<>(PlaceDTO.class), placeType, region);
	}
}
