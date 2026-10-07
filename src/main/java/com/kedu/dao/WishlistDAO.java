package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.PlaceDTO;



@Repository
public class WishlistDAO {
	
	@Autowired
	private JdbcTemplate jdbc;
	
	public int wishlistAdd(String memberId, int placeId) {
		String typeSql = "select place_type from place where place_id = ?";
		String placeType = jdbc.queryForObject(typeSql, String.class, placeId);
		String sql = "INSERT INTO WISHLIST (WISHLIST_ID, MEMBER_ID, TARGET_TYPE, TARGET_ID, REG_DATE) "
					+ "VALUES (WISHLIST_SEQ.NEXTVAL, ?, ?, ?, SYSDATE)";
		return jdbc.update(sql, memberId, placeType, placeId);
	}
	
	public int wishlistDelete(String memberId, int placeId) {
		String sql = "DELETE FROM WISHLIST WHERE MEMBER_ID = ? AND TARGET_ID = ?";
		return jdbc.update(sql, memberId, placeId);
	}
	
	public int wishlistCheck(String memberId, int placeId) {
		String sql = "SELECT COUNT(*) FROM WISHLIST WHERE MEMBER_ID = ? AND TARGET_ID = ?";
		return jdbc.queryForObject(sql, Integer.class, memberId, placeId);
	}
	
	public List<PlaceDTO> selectByWish(String memberId) {
	    String sql = "select p.* from Wishlist w join Place p on w.target_id = p.place_id where w.member_id = ? order by w.reg_date desc";
	    return jdbc.query(sql, new BeanPropertyRowMapper<>(PlaceDTO.class), memberId);
	}
}
