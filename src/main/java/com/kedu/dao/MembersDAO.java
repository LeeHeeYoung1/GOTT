package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.kedu.commons.EncryptionUtils;
import com.kedu.dto.MembersDTO;
import com.kedu.dto.MileageHistoryDTO;

@Repository
public class MembersDAO {
	
	@Autowired
	private JdbcTemplate jdbc;
	
	public int login(MembersDTO mdto) {
		
		String pw = EncryptionUtils.encryptSHA512(mdto.getPw());
		String sql = "select count(*) from members where id=? and pw=?";
		return jdbc.queryForObject(sql, Integer.class, mdto.getId(), pw);
	}
	
	public int idcheck(String id) {
		String sql = "select count(*) from members where id =?";
		return jdbc.queryForObject(sql, Integer.class, id);
	}
	
	public int nicknamecheck(String nickname) {
		String sql = "select count(*) from members where nickname=?";
		return jdbc.queryForObject(sql, Integer.class, nickname);
	}
	

	@Transactional
	public int signup(MembersDTO mdto) {
	    String sql = "INSERT INTO members VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSTIMESTAMP, 2000, 'user', ?)";
	    int result = jdbc.update(sql, mdto.getId(), mdto.getPw(), mdto.getName(), mdto.getNickname(),
	            mdto.getPhone(), mdto.getEmail(), mdto.getGender(), mdto.getDob(), mdto.getZipcode(),
	            mdto.getAddress1(), mdto.getAddress2(), mdto.getPrivacy_agree());
	
	    if (result > 0) {
	        String mileageSql = "INSERT INTO MILEAGE_HISTORY "
	                + "(SEQ, MEMBER_ID, RESERVATION_ID, PAYMENT_ID, TYPE, AMOUNT, BALANCE, REASON, REG_DATE) "
	                + "VALUES (MILEAGE_HISTORY_SEQ.NEXTVAL, ?, NULL, NULL, ?, ?, ?, ?, SYSDATE)";
	
	        jdbc.update(mileageSql, mdto.getId(), "적립", 2000, 2000, "회원가입 축하 마일리지");
	    }
	
	    return result;
	}
	
	public boolean checkPassword(String id,String password) {
		String sql = "select count(*) from members where id = ? and pw = ?";
		
		Integer count = jdbc.queryForObject(sql, Integer.class,id,password);
		return count != null && count > 0;
	}

	
	public MembersDTO selectById(String id) {
		String sql = "select * from members where id=?";
		return jdbc.queryForObject(sql, new BeanPropertyRowMapper<>(MembersDTO.class), id);
	}
	
	public int getMileage(String memberId) {
	    String sql = "SELECT mileage FROM members WHERE id = ?";
	    return jdbc.queryForObject(sql, Integer.class, memberId);
	}

	public int deleted(String id, MembersDTO mdto) {
	    String sql = "delete from members where id = ? and pw = ?";
	    return jdbc.update(sql, id, mdto.getPw());
	}
	
	public int update(MembersDTO mdto) {
		String sql = "update members set nickname = ?,phone = ?, email = ?, zipcode = ?, address1 = ?, address2 = ? WHERE id = ?";
		return jdbc.update(sql, mdto.getNickname(),mdto.getPhone(), mdto.getEmail(), mdto.getZipcode(),mdto.getAddress1(), mdto.getAddress2(), mdto.getId());
	}
	
	public String findId(MembersDTO mdto) {
		String sql = "select id from members where name=? and email=?";
		try {
			return jdbc.queryForObject(sql, String.class, mdto.getName(), mdto.getEmail());
		} catch (EmptyResultDataAccessException e) {
			return null;
		}	
	}
	
	public MembersDTO findEmail(String id, String email) {
		String sql = "select * from members where id=? and email=?";
		try {
			return jdbc.queryForObject(sql, new BeanPropertyRowMapper<MembersDTO>(MembersDTO.class), id, email);
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	public int updatePassword(String id, String pw) {
		
	    String sql = "update members set pw=? where id=?";

	    return jdbc.update(sql, pw, id);
	}
	
	public List<MileageHistoryDTO> mileageHistory(String memberId) {
	    String sql = "SELECT * FROM MILEAGE_HISTORY WHERE MEMBER_ID = ? ORDER BY REG_DATE DESC, SEQ DESC";
	    return jdbc.query(sql, new BeanPropertyRowMapper<>(MileageHistoryDTO.class), memberId);
	}
	
	// 마일리지 내역 페이지별 조회
	public List<MileageHistoryDTO> mileageHistory(String memberId, int cpage, int pagesize) {
	    int start = (cpage - 1) * pagesize + 1;
	    int end = cpage * pagesize;
	    String sql = "SELECT * FROM ("
	            + "SELECT mh.*, ROW_NUMBER() OVER (ORDER BY REG_DATE DESC, SEQ DESC) AS rn "
	            + "FROM MILEAGE_HISTORY mh WHERE MEMBER_ID = ?"
	            + ") WHERE rn BETWEEN ? AND ?";
	    return jdbc.query(sql, new BeanPropertyRowMapper<>(MileageHistoryDTO.class), memberId, start, end);
	}

	// 마일리지 내역 전체 개수
	public int mileageHistoryCount(String memberId) {
	    String sql = "SELECT COUNT(*) FROM MILEAGE_HISTORY WHERE MEMBER_ID = ?";
	    return jdbc.queryForObject(sql, Integer.class, memberId);
	}
	
	//전체 회원 수 조회
	public int totalMembers() {
		String sql = "select count(*) from members where role = 'user'";
		return jdbc.queryForObject(sql, Integer.class);
	}
}
