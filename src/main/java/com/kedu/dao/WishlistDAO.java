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
	

	public int countByWish(String memberId) {
	    String sql = "SELECT COUNT(*) FROM WISHLIST w JOIN PLACE p ON w.TARGET_ID = p.PLACE_ID WHERE w.MEMBER_ID = ?";
	    return jdbc.queryForObject(sql, Integer.class, memberId);
	}

	// 전체 찜 목록 페이지네이션
    public List<PlaceDTO> selectByWish(String memberId, int start, int end) {
        String sql = "SELECT * FROM ("
                + "SELECT p.*, ROW_NUMBER() OVER (ORDER BY w.REG_DATE DESC, w.WISHLIST_ID DESC) AS RN "
                + "FROM WISHLIST w "
                + "JOIN PLACE p ON w.TARGET_ID = p.PLACE_ID "
                + "WHERE w.MEMBER_ID = ?) WHERE RN BETWEEN ? AND ?";
        return jdbc.query(sql, new BeanPropertyRowMapper<>(PlaceDTO.class),
                memberId, start, end);
    }

	// 카테고리별 찜 목록 조회 및 페이지네이션
	public List<PlaceDTO> selectByWish(String memberId, String type, int start, int end) {
		String sql = "SELECT * FROM ("
				+ "SELECT p.*, ROW_NUMBER() OVER (ORDER BY w.REG_DATE DESC, w.WISHLIST_ID DESC) AS RN "
				+ "FROM WISHLIST w " + "JOIN PLACE p ON w.TARGET_ID = p.PLACE_ID "
				+ "WHERE w.MEMBER_ID = ? AND p.PLACE_TYPE = ?" + ") WHERE RN BETWEEN ? AND ?";
	    return jdbc.query(sql, new BeanPropertyRowMapper<>(PlaceDTO.class),
	            memberId, type, start, end);
	}

	// 카테고리별 찜 개수 조회
	public int countByWish(String memberId, String type) {
		String sql = "SELECT COUNT(*) FROM WISHLIST w " + "JOIN PLACE p ON w.TARGET_ID = p.PLACE_ID "
				+ "WHERE w.MEMBER_ID = ? AND p.PLACE_TYPE = ?";
	    return jdbc.queryForObject(sql, Integer.class, memberId, type);
	}
	
}
