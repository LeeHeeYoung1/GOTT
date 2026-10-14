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

		 String sql = "SELECT BANNER_ID, TITLE, IMAGE_NAME, LINK_URL "
                 + "FROM BANNER ORDER BY SORT_ORDER ASC";

        return jdbc.query(sql, new BeanPropertyRowMapper<>(BannerDTO.class));
    }
	
	public int insertEvent(BannerDTO dto) {
	    
	    String sql = "INSERT INTO BANNER VALUES (BANNER_SEQ.NEXTVAL, ?, ?, ?, sysdate, sysdate + 30, 1, null)";

	    return jdbc.update(sql, dto.getTitle(),dto.getImage_name(),dto.getLink_url());
	}
	
	public int deleteEvent(int banner_id) {
		String sql = "delete from banner where banner_id = ?";
		return jdbc.update(sql, banner_id);
	}
}
