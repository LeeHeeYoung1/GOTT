package com.kedu.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.commons.EncryptionUtils;
import com.kedu.dto.MembersDTO;

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
	
	public int signup(MembersDTO mdto) {
		String sql = "insert into members values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, systimestamp, 0)";
		return jdbc.update(sql, mdto.getId(), mdto.getPw(), mdto.getName(), mdto.getNickname()
				, mdto.getPhone(), mdto.getEmail(), mdto.getGender(), mdto.getDob(), mdto.getZipcode()
				, mdto.getAddress1(), mdto.getAddress2());
		
	}
	
	public int deleted(String id, String pw) {
	    String sql = "delete from members where id = ? and pw = ?";
	    return jdbc.update(sql, id, pw);
	}

}
