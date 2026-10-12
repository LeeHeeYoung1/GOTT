package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.BannerDTO;

@Repository
public class BannerDAO {

	@Autowired
	private JdbcTemplate jdbc;
	
	BannerDTO bannerdto;
	
	public List<BannerDTO> getBannerList() {

		 String sql = "SELECT BANNER_ID, TITLE, IMAGE_NAME, LINK_URL, "
                 + "START_DATE, END_DATE, SORT_ORDER, CONTENT "
                 + "FROM BANNER "
                 + "ORDER BY SORT_ORDER ASC";

        return jdbc.query(sql, new BeanPropertyRowMapper<>(BannerDTO.class));
    }
	
}
